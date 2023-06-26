/* Question 1 */
SELECT CONVERT(VARCHAR(20),GETDATE()-7,102) AS 'ANSI Week Old Date'

/* Question 2 */
DECLARE @Data VARCHAR(100) = 'Before software can be reusable it first has to be usable.'
SELECT '*' + SUBSTRING(@Data, (CHARINDEX (' has', @Data) + 1), LEN(@Data) - CHARINDEX('first ', @Data)) + '*' AS 'Key Point'

/* Question 3 */
SELECT RegionDescription, TerritoryDescription
FROM Region
INNER JOIN Territories ON Region.RegionID = Territories.RegionID
ORDER BY RegionDescription, TerritoryDescription

/* Question 4 */
SELECT ProductName AS 'Product Name', ROUND((ReorderLevel * 1.25) - (UnitsInStock + UnitsOnOrder), 0) AS 'Units to Order'
FROM Products
WHERE UnitsInStock + UnitsOnOrder < ReorderLevel

/* Question 5 */
SELECT CategoryName AS 'Category Name', ProductName AS 'Product Name', FORMAT(UnitPrice, 'C') AS 'Unit Price'
FROM Categories
INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE UnitPrice > (SELECT AVG(UnitPrice)
				  FROM Products)
ORDER BY CategoryName, ProductName


/* Question 6 */
SELECT TerritoryDescription, COALESCE(LastName + ', ' + FirstName, 'No Employees') AS 'Employee Name'
FROM Territories
FULL OUTER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL OUTER JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
ORDER BY TerritoryDescription, [Employee Name]

/* Question 7 */
SELECT count(LastName) AS 'Number of Employees', TerritoryDescription
FROM Territories
FULL OUTER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL OUTER JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
GROUP BY LastName, TerritoryDescription
ORDER BY [Number of Employees]DESC

/* Question 8 */
SELECT count(LastName) AS 'Number of Employees', RegionDescription
FROM Region
FULL OUTER JOIN Territories ON Region.RegionID = Territories.RegionID
FULL OUTER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL OUTER JOIN Employees On EmployeeTerritories.EmployeeID = Employees.EmployeeID
GROUP BY RegionDescription
ORDER BY [Number of Employees]DESC

/* Question 9 */
SELECT w.LastName+', '+w.FirstName AS 'Supervisor', COUNT(m.ReportsTo)  AS 'Number of Employees'
FROM Employees w, Employees m
WHERE w.EmployeeID = m.ReportsTo
GROUP BY w.LastName+', '+w.FirstName, w.EmployeeID
HAVING 4 >= w.EmployeeID

/* Question 10 */
SELECT count(LastName) AS 'Number of Employees', TerritoryDescription
FROM Territories
FULL OUTER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL OUTER JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
GROUP BY LastName, TerritoryDescription
HAVING 2 <= count(LastName)

/* I was able to get it this way as well but it produced 2 tables for Question 10 */
SELECT count(LastName) AS 'Number of Employees', TerritoryDescription
FROM Territories, Employees
GROUP BY LastName, TerritoryDescription
HAVING count(LastName) >= 2
(
SELECT count(LastName) AS 'Number of Employees', TerritoryDescription
FROM Territories
FULL OUTER JOIN EmployeeTerritories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
FULL OUTER JOIN Employees ON EmployeeTerritories.EmployeeID = Employees.EmployeeID
GROUP BY LastName, TerritoryDescription
HAVING count(LastName) >= 2
);