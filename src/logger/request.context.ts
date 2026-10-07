import type { Response, NextFunction } from 'express';
import type { AuthenticatedRequest } from '../@types/express/authenticatedRequest';

const crypto = require('crypto');

/**
 * Middleware to attach a unique requestId to every request.
 */
const requestContext = (
    req: AuthenticatedRequest & { requestId?: string },
    res: Response,
    next: NextFunction,
) => {
    const headerId = req.headers['x-request-id'];
    // Handle cases where headers might be arrays
    const existingId = Array.isArray(headerId) ? headerId[0] : headerId;

    req.requestId = existingId || crypto.randomUUID();
    next();
};

module.exports = { requestContext };
