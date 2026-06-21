-- PUBLIC HEALTH CLINIC RECORDS SYSTEM

CREATE DATABASE public_health_clinic_db;


-- CREATE TABLES

CREATE TABLE departments (
    department_id   INT PRIMARY KEY  AUTO_INCREMENTNOT NULL,
    department_name VARCHAR(100)                       NOT NULL,
    description     VARCHAR(255)                       NOT NULL,

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE doctors (
  doctor_id         INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  department_id     INT                            NOT NULL,
  first_name        VARCHAR(50)                    NOT NULL,
  last_name         VARCHAR(50)                    NOT NULL,
  specialization    VARCHAR(100)                   NOT NULL,
  phone_number      VARCHAR(20)                    NOT NULL,

  FOREIGN KEY (department_id)    REFERENCES departments (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE patients (
  patient_id            INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  first_name            VARCHAR(50)                    NOT NULL,
  last_name             VARCHAR(50)                    NOT NULL,
  gender                ENUM('Male','Female')          NOT NULL,
  date_of_birth         DATE                           NOT NULL,
  phone_number          VARCHAR(20)                    NOT NULL,
  address               VARCHAR(255)                   NOT NULL,
  registration_date     DATE                  DEFAULT CURDATE(),

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE appointments (
  appointment_id    INT    PRIMARY KEY  AUTO_INCREMENT NOT NULL,
  patient_id        INT                                NOT NULL,
  doctor_id         INT                                NOT NULL,
  appointment_date  DATETIME                           NOT NULL,
  status    ENUM(Scheduled,Completed,Cancelled) DEFAULT Scheduled,

  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (doctor_id)  REFERENCES doctors  (doctor_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE medical_records (
  record_id     INT   PRIMARY KEY  AUTO_INCREMENT NOT NULL,
  patient_id    INT                               NOT NULL,
  doctor_id     INT                               NOT NULL,
  diagnosis     VARCHAR(255)                      NOT NULL,
  symptoms      VARCHAR(500)                      NOT NULL,
  treatment     VARCHAR(500)                      NOT NULL,
  visit_date    DATE                              NOT NULL,
  notes         TEXT                           DEFAULT NULL,

  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (doctor_id)  REFERENCES doctors  (doctor_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE lab_test (
  test_id        INT       PRIMARY KEY  AUTO_INCREMENT  NOT NULL,
  patient_id     INT(11)                                NOT NULL,
  doctor_id      INT(11)                                NOT NULL,
  test_name      VARCHAR(255)                           NOT NULL,
  test_result    VARCHAR(255)                           NOT NULL,
  test_date      DATE                                   NOT NULL, 

  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (doctor_id)  REFERENCES doctors  (doctor_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE payments (
  payment_id      INT     PRIMARY KEY  AUTO_INCREMENT  NOT NULL,
  patient_id      INT                                  NOT NULL,
  amount          DECIMAL(10,2)                        NOT NULL,
  payment_date    DATE                                 NOT NULL,

  FOREIGN KEY (patient_id) REFERENCES patients (patient_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE prescriptions (
  prescription_id  INT  PRIMARY KEY  AUTO_INCREMENT  NOT NULL,
  record_id        INT                               NOT NULL,
  medication_name  VARCHAR(100)                      NOT NULL,
  dosage           VARCHAR(100)                      NOT NULL,
  duration         VARCHAR(50)                       NOT NULL,

  FOREIGN KEY (record_id) REFERENCES medical_records (record_id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- RENAME A TABLE
-- Rename:  lab_test  to  laboratory_tests

RENAME TABLE lab_test TO laboratory_tests;

SELECT * FROM laboratory_tests; 


-- RENAME A COLUMN
-- Rename column:  status  to  appointment_status  in appointments

ALTER TABLE appointments
CHANGE status appointment_status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled';

SELECT * FROM appointments; 

-- ADD A CONSTRAINT
-- Add a CHECK constraint: amount must be > 0

ALTER TABLE payments
ADD CONSTRAINT chk_positive_amount CHECK (amount > 0);

SELECT * FROM payments;           -- confirm constraint added (empty for now)


-- INSERT SAMPLE DATA - DEPARTMENTS

INSERT INTO departments (department_id, department_name, description) VALUES
(1,  'General OPD',        'General outpatient consultations'),
(2,  'Maternity',          'Pregnancy and childbirth services'),
(3,  'Laboratory',         'Medical testing services'),
(4,  'Pharmacy',           'Medicine dispensing services'),
(5,  'Pediatrics',         'Child healthcare services'),
(6,  'Surgery',            'Surgical operations and procedures'),
(7,  'Dentistry',          'Dental care and treatment'),
(8,  'Cardiology',         'Heart and cardiovascular services'),
(9,  'Orthopedics',        'Bone and joint treatments'),
(10, 'Radiology',          'Medical imaging services'),
(11, 'Emergency',          'Emergency and trauma care'),
(12, 'Neurology',          'Brain and nervous system care'),
(13, 'Oncology',           'Cancer treatment services'),
(14, 'Dermatology',        'Skin treatment services'),
(15, 'Ophthalmology',      'Eye care services'),
(16, 'ENT',                'Ear, Nose and Throat services'),
(17, 'Nutrition',          'Diet and nutrition services'),
(18, 'Physiotherapy',      'Physical rehabilitation services'),
(19, 'Mental Health',      'Psychological and counseling services'),
(20, 'Infectious Diseases','Treatment of communicable diseases');

SELECT * FROM departments;


-- INSERT SAMPLE DATA - DOCTORS

INSERT INTO doctors (doctor_id, first_name, last_name, specialization, phone_number, department_id) VALUES
(1,  'Samuel',     'Kamara',    'General Practitioner',        '076111111', 1),
(2,  'Aminata',    'Bangura',   'Gynecologist',                '077222222', 2),
(3,  'Ibrahim',    'Kanu',      'Laboratory Specialist',       '078333333', 3),
(4,  'Hassan',     'Sesay',     'Pharmacist',                  '079444444', 4),
(5,  'Mariama',    'Koroma',    'Pediatrician',                '088555555', 5),
(6,  'Abdul',      'Turay',     'Surgeon',                     '076666666', 6),
(7,  'Fatmata',    'Jalloh',    'Dentist',                     '077777777', 7),
(8,  'Musa',       'Conteh',    'Cardiologist',                '078888888', 8),
(9,  'Kadiatu',    'Kamara',    'Orthopedic Specialist',       '079999999', 9),
(10, 'Alhaji',     'Kallon',    'Radiologist',                 '088111111', 10),
(11, 'Joseph',     'Williams',  'Emergency Physician',         '076222333', 11),
(12, 'Hawa',       'Cole',      'Neurologist',                 '077333444', 12),
(13, 'David',      'George',    'Oncologist',                  '078444555', 13),
(14, 'Rugiatu',    'Mansaray',  'Dermatologist',               '079555666', 14),
(15, 'Sorie',      'Bangura',   'Ophthalmologist',             '088666777', 15),
(16, 'Adama',      'Kargbo',    'ENT Specialist',              '076777888', 16),
(17, 'Abubakarr',  'Fofanah',   'Nutritionist',                '077888999', 17),
(18, 'Mabinty',    'Kamara',    'Physiotherapist',             '078999000', 18),
(19, 'Zainab',     'Koroma',    'Psychologist',                '079000111', 19),
(20, 'Ishmael',    'Sesay',     'Infectious Disease Specialist','088123456', 20);

SELECT * FROM doctors;


-- INSERT SAMPLE DATA — PATIENTS

INSERT INTO patients (patient_id, first_name, last_name, gender, date_of_birth, phone_number, address, registration_date) VALUES
(1,  'Mohamed',    'Kamara',    'Male',   '1998-06-15', '076111111', 'Freetown',         '2026-06-01'),
(2,  'Fatmata',    'Sesay',     'Female', '2000-03-10', '076222222', 'Lumley, Freetown', '2026-06-01'),
(3,  'Ibrahim',    'Koroma',    'Male',   '1995-08-20', '078345678', 'Kenema',           '2026-06-02'),
(4,  'Hawa',       'Bangura',   'Female', '2001-11-05', '079456789', 'Makeni',           '2026-06-02'),
(5,  'Abdul',      'Conteh',    'Male',   '1997-04-18', '088567890', 'Port Loko',        '2026-06-03'),
(6,  'Mariama',    'Kallon',    'Female', '1999-02-22', '076678901', 'Kono',             '2026-06-03'),
(7,  'Alhaji',     'Turay',     'Male',   '1988-12-11', '077789012', 'Freetown',         '2026-06-04'),
(8,  'Aminata',    'Jalloh',    'Female', '2002-09-14', '078890123', 'Bo',               '2026-06-04'),
(9,  'Sorie',      'Mansaray',  'Male',   '1996-01-30', '079901234', 'Makeni',           '2026-06-05'),
(10, 'Kadiatu',    'Kamara',    'Female', '2003-05-19', '088012345', 'Kenema',           '2026-06-05'),
(11, 'Musa',       'Sesay',     'Male',   '1994-07-08', '076111222', 'Freetown',         '2026-06-06'),
(12, 'Adama',      'Koroma',    'Female', '1998-10-25', '077222333', 'Bo',               '2026-06-06'),
(13, 'Ishmael',    'Bangura',   'Male',   '1997-06-28', '078333444', 'Waterloo',         '2026-06-07'),
(14, 'Hassan',     'Kanu',      'Male',   '1990-03-12', '079444555', 'Makeni',           '2026-06-07'),
(15, 'Mabinty',    'Turay',     'Female', '2001-01-15', '088555666', 'Port Loko',        '2026-06-08'),
(16, 'Joseph',     'Williams',  'Male',   '1989-11-20', '076666777', 'Freetown',         '2026-06-08'),
(17, 'Rugiatu',    'Cole',      'Female', '1995-08-09', '077777888', 'Bo',               '2026-06-09'),
(18, 'Abubakarr',  'Fofanah',   'Male',   '1993-04-17', '078888999', 'Kailahun',         '2026-06-09'),
(19, 'Zainab',     'Kamara',    'Female', '2000-12-01', '079999000', 'Kenema',           '2026-06-10'),
(20, 'David',      'George',    'Male',   '1991-02-14', '088000111', 'Freetown',         '2026-06-10');

SELECT * FROM patients;


-- INSERT SAMPLE DATA — APPOINTMENTS

INSERT INTO appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_status) VALUES
(1,  1,  1,  '2026-06-10 09:00:00', 'Scheduled'),
(2,  2,  2,  '2026-06-10 10:00:00', 'Completed'),
(3,  3,  3,  '2026-06-11 11:00:00', 'Scheduled'),
(4,  4,  4,  '2026-06-11 12:00:00', 'Cancelled'),
(5,  5,  5,  '2026-06-12 08:30:00', 'Completed'),
(6,  6,  6,  '2026-06-12 09:30:00', 'Scheduled'),
(7,  7,  7,  '2026-06-13 10:30:00', 'Completed'),
(8,  8,  8,  '2026-06-13 11:30:00', 'Scheduled'),
(9,  9,  9,  '2026-06-14 12:30:00', 'Cancelled'),
(10, 10, 10, '2026-06-14 13:30:00', 'Completed'),
(11, 11, 11, '2026-06-15 08:00:00', 'Scheduled'),
(12, 12, 12, '2026-06-15 09:00:00', 'Completed'),
(13, 13, 13, '2026-06-16 10:00:00', 'Scheduled'),
(14, 14, 14, '2026-06-16 11:00:00', 'Completed'),
(15, 15, 15, '2026-06-17 12:00:00', 'Scheduled'),
(16, 16, 16, '2026-06-17 13:00:00', 'Cancelled'),
(17, 17, 17, '2026-06-18 08:45:00', 'Completed'),
(18, 18, 18, '2026-06-18 09:45:00', 'Scheduled'),
(19, 19, 19, '2026-06-19 10:45:00', 'Completed'),
(20, 20, 20, '2026-06-19 11:45:00', 'Scheduled');

SELECT * FROM appointments;


-- UPDATE & DELETE EXAMPLES - APPOINTMENTS   
-- UPDATE (first time)
UPDATE appointments
SET appointment_status = 'Completed'
WHERE appointment_id = 1;

SELECT * FROM appointments;

-- UPDATE (second time)
UPDATE appointments
SET appointment_status = 'Cancelled'
WHERE appointment_id = 3;

SELECT * FROM appointments;

-- INSERT then DELETE (This action was performed twice to showcase the database functionality)
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_status)
VALUES (1, 1, '2026-07-10 09:00:00', 'Scheduled');

SELECT * FROM appointments;


DELETE FROM appointments
WHERE appointment_date = '2026-07-10 09:00:00';

SELECT * FROM appointments;

-- INSERT then DELETE (second time)
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_status)
VALUES (2, 2, '2026-07-15 10:00:00', 'Scheduled');

SELECT * FROM appointments;

DELETE FROM appointments
WHERE appointment_date = '2026-07-15 10:00:00';

SELECT * FROM appointments;



-- INSERT SAMPLE DATA — MEDICAL RECORDS

INSERT INTO medical_records (record_id, patient_id, doctor_id, diagnosis, symptoms, treatment, visit_date, notes) VALUES
(1,  1,  1,  'Malaria',           'Fever, Headache',          'Coartem',             '2026-06-10', 'Patient advised to rest'),
(2,  2,  2,  'Pregnancy Checkup', 'Routine ANC',              'Prenatal Vitamins',   '2026-06-10', 'Mother healthy'),
(3,  3,  3,  'Typhoid',           'Fever, Abdominal Pain',    'Ciprofloxacin',       '2026-06-11', 'Increase fluids'),
(4,  4,  4,  'Common Cold',       'Cough, Sneezing',          'Paracetamol',         '2026-06-11', 'Review after 1 week'),
(5,  5,  5,  'Hypertension',      'High Blood Pressure',      'Amlodipine',          '2026-06-12', 'Monitor BP'),
(6,  6,  6,  'Appendicitis',      'Abdominal Pain',           'Surgery',             '2026-06-12', 'Successful operation'),
(7,  7,  7,  'Tooth Decay',       'Tooth Pain',               'Extraction',          '2026-06-13', 'Dental follow-up'),
(8,  8,  8,  'Heart Disease',     'Chest Pain',               'Medication',          '2026-06-13', 'Further tests needed'),
(9,  9,  9,  'Fracture',          'Broken Arm',               'Casting',             '2026-06-14', 'Review in 6 weeks'),
(10, 10, 10, 'Lung Infection',    'Shortness of Breath',      'Antibiotics',         '2026-06-14', 'Chest X-ray done'),
(11, 11, 11, 'Trauma',            'Accident Injury',          'Emergency Care',      '2026-06-15', 'Stable'),
(12, 12, 12, 'Migraine',          'Severe Headache',          'Pain Relief',         '2026-06-15', 'Neurology referral'),
(13, 13, 13, 'Cancer Screening',  'Routine Check',            'Biopsy',              '2026-06-16', 'Awaiting results'),
(14, 14, 14, 'Skin Rash',         'Itching',                  'Cream',               '2026-06-16', 'Follow-up needed'),
(15, 15, 15, 'Eye Infection',     'Red Eyes',                 'Eye Drops',           '2026-06-17', 'Improving'),
(16, 16, 16, 'Ear Infection',     'Ear Pain',                 'Antibiotics',         '2026-06-17', 'ENT review'),
(17, 17, 17, 'Malnutrition',      'Weight Loss',              'Nutrition Plan',      '2026-06-18', 'Diet advised'),
(18, 18, 18, 'Back Pain',         'Muscle Pain',              'Physiotherapy',       '2026-06-18', 'Exercises prescribed'),
(19, 19, 19, 'Depression',        'Low Mood',                 'Counselling',         '2026-06-19', 'Regular sessions'),
(20, 20, 20, 'Tuberculosis',      'Persistent Cough',         'TB Medication',       '2026-06-19', 'DOTS started');

SELECT * FROM medical_records;



-- UPDATE & DELETE EXAMPLES - MEDICAL RECORDS 
-- UPDATE
UPDATE medical_records
SET notes = 'Patient advised to rest and increase fluid intake.'
WHERE record_id = 1;

SELECT * FROM medical_records;
   
UPDATE medical_records
SET notes = 'Patient advised to rest, increase fluid intake, and return in 3 days.'
WHERE record_id = 1;

SELECT * FROM medical_records;


-- INSERT then DELETE (first time)
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, symptoms, treatment, visit_date, notes)
VALUES (1, 1, 'Test Diagnosis', 'Test Symptoms', 'Test Treatment', '2026-07-01', 'Temporary record');

SELECT * FROM medical_records;

DELETE FROM medical_records
WHERE diagnosis = 'Test Diagnosis';

SELECT * FROM medical_records;

-- INSERT then DELETE (second time)
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, symptoms, treatment, visit_date, notes)
VALUES (2, 2, 'Sample Diagnosis', 'Sample Symptoms', 'Sample Treatment', '2026-07-02', 'Another temporary record');

SELECT * FROM medical_records;

DELETE FROM medical_records
WHERE diagnosis = 'Sample Diagnosis';

SELECT * FROM medical_records;



-- INSERT SAMPLE DATA - LABORATORY TESTS   
INSERT INTO laboratory_tests (test_id, patient_id, doctor_id test_name, test_result, test_date) VALUES
(1,  1,  1,  'Malaria Test',            'Positive',          '2026-06-10'),
(2,  2,  2,  'Blood Pressure Test',     'Normal',            '2026-06-10'),
(3,  3,  3,  'Typhoid Test',            'Positive',          '2026-06-11'),
(4,  4,  4,  'COVID-19 Test',           'Negative',          '2026-06-11'),
(5,  5,  5,  'Blood Sugar Test',        'Normal',            '2026-06-12'),
(6,  6,  6,  'Blood Count',             'Normal',            '2026-06-12'),
(7,  7,  7,  'Dental X-Ray',            'Cavity Found',      '2026-06-13'),
(8,  8,  8,  'ECG',                     'Abnormal',          '2026-06-13'),
(9,  9,  9,  'Bone X-Ray',              'Fracture Detected', '2026-06-14'),
(10, 10, 10, 'Chest X-Ray',             'Infection Found',   '2026-06-14'),
(11, 11, 11, 'Trauma Scan',             'Stable',            '2026-06-15'),
(12, 12, 12, 'Brain Scan',              'Normal',            '2026-06-15'),
(13, 13, 13, 'Cancer Screening',        'Pending',           '2026-06-16'),
(14, 14, 14, 'Skin Test',               'Allergy Found',     '2026-06-16'),
(15, 15, 15, 'Vision Test',             'Short Sighted',     '2026-06-17'),
(16, 16, 16, 'Hearing Test',            'Normal',            '2026-06-17'),
(17, 17, 17, 'Nutrition Assessment',    'Underweight',       '2026-06-18'),
(18, 18, 18, 'Spinal Assessment',       'Mild Strain',       '2026-06-18'),
(19, 19, 19, 'Psychological Assessment','Moderate Depression','2026-06-19'),
(20, 20, 20, 'TB Test',                 'Positive',          '2026-06-19');

SELECT * FROM laboratory_tests;


-- INSERT SAMPLE DATA — PAYMENTS 
INSERT INTO payments (payment_id, patient_id, amount, payment_date) VALUES
(1,  1,  150.00, '2026-06-10'),
(2,  2,  200.00, '2026-06-10'),
(3,  3,  175.00, '2026-06-11'),
(4,  4,  100.00, '2026-06-11'),
(5,  5,  250.00, '2026-06-12'),
(6,  6,  500.00, '2026-06-12'),
(7,  7,  120.00, '2026-06-13'),
(8,  8,  300.00, '2026-06-13'),
(9,  9,  450.00, '2026-06-14'),
(10, 10, 350.00, '2026-06-14'),
(11, 11, 400.00, '2026-06-15'),
(12, 12, 180.00, '2026-06-15'),
(13, 13, 600.00, '2026-06-16'),
(14, 14, 140.00, '2026-06-16'),
(15, 15, 220.00, '2026-06-17'),
(16, 16, 160.00, '2026-06-17'),
(17, 17, 130.00, '2026-06-18'),
(18, 18, 210.00, '2026-06-18'),
(19, 19, 190.00, '2026-06-19'),
(20, 20, 550.00, '2026-06-19');

SELECT * FROM payments;


-- UPDATE & DELETE EXAMPLES - PAYMENTS

-- UPDATE
UPDATE payments
SET amount = 160.00
WHERE payment_id = 1;

SELECT * FROM payments;

-- UPDATE (second time)
UPDATE payments
SET amount = 175.00
WHERE payment_id = 1;

SELECT * FROM payments;

-- INSERT then DELETE
INSERT INTO payments (patient_id, amount, payment_date)
VALUES (1, 50.00, '2026-07-01');

SELECT * FROM payments;

DELETE FROM payments
WHERE payment_date = '2026-07-01';

SELECT * FROM payments;

-- INSERT then DELETE (second time)
INSERT INTO payments (patient_id, amount, payment_date)
VALUES (2, 75.00, '2026-07-02');

SELECT * FROM payments;

DELETE FROM payments
WHERE payment_date = '2026-07-02';

SELECT * FROM payments;


-- INSERT SAMPLE DATA - PRESCRIPTIONS

INSERT INTO prescriptions (prescription_id, record_id, medication_name, dosage, duration) VALUES
(1,  1,  'Coartem',              '2 Tablets Twice Daily',       '3 Days'),
(2,  2,  'Prenatal Vitamins',    '1 Tablet Daily',              '30 Days'),
(3,  3,  'Ciprofloxacin',        '500mg Twice Daily',           '7 Days'),
(4,  4,  'Paracetamol',          '500mg Three Times Daily',     '5 Days'),
(5,  5,  'Amlodipine',           '5mg Daily',                   '30 Days'),
(6,  6,  'Pain Killers',         '1 Tablet Twice Daily',        '7 Days'),
(7,  7,  'Amoxicillin',          '500mg Three Times Daily',     '5 Days'),
(8,  8,  'Aspirin',              '75mg Daily',                  '30 Days'),
(9,  9,  'Ibuprofen',            '400mg Twice Daily',           '7 Days'),
(10, 10, 'Azithromycin',         '500mg Daily',                 '3 Days'),
(11, 11, 'Diclofenac',           '50mg Twice Daily',            '5 Days'),
(12, 12, 'Migraine Relief',      '1 Tablet Daily',              '10 Days'),
(13, 13, 'Cancer Support Drug',  'As Directed',                 '14 Days'),
(14, 14, 'Skin Cream',           'Apply Twice Daily',           '14 Days'),
(15, 15, 'Eye Drops',            '2 Drops Daily',               '7 Days'),
(16, 16, 'Ear Drops',            '2 Drops Daily',               '7 Days'),
(17, 17, 'Vitamin Supplements',  '1 Daily',                     '30 Days'),
(18, 18, 'Muscle Relaxant',      '1 Twice Daily',               '10 Days'),
(19, 19, 'Antidepressants',      '1 Daily',                     '30 Days'),
(20, 20, 'TB Drugs',             'As Directed',                 '180 Days');

SELECT * FROM prescriptions;


-- HOW TO SEARCH FOR DATA IN A TABLE (It retrieve all records from a table)   
SELECT * FROM patients;

SELECT * FROM payments;



-- HOW TO RETRIEVE DATA FROM A SPECIFIC COLUMN 
-- One column
SELECT first_name FROM patients;

-- Multiple columns
SELECT medication_name, dosage FROM prescriptions;


-- HOW TO SEARCH FOR A SPECIFIC RECORD

SELECT * FROM patients
WHERE patient_id = 5;

SELECT * FROM payments
WHERE payment_id = 9;


-- HOW TO SEARCH USING ONE CONDITION

SELECT * FROM patients
WHERE gender = 'Female';

SELECT * FROM payments
WHERE amount > 200.00;


-- HOW TO SEARCH USING MULTIPLE CONDITIONS

SELECT * FROM patients
WHERE gender = 'Female'
AND address = 'Freetown';

SELECT * FROM payments
WHERE amount > 200.00
AND payment_date >= '2026-06-12';


-- LOGICAL OPERATORS

-- OR operator
SELECT * FROM patients
WHERE address = 'Freetown'
OR address = 'Makeni';

-- OR operator (second time)
SELECT * FROM payments
WHERE amount < 150.00
OR amount > 450.00;

-- AND operator
SELECT * FROM appointments
WHERE doctor_id = 1
AND appointment_date >= '2026-06-10';

-- AND operator (second time)
SELECT * FROM payments
WHERE amount >= 200.00
AND amount <= 400.00;

-- BETWEEN operator
SELECT * FROM appointments
WHERE appointment_date
BETWEEN '2026-06-10' AND '2026-06-14';

-- BETWEEN operator (second time)
SELECT * FROM payments
WHERE amount
BETWEEN 150.00 AND 350.00;


-- LIKE OPERATOR - 3 PATTERNS

-- Pattern 1: Starts with a value (%)
SELECT * FROM patients
WHERE first_name LIKE 'A%';

SELECT * FROM prescriptions
WHERE medication_name LIKE 'A%';

-- Pattern 2: Ends with a value (%)
SELECT * FROM patients
WHERE last_name LIKE 'a';

SELECT * FROM prescriptions
WHERE medication_name LIKE '%in';

-- Pattern 3: Contains a value (%value%)
SELECT * FROM patients
WHERE address LIKE '%town%';

SELECT * FROM medical_records
WHERE notes LIKE '%fever%';



-- SEARCH FOR A RECORD IN A LIST - IN OPERATOR

SELECT * FROM patients
WHERE address IN ('Freetown', 'Makeni', 'Bo');

SELECT * FROM prescriptions
WHERE medication_name IN ('Paracetamol', 'Ibuprofen', 'Coartem');


-- SEARCH FOR NULL VALUES - IS NULL / IS NOT NULL

SELECT * FROM medical_records
WHERE notes IS NULL;

SELECT * FROM medical_records
WHERE notes IS NOT NULL;


-- LIMIT CLAUSE - LIMIT SPECIFIC RECORDS

SELECT * FROM payments
ORDER BY amount DESC
LIMIT 5;

SELECT * FROM patients
LIMIT 10;


-- ORDER BY - SORT RESULTS   
-- Ascending
SELECT * FROM payments
ORDER BY amount ASC;

-- Ascending (second time)
SELECT * FROM patients
ORDER BY last_name ASC;

-- Descending
SELECT * FROM payments
ORDER BY amount DESC;

-- Descending (second time)
SELECT * FROM appointments
ORDER BY appointment_date DESC;


-- AGGREGATE FUNCTIONS

SELECT COUNT(*) FROM patients;

SELECT COUNT(*) FROM payments;

SELECT AVG(amount) FROM payments;

SELECT AVG(amount) FROM payments
WHERE payment_date BETWEEN '2026-06-10' AND '2026-06-14';

SELECT SUM(amount) FROM payments;

SELECT SUM(amount) FROM payments
WHERE payment_date BETWEEN '2026-06-15' AND '2026-06-19';

SELECT MAX(amount) FROM payments;

SELECT MAX(amount) AS Highest_Payment, patient_id
FROM payments
GROUP BY patient_id
ORDER BY Highest_Payment DESC;

SELECT MIN(amount) AS Lowest_Payment FROM payments;

SELECT MIN(amount) AS Lowest_Payment_Per_Patient, patient_id
FROM payments
GROUP BY patient_id
ORDER BY Lowest_Payment_Per_Patient ASC;


-- GROUP BY - Gender count
SELECT gender, COUNT(*) FROM patients
GROUP BY gender;

-- GROUP BY - Department count
SELECT department_name, COUNT(*) FROM departments
GROUP BY department_name;

-- GROUP BY - Appointment status count
SELECT appointment_status, COUNT(*) FROM appointments
GROUP BY appointment_status;

-- GROUP BY - Specialization count
SELECT specialization, COUNT(*) FROM doctors
GROUP BY specialization;