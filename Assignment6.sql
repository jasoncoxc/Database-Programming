/* Question 1 */
SELECT ShipCountry as Country, count(*) as 'Number of Orders'
FROM Orders
WHERE ShipCountry IN ('Denmark', 'Finland', 'Norway', 'Sweden')
GROUP BY ShipCountry
ORDER BY ShipCountry

/* Question 2 */
SELECT LastName + ', ' + FirstName AS 'Employee Name', 
format(sum(isnull(UnitPrice * Quantity,0.0)), 'C') AS 'Employee Total',
format(sum(isnull(UnitPrice * Quantity * .02, 0.0)), 'c') AS 'Employee 2% Commision'
FROM Employees
Inner Join Orders ON Employees.EmployeeID = Orders.EmployeeID
Inner Join [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY LastName, FirstName
ORDER BY LastName, FirstName

/* Question 3 */
SELECT format(isnull(ExtendedPrice, 0.0), 'C') AS 'Discount Line Item Value', Invoices.OrderID, Invoices.ProductID 
FROM Invoices
Inner Join [Order Details] ON Invoices.OrderID = [Order Details].OrderID
GROUP BY Invoices.OrderID, Invoices.ProductID, ExtendedPrice
HAVING 587 < avg(ExtendedPrice)
ORDER BY ExtendedPrice