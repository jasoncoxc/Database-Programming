/* Question 1 */
SELECT 'Most Expensive' AS 'Price Info', ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice)
					FROM Products)

/* Question 2 */
SELECT 'Cheapest' AS 'Price Info', ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice)
					FROM Products)

/* Question 3 */
SELECT 'Most Expensive' AS 'Price Info', ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice)
					FROM Products)
UNION
SELECT 'Cheapest' AS 'Price Info', ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice)
					FROM Products)