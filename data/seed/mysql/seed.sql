-- ============================================================
-- Nexus Intelligence — MySQL Seed Data
-- Same five borrowers as the PostgreSQL seed, viewed through
-- a CRM lens. Names match exactly so the federation layer's
-- entity-resolution logic has something real to reconcile.
-- ============================================================

INSERT INTO customers
    (CustomerName, BusinessSector, AccountStatus, DateOpened, RiskCategory, RelationshipMgr, LastContactDate)
VALUES
    ('Kampala Traders Ltd',    'Trade and Commerce', 'Active',    '2019-03-15', 'Medium',   'John Okello',    '2024-09-15'),
    ('Nakivubo Hardware',      'Construction',        'Active',    '2021-06-01', 'High',     'Sarah Nambi',    '2024-08-22'),
    ('Agro Uganda SACCO',      'Agriculture',         'Active',    '2018-09-01', 'Low',      'Peter Mugisha',  '2024-08-20'),
    ('Victoria Hospitality',   'Hospitality',         'Suspended', '2020-01-01', 'High',     'John Okello',    '2024-07-30'),
    ('Makerere Education Ctr', 'Education',           'Active',    '2022-03-01', 'Medium',   'Grace Apio',     '2024-09-01');

INSERT INTO credit_applications
    (customer_id, ApplicationDate, AmountRequested, Purpose, Status, DecisionDate, DecisionBy, Notes)
VALUES
    (1, '2022-12-10', 450000000, 'Working capital - import trade finance', 'Approved', '2023-01-02', 'Credit Committee',
     'Approved on strength of 3-year trading history and seasonal cashflow pattern recognized by RM.'),
    (2, '2023-08-15', 120000000, 'Equipment purchase - hardware stock', 'Approved', '2023-08-28', 'Credit Committee',
     'Higher risk grade but strong collateral coverage via equipment charge.'),
    (4, '2021-12-05', 300000000, 'Hotel renovation', 'Approved', '2021-12-20', 'Credit Committee',
     'Approved against bank guarantee collateral. Tourism sector volatility flagged as risk at the time.');

INSERT INTO relationship_notes
    (customer_id, NoteDate, NoteType, Content, CreatedBy)
VALUES
    (1, '2024-09-15', 'Visit',
     'Met with MD. Business performing well. Seasonal dip expected Q3 due to import cycle timing. Expecting recovery in Q4 based on historical pattern over past 3 years.',
     'John Okello'),
    (1, '2024-06-10', 'Call',
     'Borrower flagged temporary cashflow pressure due to delayed shipment clearance at port. Resolved by August as predicted.',
     'John Okello'),
    (3, '2024-08-20', 'Visit',
     'SACCO membership growing steadily. Repayment discipline excellent across member base. No concerns.',
     'Peter Mugisha'),
    (4, '2024-07-30', 'Review',
     'Occupancy rates down significantly. Suspended pending restructuring discussion. Tourism sector showing sector-wide weakness, not isolated to this borrower.',
     'John Okello'),
    (5, '2024-09-01', 'Call',
     'Term fee collections on track. No issues reported.',
     'Grace Apio');
