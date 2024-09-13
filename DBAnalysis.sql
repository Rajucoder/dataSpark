CREATE DATABASE capstone_spark;
SELECT @@SERVERNAME;

use capstone_spark;

SHOW COLUMNS FROM customers;

-- What is frequency of customer based on Gender?
select gender, count(*) AS Count_gender From customers group by gender;

-- What will the age group of the customers purchasing the products?
SELECT
    age_bucket,
    COUNT(*) AS count
FROM (
    SELECT
        *,
        CASE
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) <= 18 THEN '<=18'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 18 AND 25 THEN '18-25'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 25 AND 35 THEN '25-35'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 35 AND 45 THEN '35-45'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 45 AND 55 THEN '45-55'
            WHEN YEAR(STR_TO_DATE(Order_date, '%Y-%m-%d')) - YEAR(STR_TO_DATE(birthday, '%Y-%m-%d')) BETWEEN 55 AND 65 THEN '55-65'
            ELSE '>65'
        END AS age_bucket
    FROM overall
) AS age_groups
GROUP BY age_bucket;

-- Which demographics location having higher customers?
select continent, country, state, city, count(CustomerKey) AS customer_count
	From Customers 
    Group by continent, country, state, city
    Order by customer_count;