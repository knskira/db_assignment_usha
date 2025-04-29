--1.     List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
 -- companyname AS customer,orderid,productname,quantity,orderdate
 SELECT 
    c.company_name AS customers,
    o.order_id,
    p.product_name,
    od.quantity,
    o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;

--left joins
SELECT 
    o.order_id,
    c.company_name AS customers,
    e.first_name || ' ' || e.last_name AS employees,
    s.company_name AS shippers,
    p.product_name,
    od.quantity,
    o.order_date
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;

-- Righ Join
--orderid,productid,quantity, productname
 SELECT 
    od.order_id,
    p.product_id,
    od.quantity,
    p.product_name
FROM order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;
--(Outer Join)
--Tables used: categories, products
SELECT 
    c.category_name,
    p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;

--All possible product and category combinations (Cross join)
SELECT 
    c.category_name,
    p.product_name
FROM categories c
CROSS JOIN products p;

--All employees and their manager(Self join(left join))
SELECT 
    e1.first_name || ' ' || e1.last_name AS employee,
    e2.first_name || ' ' || e2.last_name AS coworker,
    e1.reports_to AS manager_id,
    m.first_name || ' ' || m.last_name AS manager
FROM employees e1
JOIN employees e2 ON e1.reports_to = e2.reports_to
LEFT JOIN employees m ON e1.reports_to = m.employee_id
WHERE e1.employee_id <> e2.employee_id;

--List all customers who have not selected a shipping method
SELECT
    c.customer_id,
    c.company_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;



