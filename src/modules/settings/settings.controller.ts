import type { Response, NextFunction } from 'express';
import type { AuthenticatedRequest } from '../../@types/express/authenticatedRequest';

//  Destructuring pour récupérer directement l'instance dbClient
// au lieu de l'objet module entier { dbClient, connect }
const { dbClient } = require('../../database/connection');
const DatatypeMappingObjectAPI = require('../../api/datatype.mapping.object.api');

// const getSettingsByKeysArray = async (
//     keys: string[],
// ): Promise<Record<string, string>> => {
//     if (!keys || keys.length === 0) return {};
//     try {
//         const result = await dbClient.query(
//             'SELECT key_, val_ FROM settings WHERE key_ = ANY($1)',
//             [keys],
//         );
//         const config: Record<string, string> = {};
//         result.rows.forEach((row: any) => {
//             config[row.key_] = row.val_;
//         });
//         console.log(config);
//         return config;
//     } catch (error) {
//         console.error('Error fetching internal settings array:', error);
//         throw error;
//     }
// };

const getSettingsByKeysArray = async (
    keys: string[],
): Promise<Record<string, string>> => {
    if (!keys || keys.length === 0) return {};
    try {
        // Add ::text[] cast right here
        const result = await dbClient.query(
            'SELECT key_, val_ FROM settings WHERE key_ = ANY($1::text[])',
            [keys],
        );
        const config: Record<string, string> = {};
        result.rows.forEach((row: any) => {
            config[row.key_] = row.val_;
        });
        return config;
    } catch (error) {
        // This will print the actual underlying driver error to your terminal console
        throw error;
    }
};

exports.getSettings = async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction,
) => {
    try {
        const result = await dbClient.query('SELECT key_, val_ FROM settings');
        const settings: Record<string, string> = {};

        // Transformation en objet { KEY: "value" }
        result.rows.forEach((row: any) => {
            settings[row.key_] = row.val_;
        });

        res.json(settings);
    } catch (error) {
        next(error);
    }
};

exports.getSettingsByKey = async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction,
) => {
    try {
        const result = await dbClient.query(
            'SELECT key_, val_ FROM settings WHERE key_ = $1',
            [req.params.key],
        );
        const settings: Record<string, string> = {};

        // Transformation en objet { KEY: "value" }
        result.rows.forEach((row: any) => {
            settings[row.key_] = row.val_;
        });

        res.json(settings);
    } catch (error) {
        next(error);
    }
};

exports.getBulkSettings = async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction,
) => {
    try {
        const { keys } = req.body;
        if (!keys || !Array.isArray(keys)) {
            return res
                .status(400)
                .json({ error: 'Missing parameter "keys" as an array' });
        }

        const settingsData = await getSettingsByKeysArray(keys);
        res.json(settingsData);
    } catch (error) {
        next(error);
    }
};

exports.updateSettings = async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction,
) => {
    try {
        const settings = req.body; // Reçoit l'objet complet { KEY: "value", ... }

        // Utilisation d'une transaction pour la sécurité
        await dbClient.query('BEGIN');

        for (const key of Object.keys(settings)) {
            const value = settings[key];
            // INSERT ... ON CONFLICT DO UPDATE (Upsert)
            await dbClient.query(
                `INSERT INTO settings (key_, val_) VALUES ($1, $2) 
                 ON CONFLICT (key_) DO UPDATE SET val_ = EXCLUDED.val_`,
                [key, value],
            );
        }

        await dbClient.query('COMMIT');
        res.json({ success: true, message: 'Settings updated successfully' });
    } catch (error) {
        await dbClient.query('ROLLBACK');
        next(error);
    }
};

exports.getDatatypeMappingObject = async (
    req: AuthenticatedRequest,
    res: Response,
    next: NextFunction,
) => {
    try {
        const key = req.params.key;

        if (!key || typeof key !== 'string' || !key.trim()) {
            return res.status(400).json({
                error: 'Missing or invalid parameter "key".',
            });
        }

        const mapping = await DatatypeMappingObjectAPI.getSettingJson(
            key.toUpperCase(),
        );

        if (mapping === null) {
            return res.status(404).json({
                error: `Setting "${key}" not found.`,
            });
        }

        res.status(200).json(mapping);
    } catch (error: any) {
        next(error);
    }
};
