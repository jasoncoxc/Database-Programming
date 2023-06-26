/* Question 1 */
SELECT
CASE [contract]
WHEN '1' THEN 'Contracted'
WHEN '0' THEN 'No Contract'
ELSE 'Unknown Status'
END "Contract Status",
au_lname AS 'Last Name',
au_fname AS 'First Name'
FROM authors
ORDER BY [Contract Status], 'Last Name'

/* Question 2 */
SELECT title AS 'Book Title',
FORMAT (pubdate, 'MM-dd-yyyy') AS 'Publication Date'
FROM titles
WHERE pubdate >= '01-01-2000'

/* Question 3 */
SELECT title AS 'Book Title',
FORMAT (pubdate, 'MM-dd-yyyy') AS 'Publication Date'
FROM titles
WHERE pubdate BETWEEN '07-01-1991' AND '12-31-1991'
ORDER BY 'Book Title'

/* Question 4 */
SELECT au_lname AS 'Last Name', au_fname AS 'First Name'
FROM authors
WHERE au_lname LIKE '%y'
ORDER BY 'Last Name'

/* Question 5 */
SELECT au_lname AS 'Last Name', au_fname AS 'First Name', [state] AS 'State'
FROM authors
WHERE [state] IN ('OR', 'MI', 'MD')
ORDER BY 'Last Name'