CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no') DEFAULT 'yes',
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Library St, City A', '123-456-7890'),
(2, 102, '456 Book Ave, City B', '234-567-8901'),
(3, 103, '789 Reading Rd, City C', '345-678-9012');
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(201, 'Alice Johnson', 'Librarian', 55000.00, 1),
(202, 'Bob Smith', 'Assistant', 40000.00, 1),
(203, 'Charlie Davis', 'Manager', 70000.00, 2),
(204, 'Diana Prince', 'Librarian', 58000.00, 2),
(205, 'Ethan Hunt', 'Assistant', 42000.00, 3),
(206, 'Fiona Gallagher', 'Librarian', 56000.00, 3),
(207, 'George Michael', 'Assistant', 41000.00, 1),
(208, 'Hannah Baker', 'Librarian', 59000.00, 2);
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('ISBN001', 'Introduction to Algorithms', 'Education', 30.00, 'yes', 'Thomas H. Cormen', 'MIT Press'),
('ISBN002', 'The Great Gatsby', 'Fiction', 15.00, 'no', 'F. Scott Fitzgerald', 'Scribner'),
('ISBN003', 'Clean Code', 'Technology', 25.00, 'yes', 'Robert C. Martin', 'Prentice Hall'),
('ISBN004', 'To Kill a Mockingbird', 'Fiction', 20.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('ISBN005', 'The Art of Computer Programming', 'Education', 45.00, 'no', 'Donald E. Knuth', 'Addison-Wesley'),
('ISBN006', '1984', 'Fiction', 18.00, 'yes', 'George Orwell', 'Secker & Warburg'),
('ISBN007', 'Effective Java', 'Technology', 28.00, 'yes', 'Joshua Bloch', 'Addison-Wesley'),
('ISBN008', 'The Catcher in the Rye', 'Fiction', 17.00, 'no', 'J.D. Salinger', 'Little, Brown and Company');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(301, 'John Doe', '789 Elm St, City A', '2021-05-10'),
(302, 'Jane Smith', '321 Oak St, City B', '2020-08-15'),
(303, 'Emily Davis', '654 Pine St, City C', '2022-01-20'),
(304, 'Michael Brown', '987 Maple St, City A', '2021-12-05'),
(305, 'Sarah Wilson', '135 Birch St, City B', '2019-03-22'),
(306, 'David Lee', '246 Cedar St, City C', '2023-07-30'),
(307, 'Laura Clark', '369 Walnut St, City A', '2020-11-11'),
(308, 'Kevin Lewis', '159 Spruce St, City B', '2021-09-25');
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(401, 301, 'Introduction to Algorithms', '2023-06-01', 'ISBN001'),
(402, 302, 'Clean Code', '2023-06-05', 'ISBN003'),
(403, 303, '1984', '2023-06-10', 'ISBN006'),
(404, 304, 'Effective Java', '2023-07-15', 'ISBN007'),
(405, 305, 'To Kill a Mockingbird', '2023-08-20', 'ISBN004');
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(501, 301, 'Introduction to Algorithms', '2023-06-15', 'ISBN001'),
(502, 302, 'Clean Code', '2023-06-20', 'ISBN003'),
(503, 303, '1984', '2023-06-25', 'ISBN006'),
(504, 304, 'Effective Java', '2023-07-25', 'ISBN007');

SHOW TABLES;

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT b.Book_title, c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT c.Customer_name
FROM Customer c
LEFT JOIN IssueStatus iss ON c.Customer_Id = iss.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND iss.Issue_Id IS NULL;

SELECT Branch_no, COUNT(*) AS TotalEmployees
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE MONTH(iss.Issue_date) = 6 AND YEAR(iss.Issue_date) = 2023;

SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;























