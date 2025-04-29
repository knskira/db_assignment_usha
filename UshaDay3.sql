--1)      Update the categoryName From “Beverages” to "Drinks" in the categories table
UPDATE categories
SET category_name = 'Drinks'
WHERE category_name = 'Beverages';
SELECT * FROM categories WHERE category_name = 'Drinks';

SELECT * FROM categories

--Insert into shipper new record (give any values)


 INSERT INTO shippers (shipper_id, company_name, phone)
VALUES (7, 'American express', '(945) 123-4567');
SELECT * FROM shippers;

--Delete that new record from shippers table.
DELETE FROM shippers
WHERE shipper_id = 2;
SELECT * FROM shippers;

DELETE FROM shippers
WHERE shipper_id = 7;
SELECT * FROM shippers;

ALTER TABLE products
DROP CONSTRAINT fk_products_category;

UPDATE categories
SET category_id = 1001
WHERE category_id = 1;

select * from products;

UPDATE products set category_id=1001
where category_id=1;

SELECT * FROM categories WHERE category_id= 1001;
SELECT * FROM categories









DELETE FROM products
WHERE category_id = 1;

select product_id from products where category_id=1;

select * from order_details where product_id 
in(select product_id from products where category_id=1);


ALTER TABLE products
DROP CONSTRAINT fk_products_categories;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories(category_id)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (order_id)
REFERENCES categories(category_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

delete from categories where category_id=3;

select * from categories where category_id=;


ALTER TABLE orders
DROP CONSTRAINT fk_orders_customers;


ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE SET NULL;

delete from customers where customer_id='VINET';

select * from customers where customer_id='VINET';

select * from orders where customer_id IS NULL;

select * from products where category_id=3;

select * from categories;

insert into categories (3, 'Wheat Bread', 'bread description', null);

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', '1', 13, 0, 3)
ON CONFLICT (product_id)
DO UPDATE SET
    product_name = EXCLUDED.product_name,
    quantity_per_unit = EXCLUDED.quantity_per_unit,
    unit_price = EXCLUDED.unit_price,
    discontinued = EXCLUDED.discontinued,
    category_id = EXCLUDED.category_id; 
	
INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES
  (100, 'Wheat bread', '1', 13, 0, 5),
  (101, 'White bread', '5 boxes', 13, 0, 5)
ON CONFLICT (product_id) DO UPDATE
SET quantity_per_unit = EXCLUDED.quantity_per_unit; 
SELECT * FROM products WHERE product_id IN (100,101);

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
VALUES (100, 'Wheat bread', '10 boxes', 13, 0, 5)
ON CONFLICT (product_id) DO UPDATE
SET quantity_per_unit = EXCLUDED.quantity_per_unit; 

SELECT * FROM products WHERE product_id IN (100,101);

--6 MERGE QUERY
CREATE TEMPORARY TABLE updated_products (
  productID INT,
  productName VARCHAR(255),
  quantityPerUnit VARCHAR(100),
  unitPrice DECIMAL(10, 2),
  discontinued INT,
  categoryID INT
);
INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES
  (100, 'Wheat bread', '10', 20, 1, 5),
  (101, 'White bread', '5 boxes', 19.99, 0, 5),
  (102, 'Midnight mango fizz', '24 - 12 oz bottles', 19, 0, 1),
  (103, 'Savory fire sauce', '12 - 550 ml bottles', 10, 0, 2);

SELECT * FROM updated_products; 
--update products 
UPDATE products
SET unit_price = u.unitPrice,
    discontinued = u.discontinued
FROM updated_products AS u
WHERE products.product_id = u.productID
  AND u.discontinued = 0;

SELECT * FROM products; 

DELETE FROM products
WHERE product_id IN (SELECT productID FROM updated_products WHERE discontinued = 1);
SELECT * FROM products; 

INSERT INTO products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
SELECT
    u.productID,
    u.productName,
    u.quantityPerUnit,
    u.unitPrice,
    u.discontinued,
    u.categoryID
FROM updated_products AS u
WHERE NOT EXISTS (SELECT 1 FROM products p WHERE u.productID = p.product_id)
  AND u.discontinued = 0
  AND u.categoryID IN (SELECT category_id FROM categories);

SELECT * FROM products WHERE product_id IN (100, 101, 102);

--List all orders with employee full names. (Inner join)
--joinning of employees and orders 
SELECT
    orders.order_id,    
    employees.employee_id,
    employees.first_name || ' ' || employees.last_name AS employee_full_name,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    orders.ship_via,
    orders.freight
FROM orders
INNER JOIN employees
    ON orders.employee_id = employees.employee_id;
