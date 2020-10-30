#UC1
CREATE DATABASE payroll_service;	#Create database
USE payroll_service;			#To use payroll_service database
SELECT DATABASE();			#To see current database

#UC2
CREATE TABLE employee_payroll	 	#Create table
(	
  id 			INT unsigned NOT NULL AUTO_INCREMENT, 	# Unique ID for record
  name 			VARCHAR(150) NOT NULL,		 	# Name of employee
  salary 		Double NOT NULL,		 	# Employee Salary
  start 		DATE NOT NULL,			 	# Employee Start Date
  PRIMARY KEY 		(id)				 	# Make id primary key
);
DESCRIBE employee_payroll; 		#Describe table

#UC3
INSERT INTO employee_payroll (name,salary,start) VALUES
	( 'Bill', 1000000.00, '2018-01-03' ),
	( 'Terisa', 2000000.00, '2019-11-13' ),
	( 'Charlie', 3000000.00, '2020-05-21' );

#UC4
SELECT * FROM employee_payroll; 				# Retrieving Records from Table

#UC5
SELECT salary from employee_payroll WHERE name = 'Bill';	# Selecting Bill entry
SELECT * FROM employee_payroll 
	WHERE start BETWEEN CAST('2018-01-01' AS DATE) AND DATE(NOW());

#UC6 
ALTER TABLE employee_payroll ADD gender CHAR(1) AFTER name; 	# Adding gender field
UPDATE employee_payroll set gender = 'F' where name = 'Terisa';
UPDATE employee_payroll set gender = 'M' where name = 'Bill' or name = 'CHARLIE';
UPDATE employee_payroll set salary = 3000000.00 where name = 'Terisa';

#UC7
SELECT AVG(salary) FROM employee_payroll 			#Group Functions
WHERE gender = 'M' GROUP BY gender; 	
SELECT gender, AVG(salary) FROM employee_payroll GROUP BY gender;
SELECT gender, COUNT(name) FROM employee_payroll GROUP BY gender;
SELECT gender, SUM(salary) FROM employee_payroll GROUP BY gender;
SELECT gender, MIN(salary) FROM employee_payroll GROUP BY gender;
SELECT gender, MAX(salary) FROM employee_payroll GROUP BY gender;

#UC8
#Ability to add new fields in employee_payroll table
ALTER TABLE employee_payroll ADD phone_number VARCHAR(250) AFTER name;
ALTER TABLE employee_payroll ADD address VARCHAR(250) AFTER phone_number;
ALTER TABLE employee_payroll ADD department VARCHAR(150) NOT NULL AFTER address;
ALTER TABLE employee_payroll ALTER address SET DEFAULT 'TBD';
