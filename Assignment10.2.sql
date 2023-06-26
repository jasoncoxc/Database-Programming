/* Question 2*/
Drop Function If Exists Cheap
Go

Create Function Cheap
(
@UnitPriceq Int
)
Returns @CheapCost Table
(
	ProductNameq NVarChar(50),
	PriceInfoq NVarChar(50),
	UnitPriceq Float
)
As
Begin
	
	Insert Into @CheapCost (ProductNameq, PriceInfoq, UnitPriceq)
	SELECT ProductName,'Costliest' AS 'Price Info', UnitPrice
	FROM Products
	WHERE UnitPrice = (SELECT MAX(UnitPrice)
						FROM Products)
	UNION
	SELECT ProductName, 'Cheapest' AS 'Price Info', UnitPrice
	FROM Products
	WHERE UnitPrice = (SELECT MIN(UnitPrice)
					FROM Products)	
	Begin	
		
	Insert Into @CheapCost (ProductNameq, PriceInfoq, UnitPriceq)		
	SELECT ProductName,'Costliest' AS 'Price Info', UnitPrice
	FROM @CheapCost C
		Inner Join Products P
		ON ProductNameq = ProductName	
	UNION
	SELECT ProductName, 'Cheapest' AS 'Price Info', UnitPrice
	FROM @CheapCost C
		Inner Join Products P
		ON ProductNameq = ProductName;
		End
Return;
End;