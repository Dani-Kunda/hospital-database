DROP DATABASE IF EXISTS hospital_project;
CREATE DATABASE hospital_project;
USE hospital_project;

-- DEPARTMENT TABLE
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    phone_number VARCHAR(20)
);

-- STAFF TABLE
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(50),
    hire_date DATE,
    days_off INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- DOCTOR TABLE
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    speciality VARCHAR(100),
    department_id INT,
    consultation_fee DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- PATIENT TABLE
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    address VARCHAR(200),
    contact_number VARCHAR(20),
    medical_history VARCHAR(255),
    insurance_provider VARCHAR(100) 
);

-- TREATMENT TABLE
CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    treatment_name VARCHAR(100),
    description VARCHAR(255),
    standard_cost DECIMAL(10,2) NOT NULL, 
    duration_minutes INT,    
    department_id INT,  
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- MEDICAL HISTORY TABLE
CREATE TABLE medical_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    condition_name VARCHAR(200) NOT NULL,
    diagnosis_date DATE,
    severity ENUM('Mild', 'Moderate', 'Severe'),
    status ENUM('Active', 'Resolved', 'Chronic'),
    notes TEXT,
    treating_doctor_id INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (treating_doctor_id) REFERENCES doctor(doctor_id)
);


-- APPOINTMENT TABLE
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    treatment_id INT,
    appointment_date DATE,
    appointment_time TIME,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    actual_cost DECIMAL(10,2),
    insurance_covered DECIMAL(10,2) DEFAULT 0,
    patient_payment DECIMAL(10,2),
    cost_adjustment_reason VARCHAR(200),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (treatment_id) REFERENCES treatment(treatment_id)
);

-- VALUES OF DEPARTMENTS
INSERT INTO department VALUES
(1, 'Cardiology', '01-1233211'),
(2, 'Orthopedics', '01-4566544'),
(3, 'Pediatrics', '01-8900989'),
(4, 'Neurology', '01-3211232'),
(5, 'Dermatology', '01-6544565'),
(6, 'General Surgery', '01-0988909'),
(7, 'Radiology', '01-1029384'),
(8, 'Emergency', '01-6758493'),
(9, 'Urology', '01-1357986'),
(10,'Oncology', '01-2468097');


-- VALUES OF STAFF
INSERT INTO staff VALUES
(121,'Julian','Cross','Nurse','2019-04-01',5,1),
(122,'Clara','Whitman','Office worker','2020-12-12',3,2),
(123,'Evan','Rourke','Porter','2018-07-26',1,3),
(124,'Mira','Dalton','Nurse','2021-10-15',2,4),
(125,'Tobias','Grant','Technician','2017-05-25',7,5),
(126,'Lila','Serrano','Office worker','2022-11-11',0,6),
(127,'Adrian','Holt','Cleaner','2016-03-12',10,7),
(128,'Naomi','Keller','Receptionist','2021-09-21',4,8),
(129,'Markus','Ellerey','Admin','2019-11-11',2,9),
(130,'Fiona','Blake','Nurse','2020-07-31',6,10);


-- VALUES OF DOCTORS
INSERT INTO doctor VALUES
(201,'Kavin','Smith','2016-01-10','Cardiologist',1, 150.00),
(202,'Selene','Parks','2018-03-15','Orthopedic Surgeon',2, 120.00),
(203,'Jasper','Walsh','2019-07-07','Pediatrician',3, 100.00),
(204,'Emma','Monroe','2020-01-20','Neurologist',4, 180.00),
(205,'Rowan','Adler','2017-02-25','Dermatologist',5, 90.00),
(206,'Olivia','Hale','2021-04-13','Surgeon',6, 200.00),
(207,'Brian','Shaw','2015-08-09','Radiologist',7, 110.00),
(208,'Sophie','Finch','2022-05-01','Emergency Doctor',8, 130.00),
(209,'Victor','Flynn','2019-09-14','Urologist',9, 140.00),
(210,'Alice','McGrath','2018-06-18','Oncologist',10, 160.00);


-- VALUES OF PATIENTS
INSERT INTO patient VALUES
(5612,'John','Bob','12 Park Road','0891112222','Diabetes','VHI Healthcare'),
(3456,'Mary','Hollis','5 Oak Avenue','0872223333','Asthma','Irish Life Health'),
(3821,'Rowan','Ryan','22 Elm Road','0863334444','Diabetes','Laya Healthcare'),
(3822,'Niamh','Hartwick','19 Pine Street','0854445555','Heart Issues','VHI Healthcare'),
(3823,'Selene','Harris','44 Birch Road','0825556666','Cancer','Irish Life Health'),
(3824,'Liam','Marwood','8 Lakeview','0836667777','None','Laya Healthcare'),
(3825,'Liana','Daly','23 Sunset Road','0897778888','Allergy','VHI Healthcare'),
(3826,'Sean','Renford','77 Harbour Street','0868889999','Asthma','Irish Life Health'),
(3827,'Victor','Murray','11 Oak Road','0859990000','Diabetes','None'),
(3828,'Chloe','Stone','2 Main Street','0871234567','Skin Condition','Laya Healthcare');


-- VALIES OF TREATMENT INCLUDING PRICE
INSERT INTO treatment VALUES
(1,'Heart Surgery','Open heart surgical procedure',15000.00,240,1),
(2,'Knee Replacement','Orthopedic surgery',12000.00,180,2),
(3,'Flu Vaccination','Vaccine injection',50.00,15,3),
(4,'Skin Biopsy','Dermatology procedure',350.00,30,5),
(5,'MRI Scan','Imaging scan',500.00,60,7),
(6,'X-Ray','Radiology imaging',120.00,20,7),
(7,'Chemotherapy','Cancer treatment',5000.00,180,10),
(8,'Physiotherapy','Rehabilitation therapy',80.00,45,2),
(9,'Blood Test','General diagnostic',60.00,10,6),
(10,'Child Health Check','Pediatrics exam',100.00,30,3);


-- VALUES OF APPOINTMENT DATES, STATUS, COST AND DISCOUNTS
INSERT INTO appointment VALUES
(1,5612,201,1,'2025-01-12','10:00','Completed',14500.00,13000.00,1500.00,'Insurance discount'),
(2,3456,203,10,'2025-01-11','09:00','Completed',100.00,80.00,20.00,'Standard coverage'),
(3,3821,201,9,'2025-01-10','12:00','Completed',60.00,48.00,12.00,'Insurance co-pay'),
(4,3822,202,2,'2025-01-14','14:00','Scheduled',11500.00,10000.00,1500.00,'Pre-negotiated rate'),
(5,3823,210,7,'2025-01-08','15:00','Completed',4800.00,4000.00,800.00,'Charity discount'),
(6,3824,204,5,'2025-01-05','11:00','Completed',500.00,400.00,100.00,'Standard coverage'),
(7,3825,205,4,'2025-01-16','13:00','Scheduled',350.00,280.00,70.00,'Insurance plan'),
(8,3826,207,6,'2025-01-17','16:00','Completed',120.00,96.00,24.00,'Standard coverage'),
(9,3827,201,1,'2025-01-18','10:30','Scheduled',15000.00,0.00,15000.00,'No insurance'),
(10,3828,208,3,'2025-01-19','09:30','Completed',50.00,40.00,10.00,'Vaccination program');