
-- Online Store Database Project

-- 1. Create Tables

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 2. Insert Sample Data

INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address)
VALUES (1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '123 Elm Street');

INSERT INTO Products (product_id, product_name, price, stock_quantity)
VALUES 
(1, 'Laptop', 999.99, 50), 
(2, 'Smartphone', 499.99, 100),
(3, 'Headphones', 89.99, 150);

INSERT INTO Orders (order_id, customer_id, order_date, status)
VALUES (1, 1, '2025-04-10', 'Delivered');

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 1, 999.99),
(2, 1, 3, 2, 89.99);

INSERT INTO Payments (payment_id, order_id, payment_date, amount, payment_method)
VALUES (1, 1, '2025-04-11', 1179.97, 'Credit Card');

-- 3. Sample Queries

-- a. Get all orders placed by a customer
SELECT o.order_id, o.order_date, p.product_name, od.quantity, od.price
FROM Orders o
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE o.customer_id = 1;

-- b. Calculate the total revenue from all orders
SELECT SUM(od.quantity * od.price) AS total_revenue
FROM OrderDetails od;

-- c. Find the most popular product (most ordered)
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;
