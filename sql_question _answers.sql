CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

CREATE TABLE Books (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    Published_Year INT,
    Price DECIMAL(10, 2),
    Stock INT
);
CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);
CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);

SELECT * FROM BOOKS;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

-- BUSINESS PROBLEM QUESTION

-- 1) Retrieve all books in the "Fiction" genre
SELECT 
    *
FROM
    books
WHERE
    Genre = 'Fiction';

-- 2) Find books published after the year 1950
SELECT 
    *
FROM
    books
WHERE
    Published_Year = "01-01-1950";

-- 3) List all customers from the Canada
SELECT 
    *
FROM
    customers
WHERE
    Country = 'canada';

-- 4) Show orders placed in November 2023
SELECT 
    *
FROM
    orders
WHERE
    Order_Date = '2023-11-01';

-- 5) Retrieve the total stock of books available
SELECT 
    SUM(stock)
FROM
    books; 

-- 6) Find the details of the most expensive book
SELECT 
    Title, MAX(price)
FROM
    books
GROUP BY title
ORDER BY title DESC
LIMIT 5;

-- 7) Show all customers who ordered more than 5 quantity of a book
SELECT customer_id, book_id,SUM(quantity) as total_quantity
FROM orders
GROUP BY customer_id, book_id
HAVING SUM(quantity) > 5;

-- 8) Retrieve all orders where the total amount exceeds 100
SELECT 
    *
FROM
    orders
WHERE
    Total_Amount > 100;

-- 9) List all genres available in the Books table
SELECT DISTINCT
    genre
FROM
    Books;
 

-- 10) Find the book with the lowest stock
SELECT 
    *
FROM
    books
ORDER BY Stock ASC;

-- 11) Calculate the total revenue generated from all orders
SELECT 
    SUM(Total_Amount)
FROM
    orders;

-- ADVANCE

-- 1) Retrieve the total number of books sold for each genre
SELECT 
    Genre, Quantity
FROM
    books
        JOIN
    orders ON books.book_id = orders.book_id;

-- 2) Find the average price of books in the "Fantasy" gene
SELECT 
    Genre, AVG(price)
FROM
    books
WHERE
    Genre = 'Fantasy'
GROUP BY Genre;

-- 3) List customers who have placed at least 2 orders
SELECT customer_id,max(Quantity)
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2;


-- 4) Find the most frequently ordered book

SELECT book_id, COUNT(*) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
SELECT 
    book_id, MAX(price)
FROM
    books
WHERE
    genre = 'Fantasy'
GROUP BY book_id
ORDER BY book_id
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author

SELECT books.author, SUM(orders.quantity) AS total_books_sold
FROM books
JOIN orders ON books.book_id = orders.book_id
GROUP BY books.author;

-- 7) List the cities where customers who spent over $30 are loc

SELECT customers.city
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.city
HAVING SUM(orders.total_amount) > 30;

-- 8) Find the customer who spent the most on orders

SELECT customers.customer_id, customers.name, SUM(orders.total_amount) AS total_spent
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id
ORDER BY total_spent DESC
LIMIT 1;


