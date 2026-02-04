#Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?

#Sol. A Common Table Expression (CTE) is a temporary named result set that you define inside a SQL query using the WITH keyword.
# It exists only for that single query and is not stored permanently in the database.
-- Instead of writing one long, confusing query with many subqueries, a CTE lets you:
#Separate logic into steps
#Give meaningful names to intermediate results.

-- With CTE (clean & readable)
WITH ProductRevenue AS (
    SELECT ProductID,
           SUM(Price * Quantity) AS Revenue
    FROM Sales
    GROUP BY ProductID
)
SELECT *
FROM ProductRevenue
WHERE Revenue > 3000;

#Q2. Why are some views updatable while others are read-only? Explain with an example.

#Sol. An updatable view is a view where you can perform INSERT, UPDATE, or DELETE operations, and those changes directly affect the base table.
-- A view is updatable when:

#It is based on only one table
#It does not use:
#JOIN
#GROUP BY
#Aggregate functions (SUM, AVG, etc.)
#DISTINCT
#UNION
-- Because in this case, each row in the view maps directly to one row in the base table.

# Example: Updatable View
-- Products
-- (ProductID, ProductName, Price)
CREATE VIEW vw_ProductBasic AS
SELECT ProductID, ProductName, Price
FROM Products;
UPDATE vw_ProductBasic 
SET 
    Price = 500
WHERE
    ProductID =1;

#Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?

# Sol. A stored procedure is a precompiled set of SQL statements stored in the database that can be executed using a single command.
# Advantages of Stored Procedures
-- 1. Better Performance
# Stored procedures are precompiled
# Execution is faster than running raw SQL again and again
-- 2. Reusability
# Write once, use many times
# Avoids repeating the same SQL logic in multiple places
-- 3. Improved Security
# Users can execute procedures without direct access to tables
# Helps prevent SQL injection
-- 4. Easier Maintenance
# Business logic is stored in one place
# Changes are made in the procedure, not in every application query]
-- 5. Reduced Network Traffic
# Only the procedure name and parameters are sent
# Not the full SQL code every time

#Example
CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT * FROM Products;
END;
-- EXEC GetAllProducts;

#Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.

# Sol. A trigger is a special database object that automatically executes when a specific event occurs on a table.
#Purpose of Triggers
-- 1. Enforce Business Rules
# Triggers ensure certain rules are always followed, even if data is modified directly.
-- 2. Maintain Data Integrity
# They help keep data accurate and consistent across tables.
-- 3. Automatic Auditing & Logging
# Triggers can record changes like:
# Who deleted data
# When the change happened
-- 4. Prevent Invalid Operations
# Triggers can stop unwanted updates or deletions.

#Essential Use Case Example Archiving Deleted Records
# When a product is deleted, we want to store it in an archive table instead of losing the data.
CREATE TRIGGER trg_AfterDeleteProduct
ON Products
AFTER DELETE
AS
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
    SELECT ProductID, ProductName, Category, Price, GETDATE()
    FROM deleted;
END;

#Q5. Explain the need for data modelling and normalization when designing a database.

#Sol. -- Data modelling is the process of defining:

# Tables
# Columns
# Relationships between tables

-- Need for Data Modelling
Clear structure
#Helps understand how data is stored and related.

Avoids confusion & redundancy
#Prevents storing the same data in multiple places.

Ensures correct relationships
#Uses primary keys and foreign keys properly.

Improves database performance
#Well-designed models make queries faster.
 
-- Normalization is the process of organizing data to:
#Reduce data duplication
#Improve data integrity

-- Benefits of Normalization
#Eliminates Data Redundancy
#Improves Data Consistency
#Prevents Insert, Update, Delete Anomalies
#Better Maintenance

#Q6. Write a CTE to calculate the total revenue for each product 
 -- (Revenues = Price × Quantity), and return only products where  revenue > 3000.
create DATABASE advanced_db;
use advanced_db;
WITH ProductRevenue AS (
    SELECT 
        ProductID,
        ProductName,
        SUM(Price * Quantity) AS TotalRevenue
    FROM Products
    GROUP BY ProductID, ProductName
)

SELECT *
FROM ProductRevenue
WHERE TotalRevenue > 3000;

#Q7. Create a view named that shows:  vw_CategorySummary
 -- Category, TotalProducts, AveragePrice.
 
 CREATE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(*) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;
SELECT * FROM vw_CategorySummary;

#Q8. Create an updatable view containing ProductID, ProductName, and Price. 
 # Then update the price of ProductID = 1 using the view.
 
 CREATE VIEW vw_ProductUpdate AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;
UPDATE vw_ProductUpdate
SET Price = 750
WHERE ProductID = 1;
SELECT * FROM vw_ProductUpdate
WHERE ProductID = 1;

#Q9. Create a stored procedure that accepts a category name and returns all products belonging to that 
#category.

CREATE PROCEDURE GetProductsByCategory
    @CategoryName VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Products
    WHERE Category = @CategoryName;
END;
-- EXEC GetProductsByCategory 'Electronics';

#Q10. Create an AFTER DELETE trigger on the table that archives deleted product rows into a new Products
#table . The archive should store ProductID, ProductName, Category, Price, and DeletedAt ProductArchive
#timestamp.

CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);
CREATE TRIGGER trg_AfterDeleteProducts 
on Products
AFTER DELETE
AS
BEGIN
    INSERT INTO ProductArchive
        (ProductID, ProductName, Category, Price, DeletedAt)
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price,
        GETDATE()
    FROM deleted;