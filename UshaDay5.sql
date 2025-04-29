--GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost > 100

SELECT 
	EXTRACT (year from order_date) AS order_year,
	EXTRACT (quarter from order_date) AS order_quarter,
	count(order_id) AS order_count,
	round(avg(freight)::numeric,2) AS average_freight_cost
FROM
	orders
WHERE
	freight > 100
group by 
	extract (year from order_date),
	extract (quarter from order_date);

-- Group by with HAVING on high-volume ship regions.
-- Display the ship region, number of orders in each region, and the minimum and maximum freight costs.
-- Filter to show only regions where the number of orders is greater than or equal to 5!
SELECT
	SHIP_REGION,
	COUNT(*) AS ORDER_COUNT,
	MIN(FREIGHT) AS MIN_FREIGHT,
	MAX(FREIGHT) AS MAX_FREIGHT
FROM
	ORDERS
WHERE
	SHIP_REGION IS NOT NULL
GROUP BY
	SHIP_REGION
HAVING
	COUNT(*) >= 5
ORDER BY
	ORDER_COUNT DESC;

--Get all title designations across employees and customers.
-- Try using UNION and UNION ALL!
SELECT
	TITLE
FROM
	EMPLOYEES
UNION
SELECT
	CONTACT_TITLE
FROM
	CUSTOMERS
ORDER BY
	TITLE;

-- Find categories that have both discontinued and in-stock products.
-- Display the category ID (in-stock means units in stock > 0) using INTERSECT.

SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	DISCONTINUED = 1
INTERSECT

SELECT
	CATEGORY_ID
FROM
	PRODUCTS
WHERE
	UNITS_IN_STOCK > 0
ORDER BY
	CATEGORY_ID;
	
-- 5. Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT 
	order_id
FROM
	order_details

	EXCEPT 

SELECT
	order_id
FROM 
	order_details
WHERE
		discount > 0;

