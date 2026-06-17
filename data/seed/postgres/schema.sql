-- ============================================================
-- Nexus Intelligence — PostgreSQL Schema
-- Simulates a T24-style core banking system
-- Deliberately uses terse, code-based naming conventions
-- to prove the normalization layer works correctly.
-- ============================================================

-- Borrowers (T24 calls this CUSTOMER)
CREATE TABLE IF NOT EXISTS borrowers (
    id              SERIAL PRIMARY KEY,
    customer_no     VARCHAR(20) UNIQUE NOT NULL,
    full_name       VARCHAR(255) NOT NULL,
    sector_code     CHAR(2),        -- TR, AG, MF, CO, HO, ED, RE, FI
    open_date       CHAR(8),        -- YYYYMMDD string, T24 style
    status_code     CHAR(1) DEFAULT 'A',  -- A=active, C=closed, S=suspended
    risk_class      CHAR(1),        -- A, B, C, D
    registration_no VARCHAR(50),
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Loans (T24 calls this LOAN/AA arrangement)
CREATE TABLE IF NOT EXISTS loans (
    id              SERIAL PRIMARY KEY,
    loan_no         VARCHAR(20) UNIQUE NOT NULL,
    customer_no     VARCHAR(20) NOT NULL REFERENCES borrowers(customer_no),
    product_code    VARCHAR(10),    -- TML=term loan, OVD=overdraft, GRL=group loan
    loan_amount     NUMERIC(20,2),
    currency        CHAR(3) DEFAULT 'UGX',
    outstanding_bal NUMERIC(20,2),
    status_code     CHAR(2),        -- AC=active, CL=closed, NP=NPL
    disb_date       CHAR(8),
    maturity_date   CHAR(8),
    interest_rate   NUMERIC(6,4),
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Transactions (T24 calls this STMT.ENTRY)
CREATE TABLE IF NOT EXISTS transactions (
    id              SERIAL PRIMARY KEY,
    txn_ref         VARCHAR(30) UNIQUE NOT NULL,
    account_no      VARCHAR(20) NOT NULL,  -- maps to customer_no or loan_no
    txn_type        CHAR(1),        -- C=credit, D=debit
    txn_amount      NUMERIC(20,2),
    currency        CHAR(3) DEFAULT 'UGX',
    description     VARCHAR(255),
    value_date      CHAR(8),
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Repayment schedule (T24 calls this AA.SCHEDULE)
CREATE TABLE IF NOT EXISTS repayment_schedules (
    id              SERIAL PRIMARY KEY,
    loan_no         VARCHAR(20) NOT NULL REFERENCES loans(loan_no),
    installment_no  INT,
    due_date        CHAR(8),
    due_amount      NUMERIC(20,2),
    paid_amount     NUMERIC(20,2) DEFAULT 0,
    status_code     CHAR(1) DEFAULT 'P',  -- P=pending, S=settled, O=overdue
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Collateral (T24 calls this COLLATERAL)
CREATE TABLE IF NOT EXISTS collateral (
    id              SERIAL PRIMARY KEY,
    collateral_ref  VARCHAR(30) UNIQUE NOT NULL,
    loan_no         VARCHAR(20) NOT NULL REFERENCES loans(loan_no),
    collateral_type CHAR(2),        -- LD=land, VH=vehicle, BG=bank guarantee, EQ=equipment
    valuation_amt   NUMERIC(20,2),
    valuation_date  CHAR(8),
    created_at      TIMESTAMP DEFAULT NOW()
);

-- Indexes for common lookups
CREATE INDEX IF NOT EXISTS idx_borrowers_customer_no ON borrowers(customer_no);
CREATE INDEX IF NOT EXISTS idx_borrowers_sector ON borrowers(sector_code);
CREATE INDEX IF NOT EXISTS idx_loans_customer_no ON loans(customer_no);
CREATE INDEX IF NOT EXISTS idx_loans_status ON loans(status_code);
CREATE INDEX IF NOT EXISTS idx_transactions_account ON transactions(account_no);
CREATE INDEX IF NOT EXISTS idx_repayment_loan_no ON repayment_schedules(loan_no);
CREATE INDEX IF NOT EXISTS idx_collateral_loan_no ON collateral(loan_no);
