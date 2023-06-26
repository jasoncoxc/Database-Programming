/* Question 1 */
Drop Function If Exists PartsAssembly
Go

Create Function PartsAssembly
(
@PartIdq Int
)
Returns @Hierarchy Table
(
	PartIdq Int,
	[Nameq] NVarchar(50),
	[Level] Int,
	ParentName NVarchar(50)
)
As
Begin
	Declare @Level Int = 0;

	Insert Into @Hierarchy (PartIdq, [Nameq], [Level], ParentName)
	Select PartId, [Name], @Level, PartOf
	From Part
	Where PartId = @PartIdq;

	While @@ROWCOUNT !=0
	Begin
		Set @Level += 1;

		Insert Into @Hierarchy (PartIdq, [Nameq], Level, ParentName)
		Select PartId, [Name], @Level, PartOf = [Nameq]
		From @Hierarchy H
			Inner Join Part P
				On [Level]  = @Level - 1
				And PartIdq = PartOf;
		End
Return;
End;