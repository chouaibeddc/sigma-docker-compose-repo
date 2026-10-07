import type { Response, NextFunction } from "express";
import type { AuthenticatedRequest } from "../@types/express/authenticatedRequest";

const { Logger } = require("./logger");

/**
 * Global Express error handling middleware.
 */
const errorLogger = (
  err: any,
  req: AuthenticatedRequest & { requestId?: string },
  res: Response,
  next: NextFunction,
) => {
  if (res.headersSent) {
    return next(err);
  }

  const statusCode = err.statusCode || 500;

  Logger.error(err.message || "Internal Server Error", {
    requestId: req.requestId,
    userId: req.user?.userId,
    Method: req.method,
    Url: req.originalUrl,
    Stack: err.stack,
    Body: req.body,
    Query: req.query,
    Params: req.params,
  });

  res.status(statusCode).json({
    error: {
      message: err.message || "Internal Server Error",
    },
  });
};

module.exports = { errorLogger };
