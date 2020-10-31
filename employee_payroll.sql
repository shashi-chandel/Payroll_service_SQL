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

#UC9	#Ability to rename salary to basic pay and add deductions, taxable pay tax and net pay column
ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
ALTER TABLE employee_payroll ADD deductions Double NOT NULL AFTER basic_pay;
ALTER TABLE employee_payroll ADD taxable_pay Double NOT NULL AFTER deductions;
ALTER TABLE employee_payroll ADD tax Double NOT NULL AFTER taxable_pay;
ALTER TABLE employee_payroll ADD net_pay Double NOT NULL AFTER tax;

#UC10	 #Ability to make Terisa as part of two department													
UPDATE employee_payroll SET department = 'Sales' WHERE name = 'Terisa';  
INSERT INTO employee_payroll
(name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) VALUES
('Terisa', 'Marketing', 'F', 3000000.00, 1000000.00, 2000000.00, 500000.00, 1500000.00, '2018-01-03');
SELECT * FROM employee_payroll WHERE name = 'Terisa';

#UC11	#Normalising the above table into smaller tables
CREATE TABLE company						
(
 company_id 	INT PRIMARY KEY, 				
 company_name 	VARCHAR(30) NOT NULL
);


CREATE TABLE employee 						
(
 id 		INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
 company_id 	INT REFERENCES company(company_id),
 phone_number 	VARCHAR(20) NOT NULL,
 address 	VARCHAR(50) NOT NULL DEFAULT 'TBD',
 gender 	CHAR(1) NOT NULL
);

CREATE TABLE payroll
(
 emp_id 	INT REFERENCES employee(id),
 basic_pay 	DOUBLE NOT NULL,
 deductions 	DOUBLE NOT NULL,
 taxable_pay 	DOUBLE NOT NULL,
 tax 		DOUBLE NOT NULL,
 net_pay 	DOUBLE NOT NULL
);

CREATE TABLE department
(
 dept_id 	INT PRIMARY KEY,
 dept_name 	VARCHAR(50) NOT NULL
);

CREATE TABLE employee_department
(
 emp_id 	INT REFERENCES employee(id),
 dept_id 	INT REFERENCES department(dept_id)
);


#Inserting data to company table
INSERT INTO company VALUES 					
 	(1,'Capgemini'),
 	(2,'Company B'),
 	(3,'Company C');
    
ALTER TABLE employee 
ADD COLUMN employee_name VARCHAR(20) NOT NULL AFTER company_id;

#Inserting data to employee table
INSERT INTO employee VALUES 					
 	(101, 1, 'Bill', '9876543210', 'California', 'M' ),
	(102, 1, 'Terisa', '8876543211', 'San Francisco', 'F' ),
	(103, 2, 'Charlie', '7876543212', 'New York', 'M' );


INSERT INTO payroll VALUES 			#Inserting data to payroll table corresponding to employee_id
 	(101,50000,5000,45000,5000,40000),
 	(102,20000,2000,18000,3000,15000),
 	(103,60000,6000,54000,4000,50000);
    
INSERT INTO department VALUES  		#Inserting data to department table 

 	(201, 'Sales'),
 	(202, 'Marketing'),
 	(203, 'Logistics'),
 	(204, 'Management');
  
#Inserting data to emp_department table   
INSERT INTO employee_department VALUES  				
 	(101,203),
 	(102,201),
 	(102,202),
 	(103,204);
    
#UC12
#Retrieving data from tables
  select * from employee;
  select * from employee_department; 
  select * from department; 
  select * from payroll;
  select * from company;