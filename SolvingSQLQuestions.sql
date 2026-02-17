CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE Doctor(
    Doc_id int PRIMARY KEY,
    Name VARCHAR(50),
    Contact int
);


CREATE TABLE Patient(
    P_id int PRIMARY KEY,
    Name VARCHAR(50),
    Doc_id int,
    FOREIGN KEY (Doc_id) REFERENCES Doctor(Doc_id) 
);


CREATE TABLE Clinic(
    Medicine_id int PRIMARY KEY,
    M_Name VARCHAR(50),
    P_id INT,
    FOREIGN KEY (P_id) REFERENCES Patient(P_id)  
);

CREATE TABLE Administration(
    Ad_id INT PRIMARY KEY,
    Name VARCHAR(50),
    Doc_salary DECIMAL(10,2),
    Patient_expenses DECIMAL(10,2),
    P_id INT,
    Doc_id INT,
    FOREIGN KEY (P_id) REFERENCES Patient(P_id),  
    FOREIGN KEY (Doc_id) REFERENCES Doctor(Doc_id) 
);


INSERT INTO Doctor(Doc_id,Name,Contact) VALUES 
 (1, 'Dr. Ram', 9876543210),
 (2, 'Dr. Sita', 9876543211),
 (3, 'Dr. Hari', 9876543212),
 (4, 'Dr. Mina', 9876543213),
 (5, 'Dr. Ramesh', 9876543214);

 ALTER TABLE Doctor
ALTER COLUMN Contact BIGINT NOT NULL;

INSERT INTO Patient(P_id, Name, Doc_id) VALUES
(101, 'Asmita', 1),
(102, 'Ram', 2),
(103, 'Sita', 3),
(104, 'Hari', 4),
(105, 'Mina', 5);

INSERT INTO Clinic(Medicine_id, M_Name, P_id) VALUES
(201, 'Paracetamol', 101),
(202, 'Ibuprofen', 102),
(203, 'Amoxicillin', 103),
(204, 'Cetirizine', 104),
(205, 'Vitamin C', 105);


INSERT INTO Administration(Ad_id, Name, Doc_salary, Patient_expenses, P_id, Doc_id) VALUES
(301, 'Admin A', 5000.00, 1000.00, 101, 1),
(302, 'Admin B', 5500.00, 1200.00, 102, 2),
(303, 'Admin C', 6000.00, 1100.00, 103, 3),
(304, 'Admin D', 5200.00, 1300.00, 104, 4),
(305, 'Admin E', 5800.00, 1250.00, 105, 5);

--which medicine is bought by P_id=103
SELECT c.M_Name,p.Name
FROM Clinic c
JOIN Patient p
ON c.P_id = p.P_id
WHERE c.P_id=103;

--what is the salary of Doc_id=5
SELECT d.Name,a.Doc_salary
FROM Doctor d
JOIN Administration a
ON d.Doc_id=a.Doc_id
WHERE d.Doc_id=5;

--Name the docter who checked up P_id = 2 & 3
SELECT d.Name,p.P_id
FROM Doctor d
JOIN Patient p
ON d.Doc_id=p.Doc_id
WHERE p.P_id IN (102,103);

--add column in table name: 'Doctor' and  'Patient' Column 'Address'
ALTER TABLE Doctor 
ADD Address VARCHAR(50);

ALTER TABLE Patient 
ADD Address VARCHAR(50);

--add values in the column
UPDATE Doctor
SET Address = 'Patan'
WHERE Doc_id = 1;

UPDATE Doctor
SET Address = 'Lagankhel'
WHERE Doc_id = 2;

UPDATE Doctor
SET Address = 'Maitidevi'
WHERE Doc_id = 3;

UPDATE Doctor
SET Address = 'Lubho'
WHERE Doc_id = 4;

UPDATE Doctor
SET Address = 'Patan'
WHERE Doc_id = 5;

SELECT * FROM Doctor;

UPDATE Patient
SET Address = 'Patan'
WHERE P_id = 101;

UPDATE Patient
SET Address = 'Lagankhel'
WHERE P_id = 102;

UPDATE Patient
SET Address = 'Maitidevi'
WHERE P_id = 103;

UPDATE Patient
SET Address = 'Lubho'
WHERE Doc_id = 4;

UPDATE Patient
SET Address = 'Patan'
WHERE Doc_id = 5;

SELECT * FROM Patient;
SELECT * FROM Doctor;


--delete value of both table where id=1,2
DELETE FROM Doctor
WHERE Doc_id IN (1,2);

DELETE FROM Patient
WHERE Doc_id IN (1,2);

DELETE FROM Administration
WHERE P_id IN (101,102);

DELETE FROM Clinic
WHERE P_id IN (101,102);

--drop column 'Address' from table 'Docter'
ALTER TABLE Doctor
DROP COLUMN Address;



