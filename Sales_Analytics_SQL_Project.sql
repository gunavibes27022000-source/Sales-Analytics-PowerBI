CREATE DATABASE sales_analytics_db;

USE  sales_analytics_db;


CREATE TABLE  categories (

    category_id INT PRIMARY KEY AUTO_INCREMENT ,
    category_name  VARCHAR (100) NOT NULL
);

SELECT  * FROM categories;

SHOW TABLES ;

DESCRIBE  categories;

CREATE TABLE  products
 (
    product_id  INT PRIMARY KEY  AUTO_INCREMENT,
    product_name  VARCHAR(100) NOT NULL,
    category_id INT,
    price  DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (category_id) 
         REFERENCES categories(category_id)
);

SELECT * from products;

SHOW TABLES;

DESCRIBE products;

CREATE TABLE  customers
 (
    customer_id INT PRIMARY KEY  AUTO_INCREMENT,
    customer_name  VARCHAR(100)  NOT NULL,
    gender  VARCHAR (10),
    city  VARCHAR (100),
    phone  VARCHAR (15) UNIQUE,
    email  VARCHAR(100) UNIQUE
);


SELECT * FROM customers;

SHOW TABLES;

DESCRIBE customers;



CREATE TABLE  employees  
 (
    employee_id  INT PRIMARY KEY AUTO_INCREMENT,
    employee_name   VARCHAR(100)  NOT NULL,
    department  VARCHAR(50) NOT NULL,
    city    VARCHAR(100),
    hire_date  DATE
);


SELECT * FROM  employees;

SHOW TABLES;

DESCRIBE employees;


CREATE TABLE orders 
(
    order_id  INT PRIMARY KEY AUTO_INCREMENT,
    customer_id  INT NOT NULL,
    employee_id INT  NOT NULL,
    order_date  DATE NOT NULL,
    total_amount  DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);


SHOW TABLES;

SELECT * FROM orders;

DESCRIBE orders;



CREATE TABLE order_details
 (
    order_detail_id  INT PRIMARY KEY AUTO_INCREMENT,
    order_id   INT NOT NULL,
    product_id  INT NOT NULL,
    quantity INT  NOT NULL,
    unit_price  DECIMAL(10,2)  NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);




SHOW TABLES;

SELECT * FROM order_details;

DESCRIBE order_details;


INSERT INTO categories (category_name)
VALUES
('Electronics'),         
('Clothing'),
('Furniture'),
('Grocery'),
('Sports');


SELECT * FROM categories;


INSERT INTO products
              (product_name, category_id, price, stock)
 VALUES
               ('HP Laptop',   1,  62000.00,   15),
               ('Dell Laptop', 1, 65000.00, 20),
                ('Samsung TV', 1, 45000.00,  10),
               ('Office Chair', 3, 4200.00,  18),
                 ('Rice 25kg', 4,  1200.00,   50),
                ('Nike Shoes', 5,  3500.00,   25),
               ('Men T-Shirt', 2,  799.00,    100);


SELECT * FROM  products;


INSERT INTO customers
	   (customer_name, gender, city, phone, email)
VALUES
       ('Guna',     'Male', 'Chennai',   '9876543210', 'guna123@gmail.com'),
       ('Sivakumar', 'Male', 'Coimbatore', '9876543211', 'sivakumar123@gmail.com'),
       ('Ajith',     'Male', 'Madurai', '9876543212', 'ajith123@gmail.com'),
       ('Priya',   'Female', 'Trichy', '9876543213', 'priya123@gmail.com'),
       ('Divya',  'Female', 'Salem', '9876543214', 'divya123@gmail.com');
             

SELECT * FROM customers;


INSERT INTO employees
         (employee_name, department, city, hire_date)
VALUES
         ('Ramesh',  'Sales', 'Chennai', '2023-01-15'),
         ('Karthik', 'Sales', 'Coimbatore', '2023-03-10'),
         ('Suresh',  'Marketing', 'Madurai', '2022-11-20'),
		 ('Priya',  'Support', 'Trichy', '2024-02-05'),
         ('Arun',    'Sales', 'Salem', '2023-08-18');
         

SELECT * FROM employees;     
         

INSERT INTO orders
		 (customer_id, employee_id, order_date, total_amount)
VALUES
          (1, 1, '2025-07-01', 65000.00),
          (2, 2, '2025-07-03', 1200.00),
          (3, 1, '2025-07-05', 3500.00),
          (4, 3, '2025-07-08', 799.00),
          (5, 2, '2025-07-10', 45000.00);
          
          
SELECT * FROM orders;          


INSERT INTO order_details
          (order_id, product_id, quantity, unit_price)
VALUES
            (1,  2,  1,  65000.00),
            (2,  5,  1,  1200.00),
			(3,  6,  1,  3500.00),
            (4,  7,  1,  799.00),
            (5,  3, 1,  45000.00);
                       
            
select * from order_details;            

SELECT * FROM products;

SELECT * FROM customers;



   SELECT   p.product_id ,
            p.product_name,
           c.category_name,
			p.price,
			p.stock
FROM products p
INNER JOIN categories c
ON p.category_id  = c.category_id;


SELECT * FROM products;

SELECT * FROM categories;



SELECT 
     p.product_name,
     c.category_name,
     p.price,
    p.stock
FROM  products  p
INNER JOIN  categories c
ON  p.category_id  = c.category_id
WHERE  c.category_name  = 'Electronics';



SELECT * FROM products p
INNER JOIN  categories c
ON   p.category_id = c.category_id
WHERE  c.category_name = 'Electronics'
ORDER BY  p.price  DESC;



SELECT * FROM products
ORDER BY price DESC
LIMIT 3;


SELECT DISTINCT city
FROM customers;

SELECT c.customer_name,
 COUNT(o.order_id) AS total_orders
 FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT * FROM orders;


SELECT  c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
INNER JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_name;



SELECT c.category_name,
    SUM(o.total_amount) AS total_sales
FROM categories c

INNER JOIN products p
ON c.category_id = p.category_id

INNER JOIN order_details od
ON p.product_id = od.product_id

INNER JOIN orders o
ON od.order_id = o.order_id

GROUP BY c.category_name;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM categories;



SELECT p.product_name,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM products p
INNER JOIN order_details od
ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 3;

SELECT * FROM products;
SELECT * FROM order_details;



SELECT c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;


SELECT * FROM customers;
SELECT * FROM orders;

SELECT  e.employee_name,
      SUM(o.total_amount) AS total_sales
     FROM employees e
    INNER JOIN orders o
   ON e.employee_id = o.employee_id
   GROUP BY e.employee_name
   ORDER BY total_sales DESC
   LIMIT 1;


SELECT * FROM employees;


SELECT  MONTH(order_date) AS sales_month,

    SUM(total_amount) AS total_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY sales_month;


SELECT * FROM orders;
