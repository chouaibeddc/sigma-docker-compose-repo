import type { Response, NextFunction } from "express";
import type { AuthenticatedRequest } from "../@types/express/authenticatedRequest";

const { Logger } = require("./logger");

/**
 * Middleware to log incoming requests and their responses.
 */
const requestLogger = (
  req: AuthenticatedRequest & { requestId?: string },
  res: Response,
  next: NextFunction,
) => {
  const start = Date.now();

  res.on("finish", () => {
    const duration = Date.now() - start;

    // Sanitize URL to prevent logging tokens/passwords in query params
    const sanitizedUrl = req.originalUrl.replace(
      /(password|token|secret|auth|key)=([^&]+)/gi,
      "$1=***",
    );

    Logger.access(`${req.method} ${sanitizedUrl}`, {
      requestId: req.requestId,
      userId: req.user?.userId,
      Method: req.method,
      Url: sanitizedUrl,
      StatusCode: res.statusCode,
      ResponseTime: `${duration}ms`,
      IP: req.ip,
      UserAgent: req.get("user-agent"),
    });
  });

  next();
};

module.exports = { requestLogger };
