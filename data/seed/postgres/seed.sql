-- ============================================================
-- Nexus Intelligence — PostgreSQL Seed Data
-- Five borrowers across different sectors and risk profiles
-- Designed to exercise different code paths in normalization
-- and to give the context engine meaningful patterns later.
-- ============================================================

INSERT INTO borrowers
    (customer_no, full_name, sector_code, open_date, status_code, risk_class, registration_no)
VALUES
    ('CUS-001847', 'KAMPALA TRADERS LTD',      'TR', '20190315', 'A', 'B', 'REG-UG-44120'),
    ('CUS-002341', 'NAKIVUBO HARDWARE',        'CO', '20210601', 'A', 'C', 'REG-UG-51883'),
    ('CUS-003892', 'AGRO UGANDA SACCO',        'AG', '20180901', 'A', 'A', 'REG-UG-30217'),
    ('CUS-004521', 'VICTORIA HOSPITALITY',     'HO', '20200101', 'S', 'C', 'REG-UG-60492'),
    ('CUS-005103', 'MAKERERE EDUCATION CTR',   'ED', '20220301', 'A', 'B', 'REG-UG-71005')
ON CONFLICT (customer_no) DO NOTHING;

INSERT INTO loans
    (loan_no, customer_no, product_code, loan_amount, currency, outstanding_bal,
     status_code, disb_date, maturity_date, interest_rate)
VALUES
    ('LOAN-2847', 'CUS-001847', 'TML', 450000000, 'UGX', 380000000, 'AC', '20230101', '20260101', 0.1800),
    ('LOAN-2848', 'CUS-001847', 'OVD', 50000000,  'UGX', 45000000,  'AC', '20230601', '20240601', 0.2200),
    ('LOAN-3241', 'CUS-002341', 'TML', 120000000, 'UGX', 115000000, 'AC', '20230901', '20260901', 0.1900),
    ('LOAN-3892', 'CUS-003892', 'GRL', 200000000, 'UGX', 10000000,  'CL', '20210901', '20230901', 0.1600),
    ('LOAN-4521', 'CUS-004521', 'TML', 300000000, 'UGX', 295000000, 'NP', '20220101', '20250101', 0.1800),
    ('LOAN-5103', 'CUS-005103', 'TML', 80000000,  'UGX', 72000000,  'AC', '20230301', '20250301', 0.1700)
ON CONFLICT (loan_no) DO NOTHING;

INSERT INTO transactions
    (txn_ref, account_no, txn_type, txn_amount, currency, description, value_date)
VALUES
    ('TXN-0001847-01', 'CUS-001847', 'C', 85000000, 'UGX', 'Trade receipts - August', '20240810'),
    ('TXN-0001847-02', 'CUS-001847', 'C', 62000000, 'UGX', 'Trade receipts - September', '20240910'),
    ('TXN-0001847-03', 'CUS-001847', 'C', 55000000, 'UGX', 'Trade receipts - October (seasonal dip)', '20241010'),
    ('TXN-0001847-04', 'CUS-001847', 'D', 12000000, 'UGX', 'Loan repayment LOAN-2847', '20241015'),
    ('TXN-0002341-01', 'CUS-002341', 'C', 28000000, 'UGX', 'Hardware sales receipts', '20240920'),
    ('TXN-0002341-02', 'CUS-002341', 'D', 9500000,  'UGX', 'Loan repayment LOAN-3241', '20241001'),
    ('TXN-0003892-01', 'CUS-003892', 'C', 14000000, 'UGX', 'Member contributions', '20240915'),
    ('TXN-0004521-01', 'CUS-004521', 'D', 0,        'UGX', 'Missed repayment LOAN-4521', '20241001'),
    ('TXN-0005103-01', 'CUS-005103', 'C', 18000000, 'UGX', 'Term fee collections', '20240905')
ON CONFLICT (txn_ref) DO NOTHING;

INSERT INTO repayment_schedules
    (loan_no, installment_no, due_date, due_amount, paid_amount, status_code)
VALUES
    ('LOAN-2847', 22, '20241001', 12500000, 12500000, 'S'),
    ('LOAN-2847', 23, '20241101', 12500000, 0,         'O'),
    ('LOAN-3241', 14, '20241001', 9500000,  9500000,  'S'),
    ('LOAN-4521', 30, '20240901', 14200000, 0,         'O'),
    ('LOAN-4521', 31, '20241001', 14200000, 0,         'O'),
    ('LOAN-5103', 8,  '20241005', 6800000,  6800000,  'S')
ON CONFLICT DO NOTHING;

INSERT INTO collateral
    (collateral_ref, loan_no, collateral_type, valuation_amt, valuation_date)
VALUES
    ('COL-2847-01', 'LOAN-2847', 'LD', 600000000, '20221215'),
    ('COL-3241-01', 'LOAN-3241', 'EQ', 150000000, '20230820'),
    ('COL-4521-01', 'LOAN-4521', 'BG', 320000000, '20211220')
ON CONFLICT (collateral_ref) DO NOTHING;
