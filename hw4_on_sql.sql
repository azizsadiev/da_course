SELECT table_schema, table_name
FROM information_schema.tables;

SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%emp%';

SELECT 
    e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name, 
    e.job_title AS title, 
    e.manager_id AS reports_to, 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_full_name, 
    m.job_title AS manager_title
FROM public.имя_найденной_таблицы e
LEFT JOIN public.имя_найденной_таблицы m ON e.manager_id = m.employee_id;

SELECT table_name
FROM information_schema.tables
WHERE table_name LIKE '%person%'
   OR table_name LIKE '%user%'
   OR table_name LIKE '%worker%';

SELECT * FROM public.customers LIMIT 10;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'название_таблицы';

SELECT 
    e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name, 
    e.job_title AS title, 
    e.manager_id AS reports_to, 
    CONCAT(m.first_name, ' ', m.last_name) AS manager_full_name, 
    m.job_title AS manager_title
FROM users e
LEFT JOIN users m ON e.manager_id = m.employee_id;

SELECT 
    invoice_id, 
    invoice_date, 
    TO_CHAR(invoice_date, 'YYYYMM') AS monthkey, 
    i.customer_id, 
    total, 
    c.email
FROM invoices i
JOIN customers c ON i.customer_id = c.customer_id
WHERE total > (SELECT AVG(total) FROM invoices 
WHERE EXTRACT(YEAR FROM invoice_date) = 2023)
AND c.email NOT LIKE '%@gmail.com';

WITH total_revenue_2024 AS (
    SELECT SUM(total) AS total_revenue
    FROM invoices
    WHERE EXTRACT(YEAR FROM invoice_date) = 2024
)
SELECT 
    invoice_id, 
    (total / total_revenue_2024.total_revenue) * 100 AS revenue_percentage
FROM invoices, total_revenue_2024
WHERE EXTRACT(YEAR FROM invoice_date) = 2024;

WITH total_revenue_2024 AS (
    SELECT SUM(total) AS total_revenue
    FROM invoices
    WHERE EXTRACT(YEAR FROM invoice_date) = 2024
)
SELECT 
    customer_id, 
    (SUM(total) / total_revenue_2024.total_revenue) * 100 AS customer_revenue_percentage
FROM invoices, total_revenue_2024
WHERE EXTRACT(YEAR FROM invoice_date) = 2024
GROUP BY customer_id;
