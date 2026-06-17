-- ============================================================
-- Nexus Intelligence — MySQL Schema
-- Simulates a CRM system
-- Deliberately uses different naming conventions than the
-- PostgreSQL core banking schema (PascalCase columns, full
-- words instead of codes) to prove normalization works
-- across genuinely different source designs.
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (
    customer_id     INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName    VARCHAR(300) NOT NULL,
    BusinessSector  VARCHAR(100),          -- full words, not codes
    AccountStatus   VARCHAR(20) DEFAULT 'Active',
    DateOpened      DATE,
    RiskCategory    VARCHAR(20),           -- Low / Medium / High / Critical
    RelationshipMgr VARCHAR(100),
    LastContactDate DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS credit_applications (
    application_id  INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    ApplicationDate DATE,
    AmountRequested DECIMAL(20,2),
    Purpose         VARCHAR(255),
    Status          VARCHAR(50),           -- Pending / Approved / Declined / Conditional
    DecisionDate    DATE,
    DecisionBy      VARCHAR(100),
    Notes           TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS relationship_notes (
    note_id         INT AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT NOT NULL,
    NoteDate        DATE,
    NoteType        VARCHAR(50),           -- Visit / Call / Email / Review
    Content         TEXT,
    CreatedBy       VARCHAR(100),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE INDEX idx_customers_name ON customers(CustomerName);
CREATE INDEX idx_customers_sector ON customers(BusinessSector);
CREATE INDEX idx_applications_customer ON credit_applications(customer_id);
CREATE INDEX idx_notes_customer ON relationship_notes(customer_id);
