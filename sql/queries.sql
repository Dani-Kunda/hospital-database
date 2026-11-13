-- Q1
SELECT * FROM department;

-- Q2
SELECT contact_number, address FROM patient WHERE first_name = 'John' AND last_name = 'Bob' AND patient_id = 5612;

-- Q3
SELECT patient_id, first_name, last_name, contact_number, address FROM patient WHERE patient_id = 3456;
UPDATE patient SET contact_number = '087-9998888', address = '15 New Street, Dublin' WHERE patient_id = 3456;
SELECT patient_id, first_name, last_name, contact_number, address FROM patient WHERE patient_id = 3456;

-- Q4
INSERT INTO appointment (appointment_id, patient_id, doctor_id, treatment_id, appointment_date, appointment_time, status, actual_cost, insurance_covered, patient_payment, cost_adjustment_reason) 
VALUES (16, 3824, 203, 3, '2025-02-01', '14:30:00', 'Scheduled', 50.00, 40.00, 10.00, 'New appointment');

-- Q5
SELECT p.* FROM patient p JOIN medical_history mh ON p.patient_id = mh.patient_id WHERE mh.condition_name = 'Diabetes';

-- Q6
SELECT p.first_name, p.last_name FROM patient p 
JOIN appointment a ON p.patient_id = a.patient_id 
JOIN doctor d ON a.doctor_id = d.doctor_id 
WHERE d.first_name = 'Kevin' AND d.last_name = 'Smith';

-- Q7
SELECT department_name FROM department WHERE department_name = 'Orthopedics';
UPDATE department SET department_name = 'Orthopedic Surgery Department' WHERE department_name = 'Orthopedics';
SELECT department_name FROM department WHERE department_name = 'Orthopedic Surgery Department';

-- Q8
SELECT first_name, last_name, hire_date FROM doctor ORDER BY hire_date DESC;

-- Q9
SELECT COUNT(DISTINCT patient_id) as patient_count FROM appointment WHERE treatment_id = 1 AND status != 'Cancelled';

-- Q10
INSERT INTO department VALUES (11, 'Gastroenterology', '01-5556666');
INSERT INTO staff VALUES (132, 'Rachel', 'Green', 'Nurse', '2023-01-15', 2, 11);
INSERT INTO doctor VALUES (211, 'James', 'Wilson', '2022-08-20', 'Gastroenterologist', 11, 135.00);
INSERT INTO patient VALUES (3829, 'Emma', 'Thompson', '67 River Road', '0861112222', 'Digestive Issues', 'VHI Healthcare');
INSERT INTO treatment VALUES (11, 'Endoscopy', 'Internal examination', 800.00, 45, 11);
INSERT INTO appointment VALUES (17, 3829, 211, 11, '2025-02-02', '11:00:00', 'Scheduled', 800.00, 640.00, 160.00, 'Initial consultation');

-- Q11
DELETE FROM appointment WHERE appointment_id = 17;
DELETE FROM treatment WHERE treatment_id = 11;
DELETE FROM patient WHERE patient_id = 3829;
DELETE FROM doctor WHERE doctor_id = 211;
DELETE FROM staff WHERE staff_id = 132;
DELETE FROM department WHERE department_id = 11;

-- Q12
SELECT first_name, last_name, days_off FROM staff ORDER BY days_off ASC;

-- Q13
SELECT staff_id, first_name, last_name, job_title FROM staff WHERE job_title = 'Office worker';
UPDATE staff SET job_title = 'Administrator' WHERE job_title = 'Office worker';
SELECT staff_id, first_name, last_name, job_title FROM staff WHERE job_title = 'Administrator';

-- Q14
SELECT department_name, phone_number FROM department WHERE department_name = 'Orthopedic Surgery Department';
UPDATE department SET phone_number = '01-7654321' WHERE department_name = 'Orthopedic Surgery Department';
SELECT department_name, phone_number FROM department WHERE department_name = 'Orthopedic Surgery Department';

-- Q15
SELECT staff_id, first_name, last_name, job_title FROM staff WHERE job_title = 'CEO';
UPDATE staff SET first_name = 'Michael', last_name = 'Dean' WHERE job_title = 'CEO';
SELECT staff_id, first_name, last_name, job_title FROM staff WHERE job_title = 'CEO';

-- Q16
SELECT first_name, last_name, hire_date FROM staff WHERE hire_date < '2021-11-21';

-- Q17
SELECT p.first_name, p.last_name, mh.condition_name, a.appointment_date, a.appointment_time, t.treatment_name 
FROM patient p 
LEFT JOIN medical_history mh ON p.patient_id = mh.patient_id 
LEFT JOIN appointment a ON p.patient_id = a.patient_id 
LEFT JOIN treatment t ON a.treatment_id = t.treatment_id;

-- Q18
SELECT COUNT(*) as patients_with_road FROM patient WHERE address LIKE '%road%';

-- Q19
CREATE VIEW PatientAppointmentDetails AS 
SELECT p.first_name AS patient_first, p.last_name AS patient_last, 
d.first_name AS doctor_first, d.last_name AS doctor_last, 
a.appointment_date, a.appointment_time, t.treatment_name 
FROM appointment a 
JOIN patient p ON a.patient_id = p.patient_id 
JOIN doctor d ON a.doctor_id = d.doctor_id 
LEFT JOIN treatment t ON a.treatment_id = t.treatment_id;

-- Q20
SELECT COUNT(*) as appointments_before FROM appointment;
DELETE FROM appointment;
SELECT COUNT(*) as appointments_after FROM appointment;