# Q1 Create a New Database and  Table for Employees
# Task : Task: Create a new database named and Create a table named with the following 
# columns

create database company_db;
use company_db;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
    );
    
select * from employees;

#Q2. Insert Data into Employees Table
#Task: Insert the following sample records into the table

INSERT INTO employees (employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');

select * from employees;

# Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
#Hint: Use the clause on the salary column.

SELECT *
FROM employees
ORDER BY salary ASC;

# qUESTION 4  Show Employees Sorted by Department (A–Z) and Salary (High → Low)

 select *
 from EMPLOYEES 
 order by DEPARTMENT ASC, SALARY desc;
 
  #QUESTION 5 List All Employees in the IT Department, Ordered by Hire Date (Newest First)
 
 SELECT *
FROM Employees
WHERE department = 'IT'
ORDER BY hire_date DESC;

# Q6 Create and Populate a Sales Table
#Task: Create a table to track sales data:

 CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    amount INT,
    sale_date DATE
);

INSERT INTO Sales (sale_id, customer_name, amount, sale_date)
VALUES
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-08'),
(3, 'Aditi', 3500, '2024-08-10'),
(4, 'Meena', 7700, '2024-08-15'),
(5, 'Rohan', 4500, '2024-08-25');

Select * from employees;

#Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
#Hint: Use ORDER BY AMOUNT DESC

select *
FROM SALES
order by AMOUNT DESC;

#Q8. Show All Sales Made by Customer “Aditi”
#Hint: Use

select *
from SALES
WHERE CUSTOMER_NAME ='ADITI';

#Q9. What is the Difference Between a Primary Key and a Foreign Key?

#Primary Key
#Purpose: Uniquely identifies each row in a table.
#Uniqueness: Must contain unique values; no duplicates allowed.
#NULL Values: Cannot contain NULL values.
#Quantity: A table can have only one primary key. 
#Foreign Key
#Purpose: Establishes a link or relationship between two tables.
#Uniqueness: Can contain duplicate values.
#NULL Values: Can contain NULL values (unless otherwise specified).
#Quantity: A table can have multiple foreign keys. 

#Q10. What Are Constraints in SQL and Why Are They Used?
 
# Constraints in SQL are rules that define how data should be stored in a database to maintain accuracy and reliability. They prevent invalid or inconsistent data from being entered.
#- NOT NULL → Ensures a column cannot have empty values.
#- UNIQUE → Guarantees that all values in a column are different.
#- PRIMARY KEY → Identifies each row uniquely in a table.
#- FOREIGN KEY → Maintains relationships between tables by linking columns.
#- CHECK → Restricts values based on a condition (e.g., age > 18).
#- DEFAULT → Provides a preset value if none is given.



