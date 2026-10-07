import { Role, Privileges } from '../index'; // Path to your enums

export {};

declare global {
    namespace Express {
        // This MUST be 'interface Request', not 'type Request'
        export interface Request {
            user?: {
                userId: user.id;
                privileges: privileges.Privileges;
                role: userModel.UserRole;
            };
        }
    }
}
