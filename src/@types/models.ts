// =====================================================
// TYPES PRINCIPAUX (Based on tables)
// =====================================================

export interface User {
    id: string; // UUID
    username: string;
    password_hash: string;
    role: string;
    privileges: string[]; // TEXT[]
    is_active: boolean;
    created_at: Date;
    updated_at: Date;
    createdbyuserid?: string | null; // UUID
    updatedbyuserid?: string | null; // UUID
    last_login?: Date | null;
    profile_image?: string | null;
}

export interface Client {
    clientid: string; // 'CLI' + seq (13 caractères)
    clienttype?: string | null;
    clientnom?: string | null;
    clientprenom?: string | null;
    clientraisonsociale?: string | null;
    clientformjuridique?: string | null;
    clientice?: string | null; // CHAR(15)
    clientif?: string | null;
    clientrc?: string | null;
    clientemail?: string | null;
    clienttel1?: string | null;
    clienttel2?: string | null;
    clientpays?: string | null;
    clientville?: string | null;
    clientadresse?: string | null;
    clientstatus?: string | null; // ex: 'actif', 'inactif'
    clientnotes?: string | null;
    clientcreatedat?: Date | null;
    clientcreatedbyuserid?: string | null; // UUID
    clientlasteditat?: Date | null;
    clientlasteditbyuserid?: string | null; // UUID
    participantid?: string | null; // FK vers Participant
}

export interface Vehicle {
    vehicleid: string; // 'VEH' + seq (13 caractères)
    vehiclematricule?: string | null;
    vehicletype?: string | null;
    vehicleconstructeur?: string | null;
    vehiclemodele?: string | null;
    vehicleannee?: number | null; // SMALLINT
    vehiclecarburant?: string | null;
    vehicletransmission?: string | null;
    vehiclekilometrage?: number | null; // INT
    vehiclecouleur?: string | null;
    vehiclestatus?: string | null;
    vehiclenotes?: string | null;
    vehiclecreatedat?: Date | null;
    vehiclecreatedbyuserid?: string | null; // UUID
    vehiclelasteditat?: Date | null;
    vehiclelasteditbyuserid?: string | null; // UUID
    clientid?: string | null; // FK vers Client
}

export interface Employee {
    employeeid: string; // 'EMP' + seq (13 caractères)
    employeenom?: string | null;
    employeeprenom?: string | null;
    employeecin?: string | null;
    employeedatenaissance?: Date | null;
    employeepays?: string | null;
    employeeville?: string | null;
    employeeaddress?: string | null;
    employeetel?: string | null;
    employeeemail?: string | null;
    employeedatedeRecrutement?: Date | null;
    employeerole?: string | null;
    employeesalairenet?: number | null; // NUMERIC
    employeematriculation_amo?: string | null;
    employeestatusfamilliale?: string | null;
    employeenbrenFant?: number | null; // SMALLINT
    employeestatus?: string | null;
    employeenotes?: string | null;
    employeecreatedat?: Date | null;
    employeecreatedbyuserid?: string | null; // UUID
    employeelasteditat?: Date | null;
    employeelasteditbyuserid?: string | null; // UUID
    participantid?: string | null; // FK vers Participant
}

export interface ServiceArticle {
    servicearticleid: string; // 'SAR' + seq (13 caractères)
    servicearticlecategory?: string | null;
    servicearticletitle?: string | null;
    servicearticledescription?: string | null;
    servicearticlepriceht?: number | null; // NUMERIC
    servicearticleactif?: boolean | null;
    servicearticlecreatedat?: Date | null;
    servicearticlecreatedbyuserid?: string | null; // UUID
    servicearticlelasteditat?: Date | null;
    servicearticlelasteditbyuserid?: string | null; // UUID
}

export interface Reduction {
    reductionid: string; // 'RED' + seq (13 caractères)
    reductiontitle?: string | null;
    reductiondescription?: string | null;
    reductionpourcentage?: number | null; // NUMERIC
    reductionfor?: string | null; // ex: 'client', 'vehicle'
    reductionstatus?: string | null;
    reductionauto?: boolean | null;
    reductionminhtamount?: number | null; // NUMERIC
    reductionmaxhtamount?: number | null; // NUMERIC
    reductioncreatedat?: Date | null;
    reductioncreatedbyuserid?: string | null; // UUID
    reductionlasteditat?: Date | null;
    reductionlasteditbyuserid?: string | null; // UUID
}

export interface Produit {
    produitid: string; // 'PRD' + seq (13 caractères)
    produitcategory?: string | null;
    produitname?: string | null;
    produitdescription?: string | null;
    produitprixuht?: number | null; // NUMERIC
    produitqtestock?: number | null; // INT
    produitseuillalerte?: number | null; // INT
    produitcreatedat?: Date | null;
    produitcreatedbyuserid?: string | null; // UUID
    produitlasteditat?: Date | null;
    produitlasteditbyuserid?: string | null; // UUID
}

export interface Fournisseur {
    fournisseurid: string; // 'FRN' + seq (13 caractères)
    fournisseurRaisonsociale?: string | null;
    fournisseurice?: string | null; // CHAR(15)
    fournisseurif?: string | null;
    fournisseurrc?: string | null;
    fournisseuremail?: string | null;
    fournisseuremail2?: string | null;
    fournisseurtel1?: string | null;
    fournisseurtel2?: string | null;
    fournisseuradresse?: string | null;
    fournisseurpays?: string | null;
    fournisseurville?: string | null;
    fournisseurwebsite?: string | null;
    fournisseurcreatedat?: Date | null;
    fournisseurcreatedbyuserid?: string | null; // UUID
    fournisseurlasteditat?: Date | null;
    fournisseurlasteditbyuserid?: string | null; // UUID
    participantid?: string | null; // FK vers Participant
}

export interface Participant {
    participantid: string; // 'PAR' + seq (13 caractères)
    participantname?: string | null;
    participanttype?: string | null; // ex: 'client', 'employee', 'fournisseur'
    participantbank?: string | null;
    participantrib?: string | null; // CHAR(24)
    participantlinked?: boolean | null;
    participantcreatedat?: Date | null;
    participantcreatedbyuserid?: string | null; // UUID
    participantlasteditat?: Date | null;
    participantlasteditbyuserid?: string | null; // UUID
}

export interface Transaction_ {
    transactionid: string; // 'TRX' + seq (17 caractères)
    transactiontype?: string | null;
    transactionpaymentmethod?: string | null;
    transactionmountantht?: number | null; // NUMERIC
    transactiontvarate?: number | null; // NEW
    transactionfees?: number | null; // NEW (Uncommented)
    transactionfeestvarate?: number | null;
    transactiontvadeclaredat?: Date | null;
    transactiondescription?: string | null;
    transactionMetaZZ: boolean;
    transactioncreatedat?: Date | null;
    transactioncreatedbyuserid?: string | null; // UUID
    participantid?: string | null; // FK vers Participant
}

export interface Service {
    serviceid: string; // 'SRV' + seq (13 caractères)
    servicelieu?: string | null;
    servicenotes?: string | null;
    serviceMetaZZ: boolean;
    servicestatus?: string | null;
    servicecreatedat?: Date | null;
    servicecreatedbyuserid?: string | null; // UUID
    serviceclientid?: string | null; // FK vers Client
    servicevehicleid?: string | null; // FK vers Vehicle
    servicefactureid?: string | null; // FK vers Facture
}

export interface Facture {
    factureid: string; // 'FAC' + seq (13 caractères)
    facturedate?: Date | null;
    facturestatus?: string | null;
    facturetvarate?: number | null; // NEW
    facturereductionid?: string | null; // NEW
    facturereductionpourcentage?: number | null;
    facturenotes?: string | null;
    factureMetaZZ: boolean;
    facturecreatedat?: Date | null;
    facturecreatedbyuserid?: string | null; // UUID
}

export interface Caisse {
    caisseid: string;
    caissename: string;
    caissemountant: number;
    caissemetaZZ: boolean;
    caisselasteditbyuserid: string | null;
    caisselasteditat: Date | null;
}

// =====================================================
// TABLES DE LIAISON (MANY-TO-MANY)
// =====================================================
export interface Fournir {
    fournisseurid: string; // FK
    produitid: string; // FK
    articleprodid__fournir?: string | null;
    articleprixuht__fournir?: number | null;
    articledelaideLivraison_fournir?: number | null; // INT
}

export interface EstPayerPar {
    factureid: string; // FK
    transactionid: string; // FK (17 caractères)
}

export interface ComprendreProduit {
    serviceid: string; // Handles both 'SRV...' and 'SRVN...'
    produitid: string;
    produitvenduqte_comprendreproduit?: number | null; // INT
    produitprixuhtvende?: number | null; // NEW: Selling price at the time of service
}

export interface ComprendreService {
    serviceid: string; // Handles both 'SRV...' and 'SRVN...'
    servicearticleid: string;
    servicearticlenotes_comprendreservice?: string | null;
    serviceprixhtprestation?: number | null; // NEW: Service price at the time of service
}

export interface Intervenir {
    employeeid: string; // FK
    serviceid: string; // FK
    employeeservicenotes_intervenir?: string | null;
}

// =====================================================
// Entity Config For the Controller
// =====================================================
export interface EntityPropConfig {
    prop: string;
    label: string;
    actions: number;
    type?: string;
    order?: number;
}

export interface EntityConfig {
    table: string;
    entityTitle: string;
    titleAction?: string;
    idField: string;
    createdByField: string;
    lastEditByField: string;
    createdAtField: string;
    lastEditAtField: string;
    entityPropsConfig: EntityPropConfig[];
    requiredFields: string[];
    immutableFields: string[];
    noEdit?: boolean;
    noCreate?: boolean;
}

// =====================================================
// TYPES UTILITAIRES (pour la création, mise à jour, etc.)
// =====================================================

export type CreateUser = Omit<User, 'id' | 'created_at' | 'updated_at'> & {
    id?: string;
    created_at?: Date;
    updated_at?: Date;
};

export type CreateClient = Omit<
    Client,
    'clientid' | 'clientcreatedat' | 'clientlasteditat'
> & {
    clientid?: string;
    clientcreatedat?: Date;
    clientlasteditat?: Date;
};

// =====================================================
// TYPES AVEC RELATIONS
// =====================================================

export interface ClientWithRelations extends Client {
    vehicles?: Vehicle[];
    participant?: Participant | null;
    services?: Service[];
}

export interface ServiceWithRelations extends Service {
    client?: Client | null;
    vehicle?: Vehicle | null;
    facture?: Facture | null;
    produits?: (ComprendreProduit & { produit: Produit })[];
    servicesArticles?: (ComprendreService & {
        serviceArticle: ServiceArticle;
    })[];
    employees?: (Intervenir & { employee: Employee })[];
}

export interface FactureWithRelations extends Facture {
    reductions?: Reduction[];
    transactions?: Transaction_[];
    services?: Service[];
}
