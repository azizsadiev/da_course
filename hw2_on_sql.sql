
Aziz Sadiev
Домашка #2 по SQL
*/


SELECT MIN(invoice_date) AS first_purchase, MAX(invoice_date) AS last_purchase FROM invoice;

SELECT AVG(total) AS avg_check FROM invoice WHERE billing_country = 'USA';

SELECT city, COUNT(*) AS client_count FROM customer GROUP BY city HAVING COUNT(*) > 1;

SELECT phone FROM customer WHERE phone NOT LIKE '%(%';

SELECT INITCAP('lorem ipsum') AS formatted_text;

SELECT name FROM track WHERE name ILIKE '%run%';

SELECT * FROM customer WHERE email ILIKE '%@gmail.com';

SELECT name FROM track ORDER BY LENGTH(name) DESC LIMIT 1;

SELECT EXTRACT(MONTH FROM invoice_date) AS month_id, SUM(total) AS sales_sum
FROM invoice WHERE EXTRACT(YEAR FROM invoice_date) = 2021 GROUP BY month_id ORDER BY month_id;

SELECT EXTRACT(MONTH FROM invoice_date) AS month_id, TO_CHAR(invoice_date, 'Month') AS month_name, SUM(total) AS sales_sum
FROM invoice WHERE EXTRACT(YEAR FROM invoice_date) = 2021 GROUP BY month_id, month_name ORDER BY month_id;

SELECT CONCAT(first_name, ' ', last_name) AS full_name, birth_date, 
    DATE_PART('year', AGE(birth_date)) AS age_now
FROM employee ORDER BY birth_date ASC LIMIT 3;

SELECT AVG(DATE_PART('year', AGE(birth_date)) + 3 + 4/12) AS avg_age_in_future FROM employee;

SELECT EXTRACT(YEAR FROM invoice_date) AS year, billing_country, SUM(total) AS sales_sum
FROM invoice GROUP BY year, billing_country HAVING SUM(total) > 20 ORDER BY year ASC, sales_sum DESC;
git add hw2_on_sql.sql
git commit -m "Добавлены SQL-запросы для домашки #2"
git push origin hw27