-- Create tables with AUTO_INCREMENT for primary keys
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    category_name TEXT NOT NULL,
    category_description TEXT
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    customer_name TEXT NOT NULL,
    email TEXT NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_name TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    customer_id INTEGER,
    order_date DATE NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id INTEGER,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert sample data (no need to specify IDs)
INSERT INTO categories (category_name, category_description) VALUES
('Electronics', 'Devices and gadgets'),
('Books', 'Printed and digital books'),
('Clothing', 'Apparel and accessories');

INSERT INTO customers (customer_name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

INSERT INTO products (product_name, price, category_id) VALUES
('Laptop', 1000.00, 1),
('Smartphone', 500.00, 1),
('T-Shirt', 20.00, 3),
('Novel', 15.00, 2);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2024-01-15', 'Paid'),
(2, '2024-01-20', 'Unpaid');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1000.00),
(1, 4, 2, 30.00),
(2, 2, 1, 500.00);

INSERT INTO payments (order_id, payment_date, amount) VALUES
(1, '2024-01-15', 1060.00);

-- Analytical queries (unchanged)
SELECT p.product_name, SUM(oi.quantity * oi.price) AS total_sales 
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id 
GROUP BY p.product_name;

SELECT c.customer_name, COUNT(o.order_id) AS num_orders 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_name;

SELECT o.order_id, SUM(p.amount) AS total_payments
FROM payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY o.order_id;

SELECT o.order_id, o.order_date, c.customer_name, o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.status = 'Unpaid';

SELECT cat.category_name, SUM(oi.quantity * oi.price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
GROUP BY cat.category_name;