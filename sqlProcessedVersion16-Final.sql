-- Enable pgcrypto extension for UUID generation (built-in for PG 13+, but safe to include)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- SEQUENCES
-- =====================================================
CREATE SEQUENCE IF NOT EXISTS seq_client START 1;
CREATE SEQUENCE IF NOT EXISTS seq_vehicle START 1;
CREATE SEQUENCE IF NOT EXISTS seq_employee START 1;
CREATE SEQUENCE IF NOT EXISTS seq_fournisseur START 1;
CREATE SEQUENCE IF NOT EXISTS seq_service_article START 1;
CREATE SEQUENCE IF NOT EXISTS seq_reduction START 1;
CREATE SEQUENCE IF NOT EXISTS seq_produit START 1;
CREATE SEQUENCE IF NOT EXISTS seq_service START 1;
CREATE SEQUENCE IF NOT EXISTS seq_facture START 1;
CREATE SEQUENCE IF NOT EXISTS seq_transaction START 1;
CREATE SEQUENCE IF NOT EXISTS seq_participant START 1;
CREATE SEQUENCE IF NOT EXISTS seq_caisse START 1;
-- =====================================================
-- 1. NEW SEQUENCES FOR METAZZ ENTITIES
-- =====================================================
CREATE SEQUENCE IF NOT EXISTS seq_facture_metazz START 1;
CREATE SEQUENCE IF NOT EXISTS seq_service_metazz START 1;
CREATE SEQUENCE IF NOT EXISTS seq_transaction_metazz START 1;

-- ============================================================
--  SETTINGS TABLE
-- ============================================================

DROP TABLE IF EXISTS settings CASCADE;
CREATE TABLE settings (
	key_ VARCHAR(50) NOT NULL PRIMARY KEY,
	val_ TEXT
);

-- Insertion des valeurs par défaut
INSERT INTO settings (key_, val_) VALUES
('NOM_GARAGE', 'Mon Garage'),
('SLOGAN', 'Votre partenaire automobile de confiance'),
('ICE', '000000000000000'),
('IF', '00000000'),
('RC', '000000'),
('PATENTE', '00000000'),
('ADDRESSE', '123 Rue de l''Automobile'),
('VILLE', 'Casablanca'),
('CODE_POSTAL', '20000'),
('PATYS', 'Maroc'), -- Gardé tel quel pour correspondre à votre demande
('TEL1', '+212 5 22 00 00 00'),
('TEL2', '+212 6 00 00 00 00'),
('EMAIL', 'contact@mongarage.ma'),
('WEBSITE', 'https://mongarage.ma'),
('DEVICE', 'Desktop'),
('TVA_RATE', '20'),
('LOGO', 'https://via.placeholder.com/150'),
('FACTURE_TEMPLATE', '<!DOCTYPE html><html><head><title>Facture</title></head><body><h1>Facture</h1></body></html>'),
('DEVIS_TEMPLATE', '<!DOCTYPE html><html><head><title>Devis</title></head><body><h1>Devis</h1></body></html>'),
('RELEVE_TEMPLATE', '<!DOCTYPE html><html><head><title>Bilan</title></head><body><h1>Bilan</h1></body></html>'),
('RECU_TEMPLATE', '<!DOCTYPE html><html><head><title>Reçu</title></head><body><h1>Reçu</h1></body></html>'),
('PAYMENT_METHODS','{"Cash": "Espèces","Transfer": "Virement","Cheque": "Chèque","Card": "Carte","Mobile": "Mobile","Wallet": "Portefeuille","Voucher": "Bon","Crypto": "Crypto"}'),
('TRANSACTION_TYPE','{"Expense":"Dépense","Revenue+":"Revenu"}');

-- =====================================================
-- TABLE users (avec clé primaire)
-- =====================================================
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL,
    privileges TEXT[] DEFAULT '{}'::text[],
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    createdByUserID UUID,
    updatedByUserID UUID,
    last_login TIMESTAMP WITHOUT TIME ZONE,
    profile_image TEXT,
    employee_id VARCHAR(13)
);

-- =====================================================
-- TABLE Client
-- =====================================================
DROP TABLE IF EXISTS Client CASCADE;
CREATE TABLE Client (
    ClientID VARCHAR(13) PRIMARY KEY DEFAULT (
        'CLI' || LPAD(nextval('seq_client')::text, 10, '0')
    ),
    ClientType VARCHAR(20),
    ClientNom VARCHAR(60),
    ClientPrenom VARCHAR(60),
    ClientRaisonSociale VARCHAR(150),
    ClientFormJuridique VARCHAR(50),
    ClientICE CHAR(15),
    ClientIF VARCHAR(30),
    ClientRC VARCHAR(30),
    ClientEmail VARCHAR(130),
    ClientTel1 VARCHAR(20),
    ClientTel2 VARCHAR(20),
    ClientPays VARCHAR(50),
    ClientVille VARCHAR(50),
    ClientAdresse VARCHAR(255),
    ClientStatus VARCHAR(20),
    ClientNotes TEXT,
    ClientCreatedAt TIMESTAMP,
    ClientCreatedByUserID UUID,
    ClientLastEditAt TIMESTAMP,
    ClientLastEditByUserID UUID,
    ParticipantID VARCHAR(13)
);

-- =====================================================
-- TABLE Vehicle
-- =====================================================
DROP TABLE IF EXISTS Vehicle CASCADE;
CREATE TABLE Vehicle (
    VehicleID VARCHAR(13) PRIMARY KEY DEFAULT (
        'VEH' || LPAD(nextval('seq_vehicle')::text, 10, '0')
    ),
    VehicleMatricule VARCHAR(20),
    VehicleType VARCHAR(30),
    VehicleConstructeur VARCHAR(50),
    VehicleModele VARCHAR(50),
    VehicleAnnee SMALLINT,
    VehicleCarburant VARCHAR(15),
    VehicleTransmission VARCHAR(15),
    VehicleKilometrage INT,
    VehicleCouleur VARCHAR(30),
    VehicleStatus VARCHAR(20),
    VehicleNotes TEXT,
    VehicleCreatedAt TIMESTAMP,
    VehicleCreatedByUserID UUID,
    VehicleLastEditAt TIMESTAMP,
    VehicleLastEditByUserID UUID,
    ClientID VARCHAR(13)
);

-- =====================================================
-- TABLE Employee (correction faute de frappe)
-- =====================================================
DROP TABLE IF EXISTS Employee CASCADE;
CREATE TABLE Employee (
    EmployeeID VARCHAR(13) PRIMARY KEY DEFAULT (
        'EMP' || LPAD(nextval('seq_employee')::text, 10, '0')
    ),
    EmployeeNom VARCHAR(60),
    EmployeePrenom VARCHAR(60),
    EmployeeCIN VARCHAR(15),
    EmployeeDateNaissance DATE,
    EmployeePays VARCHAR(50),
    EmployeeVille VARCHAR(50),
    EmployeeAddress VARCHAR(255),
    EmployeeTel VARCHAR(20),
    EmployeeEmail VARCHAR(130),
    EmployeeDateDeRecrutement DATE,   -- corrigé
    EmployeeRole VARCHAR(50),
    EmployeeSalaireNet NUMERIC,
    EmployeeMatriculationAMO VARCHAR(25),
    EmployeeStatusFamilliale VARCHAR(20),
    EmployeeNbrEnfant SMALLINT,
    EmployeeStatus VARCHAR(20),
    EmployeeNotes TEXT,
    EmployeeCreatedAt TIMESTAMP,
    EmployeeCreatedByUserID UUID,
    EmployeeLastEditAt TIMESTAMP,
    EmployeeLastEditByUserID UUID,
    ParticipantID VARCHAR(13)
);

-- =====================================================
-- TABLE ServiceArticle
-- =====================================================
DROP TABLE IF EXISTS ServiceArticle CASCADE;
CREATE TABLE ServiceArticle (
    ServiceArticleID VARCHAR(13) PRIMARY KEY DEFAULT (
        'SAR' || LPAD(nextval('seq_service_article')::text, 10, '0')
    ),
    ServiceArticleCategory VARCHAR(50),
    ServiceArticleTitle VARCHAR(150),
    ServiceArticleDescription TEXT,
    ServiceArticlePriceHT NUMERIC,
    ServiceArticleActif BOOLEAN,
    ServiceArticleCreatedAt TIMESTAMP,
    ServiceArticleCreatedByUserID UUID,
    ServiceArticleLastEditAt TIMESTAMP,
    ServiceArticleLastEditByUserID UUID
);

-- =====================================================
-- TABLE Reduction
-- =====================================================
DROP TABLE IF EXISTS Reduction CASCADE;
CREATE TABLE Reduction (
    ReductionID VARCHAR(13) PRIMARY KEY DEFAULT (
        'RED' || LPAD(nextval('seq_reduction')::text, 10, '0')
    ),
    ReductionTitle VARCHAR(100),
    ReductionDescription TEXT,
    ReductionPourcentage NUMERIC,
    ReductionFor VARCHAR(30),
    ReductionStatus VARCHAR(20),
    ReductionAuto BOOLEAN,
    ReductionMinHTAmount NUMERIC,
    ReductionMaxHTAmount NUMERIC,
    ReductionCreatedAt TIMESTAMP,
    ReductionCreatedByUserID UUID,
    ReductionLastEditAt TIMESTAMP,
    ReductionLastEditByUserID UUID
);

-- =====================================================
-- TABLE Produit
-- =====================================================
DROP TABLE IF EXISTS Produit CASCADE;
CREATE TABLE Produit (
    ProduitID VARCHAR(13) PRIMARY KEY DEFAULT (
        'PRD' || LPAD(nextval('seq_produit')::text, 10, '0')
    ),
    ProduitCategory VARCHAR(50),
    ProduitName VARCHAR(150),
    ProduitDescription TEXT,
    ProduitPrixUHT NUMERIC,
    ProduitQteStock INT,
    ProduitSeuilAlerte INT,
    ProduitCreatedAt TIMESTAMP,
    ProduitCreatedByUserID UUID,
    ProduitLastEditAt TIMESTAMP,
    ProduitLastEditByUserID UUID
);

-- =====================================================
-- TABLE Fournisseur
-- =====================================================
DROP TABLE IF EXISTS Fournisseur CASCADE;
CREATE TABLE Fournisseur (
    FournisseurID VARCHAR(13) PRIMARY KEY DEFAULT (
        'FRN' || LPAD(nextval('seq_fournisseur')::text, 10, '0')
    ),
    FournisseurRaisonSociale VARCHAR(150),
    FournisseurICE CHAR(15),
    FournisseurIF VARCHAR(30),
    FournisseurRC VARCHAR(30),
    FournisseurEmail VARCHAR(130),
    FournisseurEmail2 VARCHAR(130),
    FournisseurTel1 VARCHAR(20),
    FournisseurTel2 VARCHAR(20),
    FournisseurAdresse VARCHAR(255),
    FournisseurPays VARCHAR(50),
    FournisseurVille VARCHAR(50),
    FournisseurWebSite VARCHAR(255),
    FournisseurCreatedAt TIMESTAMP,
    FournisseurCreatedByUserID UUID,
    FournisseurLastEditAt TIMESTAMP,
    FournisseurLastEditByUserID UUID,
    ParticipantID VARCHAR(13)
);

-- =====================================================
-- TABLE Participant
-- =====================================================
DROP TABLE IF EXISTS Participant CASCADE;
CREATE TABLE Participant (
    ParticipantID VARCHAR(13) PRIMARY KEY DEFAULT (
        'PAR' || LPAD(nextval('seq_participant')::text, 10, '0')
    ),
    ParticipantName VARCHAR(150),
    ParticipantType VARCHAR(30),
    ParticipantBANK VARCHAR(100),
    ParticipantRIB CHAR(24),
    ParticipantLinked BOOLEAN,
    ParticipantCreatedAt TIMESTAMP,
    ParticipantCreatedByUserID UUID,
    ParticipantLastEditAt TIMESTAMP,
    ParticipantLastEditByUserID UUID
);

-- =====================================================
-- TABLE Transaction_ *:
-- =====================================================
DROP TABLE IF EXISTS Transaction_ CASCADE;
CREATE TABLE Transaction_ (
    TransactionID VARCHAR(17) PRIMARY KEY DEFAULT (
        'TRX' || LPAD(nextval('seq_transaction')::text, 14, '0')
    ),
    TransactionType VARCHAR(20),
    TransactionPaymentMethod VARCHAR(30),
    TransactionMountantHT NUMERIC,
    TransactionTVARate NUMERIC DEFAULT 20,
    TransactionFees NUMERIC DEFAULT 0,
    TransactionFeesTVARate NUMERIC DEFAULT 0,
    TransactionTVADeclaredAt TIMESTAMP,
    TransactionDescription TEXT,
    TransactionCreatedAt TIMESTAMP,
    TransactionCreatedByUserID UUID,
    ParticipantID VARCHAR(13)
);

-- Clone of Transaction_ (Prefix: TRXN, Length: 18)
DROP TABLE IF EXISTS TransactionMetaZZ CASCADE;
CREATE TABLE TransactionMetaZZ (
    TransactionID VARCHAR(18) PRIMARY KEY DEFAULT ('TRXN' || LPAD(nextval('seq_transaction_metazz')::text, 14, '0')),
    TransactionType VARCHAR(20),
    TransactionPaymentMethod VARCHAR(30),
    TransactionMountantHT NUMERIC,
    TransactionTVARate NUMERIC DEFAULT 20,
    TransactionFees NUMERIC DEFAULT 0,
    TransactionFeesTVARate NUMERIC DEFAULT 0,
    TransactionTVADeclaredAt TIMESTAMP,
    TransactionDescription TEXT,
    TransactionCreatedAt TIMESTAMP,
    TransactionCreatedByUserID UUID,
    ParticipantID VARCHAR(13)
);


-- =====================================================
-- TABLE Service *:
-- =====================================================
DROP TABLE IF EXISTS Service CASCADE;
CREATE TABLE Service (
    ServiceID VARCHAR(13) PRIMARY KEY DEFAULT (
        'SRV' || LPAD(nextval('seq_service')::text, 10, '0')
    ),
    ServiceLieu VARCHAR(100),
    ServiceNotes TEXT,
    ServiceStatus VARCHAR(30),
    ServiceCreatedAt TIMESTAMP,
    ServiceCreatedByUserID UUID,
    ServiceClientID VARCHAR(13),
    ServiceVehicleID VARCHAR(13),
    ServiceFactureID VARCHAR(13)
);

-- Clone of Service (Prefix: SRVN, Length: 14)
DROP TABLE IF EXISTS ServiceMetaZZ CASCADE;
CREATE TABLE ServiceMetaZZ (
    ServiceID VARCHAR(14) PRIMARY KEY DEFAULT ('SRVN' || LPAD(nextval('seq_service_metazz')::text, 10, '0')),
    ServiceLieu VARCHAR(100),
    ServiceNotes TEXT,
    ServiceStatus VARCHAR(30),
    ServiceCreatedAt TIMESTAMP,
    ServiceCreatedByUserID UUID,
    ServiceClientID VARCHAR(13),
    ServiceVehicleID VARCHAR(13),
    ServiceFactureID VARCHAR(14) -- References FactureMetaZZ
);

-- =====================================================
-- TABLE Facture *:
-- =====================================================
DROP TABLE IF EXISTS Facture CASCADE;
CREATE TABLE Facture (
    FactureID VARCHAR(13) PRIMARY KEY DEFAULT (
        'FAC' || LPAD(nextval('seq_facture')::text, 10, '0')
    ),
    FactureDate DATE,
    FactureStatus VARCHAR(20),
    FactureTVARate NUMERIC DEFAULT 20,
    FactureNotes TEXT,
    FactureCreatedAt TIMESTAMP,
    FactureCreatedByUserID UUID,
    FactureReductionID VARCHAR(13),
    FactureReductionPourcentage NUMERIC
);

-- Clone of Facture (Prefix: FACN, Length: 14)
DROP TABLE IF EXISTS FactureMetaZZ CASCADE;
CREATE TABLE FactureMetaZZ (
    FactureID VARCHAR(14) PRIMARY KEY DEFAULT ('FACN' || LPAD(nextval('seq_facture_metazz')::text, 10, '0')),
    FactureDate DATE,
    FactureStatus VARCHAR(20),
    FactureTVARate NUMERIC DEFAULT 20,
    FactureNotes TEXT,
    FactureCreatedAt TIMESTAMP,
    FactureCreatedByUserID UUID,
    FactureReductionID VARCHAR(13),
    FactureReductionPourcentage NUMERIC
);

-- =====================================================
-- TABLE Caisse
-- =====================================================
DROP TABLE IF EXISTS Caisse CASCADE;
CREATE TABLE Caisse (
    CaisseID VARCHAR(13) PRIMARY KEY DEFAULT (
        'CAI' || LPAD(nextval('seq_caisse')::text, 10, '0')
    ),
    CaisseName VARCHAR(64) NOT NULL,   
    CaisseMountant NUMERIC DEFAULT 0,
    CaisseMetaZZ boolean DEFAULT true,
    CaisseLastEditByUserId UUID ,     -- Owner of the card
    CaisseLastEditAt  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    -- Prevents duplicate card names for the same user
    CONSTRAINT unique_caisse_name_per_user UNIQUE (CaisseName)
);

-- =====================================================
-- TABLES DE LIAISON
-- =====================================================

DROP TABLE IF EXISTS Fournir CASCADE;
CREATE TABLE Fournir (
    FournisseurID VARCHAR(13) NOT NULL,
    ProduitID VARCHAR(13) NOT NULL,
    ArticleProdID__Fournir VARCHAR(64),
    ArticlePrixUHT__Fournir NUMERIC,
    ArticleDelaiDeLivraison_Fournir INT,
    PRIMARY KEY (FournisseurID, ProduitID)
);

DROP TABLE IF EXISTS estPayerPar CASCADE;
CREATE TABLE estPayerPar (
    FactureID VARCHAR(13) NOT NULL,
    TransactionID VARCHAR(17) NOT NULL,
    PRIMARY KEY (FactureID, TransactionID)
);


-- estPayerParMetaZZ (FactureMetaZZ <-> TransactionMetaZZ)
DROP TABLE IF EXISTS estPayerParMetaZZ CASCADE;
CREATE TABLE estPayerParMetaZZ (
    FactureID VARCHAR(14) NOT NULL,
    TransactionID VARCHAR(18) NOT NULL,
    PRIMARY KEY (FactureID, TransactionID)
);

DROP TABLE IF EXISTS ComprendreProduit CASCADE;
CREATE TABLE ComprendreProduit (
    ServiceID VARCHAR(13) NOT NULL,
    ProduitID VARCHAR(13) NOT NULL,
    ProduitVenduQte_ComprendreProduit INT,
    ProduitPrixUHTVende NUMERIC,
    PRIMARY KEY (ServiceID, ProduitID)
);

-- ComprendreProduitMetaZZ (ServiceMetaZZ <-> Produit)
DROP TABLE IF EXISTS ComprendreProduitMetaZZ CASCADE;
CREATE TABLE ComprendreProduitMetaZZ (
    ServiceID VARCHAR(14) NOT NULL,
    ProduitID VARCHAR(13) NOT NULL,
    ProduitVenduQte_ComprendreProduit INT,
    ProduitPrixUHTVende NUMERIC,
    PRIMARY KEY (ServiceID, ProduitID)
);

DROP TABLE IF EXISTS ComprendreService CASCADE;
CREATE TABLE ComprendreService (
    ServiceID VARCHAR(13) NOT NULL,
    ServiceArticleID VARCHAR(13) NOT NULL,
    ServiceArticleNotes_ComprendreService TEXT,
    ServicePrixHTPrestation NUMERIC,
    PRIMARY KEY (ServiceID, ServiceArticleID)
);

-- ComprendreServiceMetaZZ (ServiceMetaZZ <-> ServiceArticle)
DROP TABLE IF EXISTS ComprendreServiceMetaZZ CASCADE;
CREATE TABLE ComprendreServiceMetaZZ (
    ServiceID VARCHAR(14) NOT NULL,
    ServiceArticleID VARCHAR(13) NOT NULL,
    ServiceArticleNotes_ComprendreService TEXT,
    ServicePrixHTPrestation NUMERIC,
    PRIMARY KEY (ServiceID, ServiceArticleID)
);

DROP TABLE IF EXISTS Intervenir CASCADE;
CREATE TABLE Intervenir (
    EmployeeID VARCHAR(13) NOT NULL,
    ServiceID VARCHAR(13) NOT NULL,
    EmployeeServiceNotes_Intervenir TEXT,
    PRIMARY KEY (EmployeeID, ServiceID)
);

-- IntervenirMetaZZ (Employee <-> ServiceMetaZZ)
DROP TABLE IF EXISTS IntervenirMetaZZ CASCADE;
CREATE TABLE IntervenirMetaZZ (
    EmployeeID VARCHAR(13) NOT NULL,
    ServiceID VARCHAR(14) NOT NULL,
    EmployeeServiceNotes_Intervenir TEXT,
    PRIMARY KEY (EmployeeID, ServiceID)
);

-- =====================================================
-- CONTRAINTES DE CLÉ ÉTRANGÈRE
-- =====================================================

-- Participation
ALTER TABLE Client ADD CONSTRAINT FK_client_participant FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID);
ALTER TABLE Employee ADD CONSTRAINT FK_employee_participant FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID);
ALTER TABLE Fournisseur ADD CONSTRAINT FK_fournisseur_participant FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID);

-- Owner
ALTER TABLE Vehicle ADD CONSTRAINT FKID_Vehicle FOREIGN KEY (ClientID) REFERENCES Client (ClientID);

-- Service
ALTER TABLE Service ADD CONSTRAINT FKID_Client FOREIGN KEY (ServiceClientID) REFERENCES Client (ClientID);
ALTER TABLE Service ADD CONSTRAINT FK_vehicle_vehicleid_vehicle FOREIGN KEY (ServiceVehicleID) REFERENCES Vehicle (VehicleID);
ALTER TABLE Service ADD CONSTRAINT FK_facture_factureid_facture FOREIGN KEY (ServiceFactureID) REFERENCES Facture (FactureID);
ALTER TABLE Service ADD CONSTRAINT fk_service_created_by FOREIGN KEY (ServiceCreatedByUserID) REFERENCES users(id);

-- ServiceMetaZZ constraints
ALTER TABLE ServiceMetaZZ ADD CONSTRAINT FK_ServiceMetaZZ_Client FOREIGN KEY (ServiceClientID) REFERENCES Client (ClientID);
ALTER TABLE ServiceMetaZZ ADD CONSTRAINT FK_ServiceMetaZZ_Vehicle FOREIGN KEY (ServiceVehicleID) REFERENCES Vehicle (VehicleID);
ALTER TABLE ServiceMetaZZ ADD CONSTRAINT FK_ServiceMetaZZ_FactureMetaZZ FOREIGN KEY (ServiceFactureID) REFERENCES FactureMetaZZ (FactureID);
ALTER TABLE ServiceMetaZZ ADD CONSTRAINT fk_servicemetazz_created_by FOREIGN KEY (ServiceCreatedByUserID) REFERENCES users(id);


-- Facture 
ALTER TABLE Facture ADD CONSTRAINT FK_Facture_Reduction FOREIGN KEY (FactureReductionID) REFERENCES Reduction (ReductionID);
ALTER TABLE Facture ADD CONSTRAINT fk_facture_created_by FOREIGN KEY (FactureCreatedByUserID) REFERENCES users(id);

-- FactureMetaZZ constraints
ALTER TABLE FactureMetaZZ ADD CONSTRAINT FK_FactureMetaZZ_Reduction FOREIGN KEY (FactureReductionID) REFERENCES Reduction (ReductionID);
ALTER TABLE FactureMetaZZ ADD CONSTRAINT fk_facturemetazz_created_by FOREIGN KEY (FactureCreatedByUserID) REFERENCES users(id);


-- Foreign keys vers users (création et modification)
ALTER TABLE Client ADD CONSTRAINT fk_client_created_by FOREIGN KEY (ClientCreatedByUserID) REFERENCES users(id);
ALTER TABLE Client ADD CONSTRAINT fk_client_updated_by FOREIGN KEY (ClientLastEditByUserID) REFERENCES users(id);

ALTER TABLE Vehicle ADD CONSTRAINT fk_vehicle_created_by FOREIGN KEY (VehicleCreatedByUserID) REFERENCES users(id);
ALTER TABLE Vehicle ADD CONSTRAINT fk_vehicle_updated_by FOREIGN KEY (VehicleLastEditByUserID) REFERENCES users(id);

ALTER TABLE Employee ADD CONSTRAINT fk_employee_created_by FOREIGN KEY (EmployeeCreatedByUserID) REFERENCES users(id);
ALTER TABLE Employee ADD CONSTRAINT fk_employee_updated_by FOREIGN KEY (EmployeeLastEditByUserID) REFERENCES users(id);

ALTER TABLE ServiceArticle ADD CONSTRAINT fk_servicearticle_created_by FOREIGN KEY (ServiceArticleCreatedByUserID) REFERENCES users(id);
ALTER TABLE ServiceArticle ADD CONSTRAINT fk_servicearticle_updated_by FOREIGN KEY (ServiceArticleLastEditByUserID) REFERENCES users(id);

ALTER TABLE Reduction ADD CONSTRAINT fk_reduction_created_by FOREIGN KEY (ReductionCreatedByUserID) REFERENCES users(id);
ALTER TABLE Reduction ADD CONSTRAINT fk_reduction_updated_by FOREIGN KEY (ReductionLastEditByUserID) REFERENCES users(id);

ALTER TABLE Produit ADD CONSTRAINT fk_produit_created_by FOREIGN KEY (ProduitCreatedByUserID) REFERENCES users(id);
ALTER TABLE Produit ADD CONSTRAINT fk_produit_updated_by FOREIGN KEY (ProduitLastEditByUserID) REFERENCES users(id);

ALTER TABLE Fournisseur ADD CONSTRAINT fk_fournisseur_created_by FOREIGN KEY (FournisseurCreatedByUserID) REFERENCES users(id);
ALTER TABLE Fournisseur ADD CONSTRAINT fk_fournisseur_updated_by FOREIGN KEY (FournisseurLastEditByUserID) REFERENCES users(id);

ALTER TABLE Participant ADD CONSTRAINT fk_participant_created_by FOREIGN KEY (ParticipantCreatedByUserID) REFERENCES users(id);
ALTER TABLE Participant ADD CONSTRAINT fk_participant_updated_by FOREIGN KEY (ParticipantLastEditByUserID) REFERENCES users(id);

ALTER TABLE Transaction_ ADD CONSTRAINT fk_transaction_created_by FOREIGN KEY (TransactionCreatedByUserID) REFERENCES users(id);
ALTER TABLE Transaction_ ADD CONSTRAINT FKID_Transaction FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID);
-- TransactionMetaZZ constraints
ALTER TABLE TransactionMetaZZ ADD CONSTRAINT FK_TransactionMetaZZ_Participant FOREIGN KEY (ParticipantID) REFERENCES Participant (ParticipantID);
ALTER TABLE TransactionMetaZZ ADD CONSTRAINT fk_transactionmetazz_created_by FOREIGN KEY (TransactionCreatedByUserID) REFERENCES users(id);


-- Contraintes pour les tables de liaison (noms uniques)
ALTER TABLE Fournir ADD CONSTRAINT FK_Fournir_Fournisseur FOREIGN KEY (FournisseurID) REFERENCES Fournisseur (FournisseurID);
ALTER TABLE Fournir ADD CONSTRAINT FK_Fournir_Produit FOREIGN KEY (ProduitID) REFERENCES Produit (ProduitID);

ALTER TABLE estPayerPar ADD CONSTRAINT FK_estPayerPar_Facture FOREIGN KEY (FactureID) REFERENCES Facture (FactureID);
ALTER TABLE estPayerPar ADD CONSTRAINT FK_estPayerPar_Transaction FOREIGN KEY (TransactionID) REFERENCES Transaction_ (TransactionID);

-- estPayerParMetaZZ constraints
ALTER TABLE estPayerParMetaZZ ADD CONSTRAINT FK_estPayerParMetaZZ_Facture FOREIGN KEY (FactureID) REFERENCES FactureMetaZZ (FactureID);
ALTER TABLE estPayerParMetaZZ ADD CONSTRAINT FK_estPayerParMetaZZ_Transaction FOREIGN KEY (TransactionID) REFERENCES TransactionMetaZZ (TransactionID);


ALTER TABLE ComprendreProduit ADD CONSTRAINT FK_ComprendreProduit_Service FOREIGN KEY (ServiceID) REFERENCES Service (ServiceID);
ALTER TABLE ComprendreProduit ADD CONSTRAINT FK_ComprendreProduit_Produit FOREIGN KEY (ProduitID) REFERENCES Produit (ProduitID);

-- ComprendreProduitMetaZZ constraints
ALTER TABLE ComprendreProduitMetaZZ ADD CONSTRAINT FK_ComprendreProduitMetaZZ_Service FOREIGN KEY (ServiceID) REFERENCES ServiceMetaZZ (ServiceID);
ALTER TABLE ComprendreProduitMetaZZ ADD CONSTRAINT FK_ComprendreProduitMetaZZ_Produit FOREIGN KEY (ProduitID) REFERENCES Produit (ProduitID);


ALTER TABLE ComprendreService ADD CONSTRAINT FK_ComprendreService_Service FOREIGN KEY (ServiceID) REFERENCES Service (ServiceID);
ALTER TABLE ComprendreService ADD CONSTRAINT FK_ComprendreService_ServiceArticle FOREIGN KEY (ServiceArticleID) REFERENCES ServiceArticle (ServiceArticleID);

-- ComprendreServiceMetaZZ constraints
ALTER TABLE ComprendreServiceMetaZZ ADD CONSTRAINT FK_ComprendreServiceMetaZZ_Service FOREIGN KEY (ServiceID) REFERENCES ServiceMetaZZ (ServiceID);
ALTER TABLE ComprendreServiceMetaZZ ADD CONSTRAINT FK_ComprendreServiceMetaZZ_ServiceArticle FOREIGN KEY (ServiceArticleID) REFERENCES ServiceArticle (ServiceArticleID);


ALTER TABLE Intervenir ADD CONSTRAINT FK_Intervenir_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID);
ALTER TABLE Intervenir ADD CONSTRAINT FK_Intervenir_Service FOREIGN KEY (ServiceID) REFERENCES Service (ServiceID);

-- IntervenirMetaZZ constraints
ALTER TABLE IntervenirMetaZZ ADD CONSTRAINT FK_IntervenirMetaZZ_Employee FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID);
ALTER TABLE IntervenirMetaZZ ADD CONSTRAINT FK_IntervenirMetaZZ_Service FOREIGN KEY (ServiceID) REFERENCES ServiceMetaZZ (ServiceID);

ALTER TABLE users ADD CONSTRAINT fk_users_employee FOREIGN KEY (employee_id) REFERENCES Employee(EmployeeID) ON DELETE SET NULL;

-- Connect as a superuser (e.g., postgres)
-- Grant usage on the schema (usually "public")
GRANT USAGE ON SCHEMA public TO sigma_api;

-- Grant all privileges on all existing tables in the schema
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sigma_api;

-- Also grant privileges on sequences (important for auto-increment IDs)
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sigma_api;

-- Ensure future tables and sequences also get privileges automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON TABLES TO sigma_api;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL PRIVILEGES ON SEQUENCES TO sigma_api;


-- =====================================================
-- Ajout des Caisse Caisse
-- =====================================================
INSERT INTO Caisse (CaisseName, CaisseMountant, CaisseMetaZZ, CaisseLastEditByUserId)
VALUES 
('MainCaisse', 0, TRUE, NULL),
('TVACaisse', 0, TRUE, NULL),
('MetaZZCaisse', 0, FALSE, NULL),
('TVAMetaZZCaisse', 0, FALSE, NULL);

-- =========================================
-- 1) refresh_tokens
-- =========================================
-- Purpose: Contains ONLY currently valid refresh-token sessions.
-- When a token expires or is revoked, it is removed from this table.
DROP TABLE IF EXISTS refresh_tokens CASCADE;
CREATE TABLE refresh_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMP NOT NULL,
    last_used_at TIMESTAMP NULL,
    created_ip VARCHAR(45),
    last_used_ip VARCHAR(45),
    user_agent TEXT
);

-- Indexes for refresh_tokens
CREATE INDEX idx_refresh_tokens_user_id ON refresh_tokens(user_id);
CREATE INDEX idx_refresh_tokens_token_hash ON refresh_tokens(token_hash);
CREATE INDEX idx_refresh_tokens_expires_at ON refresh_tokens(expires_at);


-- =========================================
-- 2) auth_events
-- =========================================
-- Purpose: Store authentication history and security events.
DROP TABLE IF EXISTS auth_events CASCADE;
CREATE TABLE auth_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NULL REFERENCES users(id) ON DELETE SET NULL,
    event_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    ip_address VARCHAR(45),
    user_agent TEXT,
    details JSONB NULL
);

-- Indexes for auth_events
CREATE INDEX idx_auth_events_user_id ON auth_events(user_id);
CREATE INDEX idx_auth_events_event_type ON auth_events(event_type);
CREATE INDEX idx_auth_events_created_at ON auth_events(created_at);

INSERT INTO users (
    username,
    password_hash,
    role,
    privileges
) VALUES (
    'admin',
    '$2a$10$yMoIW0tpF90DVuFM1nUVtug/X2WRkroitBtFufbN13MInGMRZwqxm', -- ⚠️ REPLACE THIS!
    'admin',
    ARRAY['SUPER']
);