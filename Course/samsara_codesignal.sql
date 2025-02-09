Codesignal Question:

/*
The book_library table contains the following columns: id, author, book, pages_read, total_number_of_pages, speed. 
Your task is to write a select query to sort books in the library in a specific order, and then leave only two columns in the result: author and book. 
The book records should be sorted as follows: 
1) Order by the authors that have the max number of books in library
2) In case of ties, order by the min number of days that you need to read all the books by a prticular author
3) Then, order by the min number of days that you need to read a particular book. 
*/
USE classicmodels;
SELECT * from products;

SELECT P1.productscale,  num_books, num_days, P2.productline, each_num_days 
FROM
(SELECT productscale, COUNT(*) as num_books, SUM((msrp-buyprice)/quantityinstock) as num_days from products GROUP BY productscale) P1
RIGHT OUTER JOIN (SELECT productscale, productline, SUM((msrp-buyprice)/quantityinstock) as each_num_days from products group by productscale, productline) AS P2 ON P1.productscale = P2.productscale
ORDER BY P1.num_books DESC, P1.num_days ASC, P2.each_num_days ASC 
;

/*
SELECT P1.author, P1.num_books, P1.num_days, P2.book, each_num_days 
FROM
(SELECT author, COUNT(*) as num_books, SUM((total_number_of_pages-pages_read)/speed) as num_days from book_library GROUP BY author) P1
RIGHT OUTER JOIN (SELECT author, book, SUM((total_number_of_pages-pages_read)/speed) as each_num_days from book_library group by author, book) AS P2 ON P1.author = P2.author
ORDER BY P1.num_books DESC, P1.num_days ASC, P2.each_num_days ASC;
*/
