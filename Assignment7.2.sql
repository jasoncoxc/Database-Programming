/* Question 4 */
DROP TABLE IF EXISTS MyProducts;
GO

CREATE TABLE MyProducts
(
MyProductsId INT NOT NULL IDENTITY PRIMARY KEY,
[Name] NVARCHAR(40) NOT NULL,
UnitPrice MONEY NOT NULL
)

SET IDENTITY_INSERT MyProducts ON
GO

INSERT INTO MyProducts (MyProductsId, [Name], UnitPrice)
VALUES
(5, 'Golden Product', 999.99)

INSERT INTO MyProducts (MyProductsId, [Name], UnitPrice)
SELECT ProductID + 10, ProductName, UnitPrice
FROM Products
WHERE ProductID BETWEEN 1 AND 10

SET IDENTITY_INSERT MyProducts OFF
GO