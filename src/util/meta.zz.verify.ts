import type { AuthenticatedRequest } from '../@types/express/authenticatedRequest';
const { Privilege_enum } = require('../@types/index');
exports.verifyMetaZZ = (req: AuthenticatedRequest): boolean =>
    req?.user?.privileges?.includes(Privilege_enum.SUPER) || false;
