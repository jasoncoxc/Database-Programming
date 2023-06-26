DROP TABLE IF EXISTS dbo.ErrorLog;
GO

CREATE TABLE dbo.ErrorLog
(
ErrorLogId INT NOT NULL IDENTITY PRIMARY KEY
,ErrorDateTime DATETIME NOT NULL
,ErrorNumber INT NOT NULL
,ErrorLocation VARCHAR(MAX)
,ErrorMessage VARCHAR(MAX) NOT NULL
);
GO

DROP TABLE IF EXISTS dbo.MyOrders;
GO

CREATE TABLE dbo.MyOrders
(
MyOrdersId INT NOT NULL IDENTITY PRIMARY KEY
,OrderDate DATETIME NOT NULL CHECK (GETDATE() >= OrderDate)
,CustomerName VARCHAR(100) NOT NULL
);
GO


Drop Proc If Exists dbo.MyOrdersInsert;
Go

Create Proc dbo.MyOrdersInsert
@OrderDate DateTime,
@CustomerName VarChar(100),
@NewOrderId Int OutPut
As
Begin
	Set NoCount On;
	Set @NewOrderId = 0;
	Begin Try
	Insert Into dbo.MyOrders (OrderDate, CustomerName)
	Values (@OrderDate, @CustomerName)
	Set @NewOrderId = SCOPE_IDENTITY();
	Return 0;
	End Try
	Begin Catch	
	Insert Into dbo.ErrorLog (ErrorDateTime, ErrorNumber, ErrorLocation, ErrorMessage)
	Values (GETDATE(), ERROR_NUMBER(), ERROR_PROCEDURE(), ERROR_MESSAGE())	
	Return Error_Number();
	End Catch
	
End;
Go