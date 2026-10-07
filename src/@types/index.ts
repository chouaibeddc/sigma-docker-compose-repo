/**
 * Global Enums / Types for the System (SIGMA)
 * Define these here so they can be shared across Models, Middleware, and Controllers.
 */

/* Privilege Type */
enum Privilege_enum {
    SUPER = 'SUPER',
    /* Admin Privileges */
    MANAGE_USERS = 'MANAGE_USERS',
    MANAGE_SETTINGS = 'MANAGE_SETTINGS',

    /* Manage Services */
    GET_ALL_SERVICES = 'GET_ALL_SERVICES',
    GET_SERVICES = 'GET_SERVICES',
    /* Manage Entitys */
    MANAGE_ENTITY = 'MANAGE_ENTITY',
    MANAGE_CLIENT = 'MANAGE_CLIENT',
    MANAGE_VEHICLE = 'MANAGE_VEHICLE',
    MANAGE_EMPLOYEE = 'MANAGE_EMPLOYEE',
    MANAGE_FOURNISSEUR = 'MANAGE_FOURNISSEUR',

    MANAGE_SERVICEARTICLE = 'MANAGE_SERVICEARTICLE',
    MANAGE_PRODUIT = 'MANAGE_PRODUIT',
    MANAGE_REDUCTION = 'MANAGE_REDUCTION',

    GET_TRANSACTION = 'GET_TRANSACTION',
    CREAT_TRANSACTION = 'CREAT_TRANSACTION',
    GET_CAISSE = 'GET_CAISSE',

    MANAGE_FINANCE = 'MANAGE_FINANCE',
    MANAGE_PARTICIPANT = 'MANAGE_PARTICIPANT',

    CREAT_ORDER = 'CREAT_ORDER',
}

export type Privilege = Privilege_enum;
export type Privileges = Privilege[];

/* Role Type */
enum Role_enum {
    ADMIN = 'ADMIN',
    MANAGER = 'MANAGER',
    ACCOUNTANT = 'ACCOUNTANT',
    TECHNICIAN = 'TECHNICIAN',
}

export type Role = Role_enum;
module.exports = { Privilege_enum };
