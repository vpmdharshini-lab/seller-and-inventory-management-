
CREATE DATABASE SellerInventoryDB;
USE SellerInventoryDB;

CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price > 0)
);

CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL,
    Last_Updated DATE NOT NULL,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID),

    FOREIGN KEY (Seller_ID)
        REFERENCES Seller(Seller_ID),

    CHECK (Stock_Status IN ('Available', 'Out of Stock'))
);

INSERT INTO Seller
(Seller_ID, Seller_Name, Email, Phone, Address)
VALUES
(1, 'Arun Traders', 'arun@gmail.com', '9876543210', 'Chennai'),
(2, 'Kumar Stores', 'kumar@gmail.com', '9876543211', 'Madurai'),
(3, 'Sri Electronics', 'srielectronics@gmail.com', '9876543212', 'Coimbatore'),
(4, 'Ravi Enterprises', 'ravi@gmail.com', '9876543213', 'Trichy'),
(5, 'Vijay Suppliers', 'vijay@gmail.com', '9876543214', 'Salem');

INSERT INTO Product
(Product_ID, Product_Name, Price)
VALUES
(101, 'Laptop', 55000.00),
(102, 'Keyboard', 1200.00),
(103, 'Mouse', 600.00),
(104, 'Monitor', 15000.00),
(105, 'Printer', 12000.00),
(106, 'Headphones', 2000.00),
(107, 'Webcam', 2500.00),
(108, 'USB Cable', 300.00),
(109, 'Speaker', 3500.00),
(110, 'Hard Disk', 5000.00);

INSERT INTO Inventory
(Inventory_ID, Product_ID, Seller_ID, Stock_Quantity, Stock_Status, Last_Updated)
VALUES
(1, 101, 1, 25, 'Available', '2026-09-20'),
(2, 102, 1, 15, 'Available', '2026-09-20'),
(3, 103, 2, 5, 'Available', '2026-09-21'),
(4, 104, 2, 0, 'Out of Stock', '2026-09-21'),
(5, 105, 3, 12, 'Available', '2026-09-22'),
(6, 106, 3, 8, 'Available', '2026-09-22'),
(7, 107, 4, 0, 'Out of Stock', '2026-09-23'),
(8, 108, 4, 30, 'Available', '2026-09-23'),
(9, 109, 5, 7, 'Available', '2026-09-24'),
(10, 110, 5, 20, 'Available', '2026-09-24');


SELECT * FROM Seller;

SELECT
    s.Seller_Name,
    p.Product_Name
FROM Seller s
JOIN Inventory i
    ON s.Seller_ID = i.Seller_ID
JOIN Product p
    ON i.Product_ID = p.Product_ID;

SELECT
    s.Seller_ID,
    s.Seller_Name,
    COUNT(i.Product_ID) AS Product_Count
FROM Seller s
LEFT JOIN Inventory i
    ON s.Seller_ID = i.Seller_ID
GROUP BY s.Seller_ID, s.Seller_Name;

UPDATE Seller
SET Phone = '9999999999',
    Address = 'Thoothukudi'
WHERE Seller_ID = 1;


SELECT * FROM Seller
WHERE Seller_ID = 1;

SELECT
    p.Product_ID,
    p.Product_Name,
    i.Stock_Quantity
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity > 0;

SELECT
    p.Product_ID,
    p.Product_Name
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity = 0;


SELECT
    p.Product_ID,
    p.Product_Name,
    i.Stock_Quantity
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity < 10;


UPDATE Inventory
SET Stock_Quantity = 20,
    Stock_Status = 'Available',
    Last_Updated = '2026-09-25'
WHERE Inventory_ID = 3;

DELETE FROM Inventory
WHERE Inventory_ID = 7;

SELECT
    s.Seller_Name,
    p.Product_Name,
    i.Stock_Quantity,
    i.Stock_Status
FROM Seller s
JOIN Inventory i
    ON s.Seller_ID = i.Seller_ID
JOIN Product p
    ON i.Product_ID = p.Product_ID
ORDER BY s.Seller_Name;

SELECT
    p.Product_Name,
    i.Stock_Quantity,
    i.Stock_Status
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID;

SELECT
    COUNT(*) AS Total_Available_Products
FROM Inventory
WHERE Stock_Quantity > 0;

SELECT
    SUM(Stock_Quantity) AS Total_Available_Stock
FROM Inventory
WHERE Stock_Quantity > 0;

SELECT
    p.Product_Name,
    i.Stock_Quantity
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity = 0;

SELECT
    p.Product_Name,
    i.Stock_Quantity
FROM Product p
JOIN Inventory i
    ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity = (
    SELECT MAX(Stock_Quantity)
    FROM Inventory
);

SELECT
    AVG(Stock_Quantity) AS Average_Inventory_Quantity
FROM Inventory;

SELECT
    i.Inventory_ID,
    p.Product_Name,
    s.Seller_Name,
    i.Stock_Quantity,
    i.Stock_Status,
    i.Last_Updated
FROM Inventory i
JOIN Product p
    ON i.Product_ID = p.Product_ID
JOIN Seller s
    ON i.Seller_ID = s.Seller_ID;