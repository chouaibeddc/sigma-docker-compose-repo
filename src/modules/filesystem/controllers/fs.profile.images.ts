import type { Response, NextFunction } from 'express';
import type { AuthenticatedRequest } from '../../../@types/express/authenticatedRequest';
import console = require('node:console');

const path = require('path');
const fileUpload = require('express-fileupload');
const fs = require('fs');
const fsBasic = require('./fs.basic');

/* This controller is created to handle Profile images routes */

exports.upload_profile_image = (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction,
) => {};

// To access to default images, you should use "default%5C"
exports.load_profile_image = (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction,
) => {
  fsBasic.load(req, res, next, 'profile_images/');
};
