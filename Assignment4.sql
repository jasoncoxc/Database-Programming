/* Question 1 */
SELECT 'Current Date: ' + CONVERT(VARCHAR(20),GETDATE(), 112) AS 'Date'

/* Question 2 */
SELECT CONVERT(VARCHAR(20),YEAR(GETDATE()), 101) AS 'Year'

/* Question 3 */
SELECT SUBSTRING(CONVERT(VARCHAR(20),REVERSE(GETDATE())), 1,
(CHARINDEX(' ', CONVERT(VARCHAR(20),REVERSE(GETDATE()), 1)) - 1))
+
' '
+
SUBSTRING(CONVERT(VARCHAR(20),(GETDATE()), 111), 1,
(CHARINDEX('/', CONVERT(VARCHAR(20),(GETDATE()), 111)) - 1))
+
' '
+
SUBSTRING(CONVERT(VARCHAR(20),(GETDATE()), 0), 1,
(CHARINDEX(' ', CONVERT(VARCHAR(20),(GETDATE()), 0)) - 1))
+
' '
+
SUBSTRING(CONVERT(VARCHAR(20),(GETDATE()), 3), 1,
(CHARINDEX('/', CONVERT(VARCHAR(20),(GETDATE()), 3)) - 1)) AS 'Unusual Date Format'

/* Question 4 */
SELECT firstname +' '+ lastname + '"s new salary is: '+ format((salary*.15) + salary,'C') AS 'New Salary'
FROM Emp
WHERE Salary IS NOT NULL
UNION
SELECT firstname +' '+ lastname + '''s new salary is: Unable to calculate new salary' AS 'New Salary'
FROM Emp
WHERE Salary IS NULL 