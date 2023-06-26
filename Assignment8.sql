/* Question 1 */
SELECT LastName, FirstName, Title
FROM Employees a
	Inner Join EmployeeTerritories w on w.EmployeeID = a.EmployeeID
	Inner Join Territories t on w.TerritoryID = t.TerritoryID
Where TerritoryDescription = 'Boston';

BEGIN TRAN;
With CTE_Territory(TerritoryDescription, EmployeeId) AS(
Select TerritoryDescription, EmployeeId
From Territories
	Inner Join EmployeeTerritories on Territories.TerritoryID = EmployeeTerritories.TerritoryID
Where TerritoryDescription = 'Boston'
)
Update Employees
Set Title = 'Boston - ' + Title
From Employees
	Inner join CTE_Territory on Employees.EmployeeID = CTE_Territory.EmployeeId;

SELECT LastName, FirstName, Title
FROM Employees a
	Inner Join EmployeeTerritories w on w.EmployeeID = a.EmployeeID
	Inner Join Territories t on w.TerritoryID = t.TerritoryID
Where TerritoryDescription = 'Boston';

Rollback;
SELECT LastName, FirstName, Title
FROM Employees a
	Inner Join EmployeeTerritories w on w.EmployeeID = a.EmployeeID
	Inner Join Territories t on w.TerritoryID = t.TerritoryID
Where TerritoryDescription = 'Boston';

/* Question 2 */
Select EmployeeID, LastName, FirstName, Title
From Employees
Where LastName Like 'K%'

Begin Tran;
 DELETE FROM EmployeeTerritories
WHERE EmployeeID IN (SELECT EmployeeID
FROM Employees
WHERE LastName LIKE 'K%');

DELETE FROM [Order Details]
WHERE OrderId IN (SELECT O.OrderID
FROM Orders O
WHERE O.EmployeeID IN (SELECT E.EmployeeID
FROM Employees E
WHERE LastName LIKE 'K%'));

DELETE FROM Orders
WHERE Orders.EmployeeID IN (SELECT EmployeeID
FROM Employees
WHERE LastName LIKE 'K%');

DELETE FROM Employees
WHERE LastName LIKE 'K%';

Select EmployeeID, LastName, FirstName, Title
From Employees
Where LastName Like 'K%'

Rollback;
Select EmployeeID, LastName, FirstName, Title
From Employees
Where LastName Like 'K%'
