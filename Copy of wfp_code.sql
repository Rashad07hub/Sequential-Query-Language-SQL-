DROP TABLE IF EXISTS wfp;
DROP TABLE IF EXISTS beneficiaries;
DROP TABLE IF EXISTS distributions;

CREATE TABLE beneficiaries (
  Beneficiary_ID VARCHAR NOT NULL,
  Name CHAR(20) NOT NULL,
  District CHAR(20) NOT NULL,
  Household_Size INT,
  Gender CHAR NOT NULL
);

INSERT INTO beneficiaries VALUES
('B001','Rahim','Dhaka',5,'M'),
('B002','Kahim','dhaka',3,'M'),
('B003','Ayesha','Coxs Bazar',7,'F'),
('B004','Fatema','DHAKA',2,'F'),
('B005','Salma','Khulna',6,'F'),
('B006','Jamal','Barisal',4,'M');

SELECT*FROM beneficiaries;

CREATE TABLE distributions (
  distribution_ID VARCHAR(20) NOT NULL,
  beneficiary_ID  VARCHAR(20) NOT NULL,
  district CHAR(15),
  food_ration INT,
  distribution_date DATE 
);

INSERT INTO distributions VALUES
('D001','B001','Dhaka',50,'2025-10-01'),
('D002','B002','Dhaka',30,'2025-01-12'),
('D003','B001','Coxs Bazar',20,'2025-02-01'),
('D004','B003','Khulna',70,'2025-01-15'),
('D005','B006','Barisal',40,'2025-02-10');

SELECT*FROM distributions;

CREATE TABLE wfp (
  Beneficiary_ID INT NOT NULL,
  District VARCHAR(10) NOT NULL,
  Gender VARCHAR(1) NOT NULL,
  Household_Size INT NOT NUll,
  Assistance_Type VARCHAR(10) NOT NULL,
  Ration_kg INT,
  Month CHAR(3)
);

INSERT INTO wfp VALUES
(1001,'Dhaka','F',5,'Food',25,'Jan'),
(1002,'Khulna','M',4,'Cash',0,'Jan'),
(1003,'Dhaka','F',6,'Food',30,'Feb'),
(1004,'Rangpur','M',3,'Food',15,'Feb'),
(1005,'Khulna','F',7,'Food',35,'Mar'),
(1006,'Dhaka','M',4,'Cash',0,'Mar'),
(1007,'Rangpur','F',5,'Food',25,'Apr'),
(1008,'dhaka','F',6,'Food',30,'Apr'),
(1009,'DHAKA','M',2,'Cash',0,'May'),
(1010,'Khulna','F',8,'Food',40,'May'),
(1011,'Rangpur','M',6,'Food',30,'Jun'),
(1012,'Dhaka','F',5,'Food',25,'Jun');

SELECT * FROM wfp;

CREATE TABLE nutrition(
	beneficiary_id VARCHAR(4) NOT NULL,
	nutrition_status CHAR(20) NOT NULL
);

INSERT INTO nutrition VALUES
('B001','Normal'),
('B002','Moderate'),
('B003','Severe'),
('B004','Normal');

SELECT*FROM nutrition;



