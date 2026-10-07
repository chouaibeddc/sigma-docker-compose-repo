const { dbClient } = require('../database/connection');

class DatatypeMappingObjectAPI {
    static cache: Record<string, string[]> = {};

    /**
     * Load all required settings into memory.
     * Call this once before starting the Express server.
     */
    static async initialize(): Promise<void> {
        const requiredSettings = ['PAYMENT_METHODS', 'TRANSACTION_TYPE'];

        try {
            const results = await Promise.all(
                requiredSettings.map((key) => this.getSettingJsonKeys(key)),
            );

            requiredSettings.forEach((key, index) => {
                this.cache[key] = results[index] ?? [];
            });

            console.log('Datatype mapping cache initialized.');
        } catch (error: any) {
            throw new Error(
                `Failed to initialize datatype mapping cache: ${error.message}`,
            );
        }
    }

    /**
     * Returns the cached keys.
     */
    static getCachedKeys(key: string): string[] {
        return this.cache[key] ?? [];
    }

    /**
     * Returns the JSON object stored in settings.val_
     */
    static async getSettingJson(
        key: string,
    ): Promise<Record<string, any> | null> {
        try {
            const result = await dbClient.query(
                'SELECT val_ FROM settings WHERE key_ = $1',
                [key],
            );

            if (result.rows.length === 0) {
                return null;
            }

            const value = result.rows[0].val_;

            if (value === null || value === undefined || value === '') {
                return null;
            }

            if (typeof value === 'object') {
                return value;
            }

            if (typeof value !== 'string') {
                throw new Error(
                    `Expected a string but received ${typeof value}.`,
                );
            }

            return JSON.parse(value.trim());
        } catch (error: any) {
            throw new Error(
                `Failed to retrieve JSON setting "${key}": ${error.message}`,
            );
        }
    }

    /**
     * Returns the property names of the JSON object.
     */
    static async getSettingJsonKeys(key: string): Promise<string[] | null> {
        try {
            const json = await this.getSettingJson(key);

            if (json === null) {
                return null;
            }

            return Object.keys(json);
        } catch (err) {
            console.error(err);
            return null;
        }
    }
}

module.exports = DatatypeMappingObjectAPI;
