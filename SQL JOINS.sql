# Question 1. Retrieve all customers who have placed at least one order.

CREATE DATABASE sql_joins;
use sql_joins;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT
);
INSERT INTO Customers VALUES
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Robert White', 'Houston'),
(5, 'Nancy Miller', 'Miami');
INSERT INTO Orders VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450);
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

#Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City,
    o.OrderID,
    o.OrderDate,
    o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

#Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown 
#customers.

SELECT 
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.Amount,
    c.CustomerName,
    c.City
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

#Question 4. Display all customers and orders, whether matched or not.

SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.Amount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID

UNION

SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.Amount
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

#Question 5. Find customers who have not placed any orders.

SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

#Question 6. Retrieve customers who made payments but did not place any orders.

SELECT DISTINCT
    p.CustomerID,c.CustomerName
FROM Payments p
LEFT JOIN Orders o
ON p.CustomerID = o.CustomerID
LEFT JOIN Customers c
ON p.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL;

#Question 7. Generate a list of all possible combinations between Customers and Orders. 

SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    o.Amount
FROM Customers c
CROSS JOIN Orders o;

# Question 8. Show all customers along with order and payment amounts in one table.

SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.Amount AS OrderAmount,
    p.PaymentID,
    p.Amount AS PaymentAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON c.CustomerID = p.CustomerID;

# Question 9. Retrieve all customers who have both placed orders and made payments.

SELECT DISTINCT
    c.CustomerID,
    c.CustomerName
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN Payments p
ON c.CustomerID = p.CustomerID;






