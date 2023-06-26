SELECT SalesPerson.Name AS 'Sales Person', SalesTerritory.Name AS Territory
FROM SalesPerson
	Inner Join SalesTerritory
				ON SalesPerson.SalesTerritoryId = SalesTerritory.SalesTerritoryId
ORDER BY [Sales Person];

SELECT SalesPerson.Name AS 'Sales Person', SalesTerritory.Name AS Territory, State.Name AS State, OfficeLocation.City AS City
FROM SalesPerson
	Full Join SalesTerritory
				ON salesperson.SalesTerritoryId = SalesTerritory.SalesTerritoryId
	Full Join State
				ON SalesTerritory.SalesTerritoryId = State.StateId
	Full Join OfficeLocation
				ON State.StateId = OfficeLocation.StateId
ORDER BY SalesPerson.Name;

SELECT SalesTerritory.Name AS Territory, SalesPerson.Name AS 'Sales Person'
FROM SalesTerritory
		Left Join SalesPerson
				ON SalesTerritory.SalesTerritoryId = SalesPerson.SalesTerritoryId
ORDER BY Territory;

SELECT SalesTerritory.Name AS Territory, SalesPerson.Name AS 'Sales Person', State.Name AS State, OfficeLocation.City AS City
FROM SalesTerritory
	Full Join SalesPerson
				ON salesTerritory.SalesTerritoryId = SalesPerson.SalesTerritoryId
	Full Join OfficeLocation
				ON SalesPerson.AssignedOfficeId = OfficeLocation.OfficeLocationId
	Full Join State
				ON OfficeLocation.StateId = State.StateId
ORDER BY [Territory];