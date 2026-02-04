# Basic Level

#1 Retrieve the names of employees who earn more than the average salary of all employees.

create database newdatabase_db;
use newdatabase_db;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id VARCHAR(10),
    salary INT
);
INSERT INTO Employee (emp_id, name, department_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

SELECT name
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

#2 Find the employees who belong to the department with the highest average salary.

SELECT department_id, AVG(salary)
FROM Employee
GROUP BY department_id;
SELECT MAX(avg_salary)
FROM (
    SELECT AVG(salary) AS avg_salary
    FROM Employee
    GROUP BY department_id
) t;
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT AVG(salary) AS avg_salary
        FROM Employee
        GROUP BY department_id
    ) t
);
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) = (
        SELECT MAX(avg_salary)
        FROM (
            SELECT AVG(salary) AS avg_salary
            FROM Employee
            GROUP BY department_id
        )t
    )
);

#3 List all employees who have made at least one sale.

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount INT,
    sale_date DATE
);

INSERT INTO Sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

SELECT emp_id FROM Sales;

SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
);

#4 Find the employee with the highest sale amount.

SELECT MAX(sale_amount)
FROM Sales;
SELECT emp_id
FROM Sales
WHERE sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales
);
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
    )
);

#5 Retrieve the names of employees whose salaries are higher than Shubham’s salary.

SELECT salary
FROM Employee
WHERE name = 'Shubham';
SELECT name
FROM Employee
WHERE salary > (
    SELECT salary
    FROM Employee
    WHERE name = 'Shubham'
);

# Intermediate Level

#1 Find employees who work in the same department as Abhishek.

SELECT department_id
FROM Employee
WHERE name = 'Abhishek';
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'Abhishek'
);
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'Abhishek'
)
AND name <> 'Abhishek';

#2 List departments that have at least one employee earning more than ₹60,000.

SELECT DISTINCT department_id
FROM Employee
WHERE salary > 60000;
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT DISTINCT department_id
    FROM Employee
    WHERE salary > 60000
);

#3 Find the department name of the employee who made the highest sale.

SELECT MAX(sale_amount)
FROM Sales;
SELECT emp_id
FROM Sales
WHERE sale_amount = (
    SELECT MAX(sale_amount)
    FROM Sales
);
SELECT department_name
FROM Department
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE emp_id = (
        SELECT emp_id
        FROM Sales
        WHERE sale_amount = (
            SELECT MAX(sale_amount)
            FROM Sales
        )
    )
);

#4 Retrieve employees who have made sales greater than the average sale amount.

SELECT AVG(sale_amount)
FROM Sales;
SELECT emp_id
FROM Sales
WHERE sale_amount > (
    SELECT AVG(sale_amount)
    FROM Sales
);
SELECT name
FROM Employee
WHERE emp_id IN (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount > (
        SELECT AVG(sale_amount)
        FROM Sales
    )
);

#5 Find the total sales made by employees who earn more than the average salary.

SELECT AVG(salary)
FROM Employee;
SELECT emp_id
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);
SELECT SUM(sale_amount) AS total_sales
FROM Sales
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee
    WHERE salary > (
        SELECT AVG(salary)
        FROM Employee
    )
);

#Advanced Level

#1 Find employees who have not made any sales.

SELECT emp_id
FROM Sales;
SELECT name
FROM Employee
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Sales
);

#2 List departments where the average salary is above ₹55,000.

SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT department_id
    FROM Employee
    GROUP BY department_id
    HAVING AVG(salary) > 55000
);

#3 Retrieve department names where the total sales exceed ₹10,000.

SELECT e.department_id
FROM Employee e
JOIN Sales s ON e.emp_id = s.emp_id
GROUP BY e.department_id
HAVING SUM(s.sale_amount) > 10000;
SELECT department_name
FROM Department
WHERE department_id IN (
    SELECT e.department_id
    FROM Employee e
    JOIN Sales s ON e.emp_id = s.emp_id
    GROUP BY e.department_id
    HAVING SUM(s.sale_amount) > 10000
);

#4 Find the employee who has made the second-highest sale.

SELECT MAX(sale_amount)
FROM Sales;
SELECT MAX(sale_amount)
FROM Sales
WHERE sale_amount < (
    SELECT MAX(sale_amount)
    FROM Sales
);
SELECT name
FROM Employee
WHERE emp_id = (
    SELECT emp_id
    FROM Sales
    WHERE sale_amount = (
        SELECT MAX(sale_amount)
        FROM Sales
        WHERE sale_amount < (
            SELECT MAX(sale_amount)
            FROM Sales
        )
    )
);

#5 Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

SELECT MAX(sale_amount)
FROM Sales;
SELECT name
FROM Employee
WHERE salary > (
    SELECT MAX(sale_amount)
    FROM Sales
);












































