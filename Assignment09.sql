/* Question 1a */
Drop View If Exists Schedule
Go

Create View Schedule
With Schemabinding
As
Select dbo.student.lastname + ', ' + dbo.student.firstname As 'Student',
dbo.academicyear.name + ' ' + dbo.course.prefix + ' ' + dbo.course.number + ' ' + dbo.section.letter As 'Section',
dbo.instructor.lastname + ', ' + dbo.instructor.firstname As 'Instructor'
From dbo.Student
	Inner Join dbo.studentenrolledsection on dbo.student.studentid = dbo.studentenrolledsection.studentid
	Inner Join dbo.section on dbo.studentenrolledsection.sectionid = dbo.section.sectionid
	Inner Join dbo.course on dbo.section.courseid = dbo.course.courseid
	Inner Join dbo.instructorteachessection on dbo.section.sectionid = dbo.instructorteachessection.sectionid
	Inner Join dbo.instructor on dbo.instructorteachessection.instructorid = dbo.instructor.instructorid
	Inner Join dbo.academicyear on dbo.section.academicyearid = dbo.academicyear.academicyearid

With Check Option
Go
Select *
From Schedule
Order By Student, Section, Instructor

/* Question 2a */
Drop Function If Exists dbo.TaxRate;
Go

Create Function dbo.TaxRate
(
@ShipCountry varchar(50)
)
Returns Float
With Schemabinding, Returns null on null Input
As
Begin
	Declare @TaxRate Numeric(4,3) = 0.0;	
	Select @TaxRate = dbo.Orders.ShipCountry
	From dbo.Orders
	Where ShipCountry = @ShipCountry
	Set @TaxRate =
			Case When @ShipCountry Between 'A%' And 'J%' Then 0.04
			When @ShipCountry Between 'K%' And 'P%' Then 0.03
			When @ShipCountry Between 'Q%' And 'Z%' Then 0.025
			Else 0.00
			End;
	Return @TaxRate			
End;
Go
/* Question 2b */
Drop Function If Exists dbo.TaxAmount
Go

Create Function dbo.TaxAmount
(
@SalesAmount numeric(4,3),
@TaxRate float
)
Returns Money
With Schemabinding, Returns null on null Input
As
Begin
		Declare @X Money = 0.00;			
		Select @X = Sum(dbo.LineItemTotal(UnitPrice, Quantity, Discount) * dbo.TaxRate(ShipCountry))
		From dbo.Orders
			Inner Join dbo.[Order Details] on Orders.OrderID = [Order Details].OrderID	
		Where @SalesAmount = dbo.LineItemTotal(UnitPrice, Quantity, Discount) And @TaxRate = dbo.TaxRate(ShipCountry)
		Return @X
End;
Go

/* Extra UDF Used */
Drop Function If Exists dbo.LineItemTotal;
Go

Create Function dbo.LineItemTotal
(
@UnitPrice Money,
@Qty Int,
@Discount Numeric(4,3)
)
Returns Money
With Schemabinding, Returns Null on Null Input
As
Begin
	Return @UnitPrice * @Qty * (1 - @Discount)
End;
Go

/* Question 2c */
/* Correct Answer Displays with this */
Select ShipCountry As 'Ship To Country',
Format(Sum(dbo.LineItemTotal(UnitPrice, Quantity, Discount)) * dbo.TaxRate(ShipCountry), 'C') As 'Tax Amount'
From Orders
	Inner Join [Order Details] on Orders.OrderID = [Order Details].OrderID
Group By ShipCountry
Order By ShipCountry

/* Could not get TaxAmount UDF to work but it does execute above,
When I add it in a Select Statement it can't find the columns for some reason */
Select ShipCountry As 'Ship To Country',
Format(dbo.TaxAmount(SalesAmount, TaxRate), 'C') As 'Tax Amount'
From Orders
	Inner Join [Order Details] on Orders.OrderID = [Order Details].OrderID
Group By ShipCountry
Order By ShipCountry