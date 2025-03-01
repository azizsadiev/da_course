---Задача №1: Сумма продаж по годам и месяцам для каждого клиента

WITH monthly_sales AS (
    SELECT
        i.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        TO_CHAR(i.invoice_date, 'YYYYMM') AS monthkey,
        SUM(i.total) AS total
    FROM invoices i
    JOIN customers c ON i.customer_id = c.customer_id
    GROUP BY i.customer_id, full_name, TO_CHAR(i.invoice_date, 'YYYYMM')
)
SELECT 
    customer_id,
    full_name,
    monthkey,
    total,
    (total / SUM(total) OVER (PARTITION BY monthkey)) * 100 AS percentage_of_sales,
    SUM(total) OVER (PARTITION BY customer_id ORDER BY monthkey ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
    AVG(total) OVER (PARTITION BY customer_id ORDER BY monthkey ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average,
    total - LAG(total) OVER (PARTITION BY customer_id ORDER BY monthkey) AS difference
FROM monthly_sales;


--- Задача №2: Топ 3 продаваемых альбома за каждый год

WITH yearly_album_sales AS (
    SELECT
        EXTRACT(YEAR FROM i.invoice_date) AS year,
        a.title AS album_title,
        ar.name AS artist_name,
        COUNT(i.invoice_id) AS sold_tracks
    FROM invoice_items ii
    JOIN tracks t ON ii.track_id = t.track_id
    JOIN albums a ON t.album_id = a.album_id
    JOIN artists ar ON a.artist_id = ar.artist_id
    GROUP BY year, a.title, ar.name
)
SELECT 
    year,
    album_title,
    artist_name,
    sold_tracks
FROM (
    SELECT 
        year, 
        album_title, 
        artist_name, 
        sold_tracks,
        RANK() OVER (PARTITION BY year ORDER BY sold_tracks DESC) AS rank
    FROM yearly_album_sales
) AS ranked_albums
WHERE rank <= 3;


---Задача №3: Количество клиентов, закрепленных за каждым сотрудником

WITH customer_count AS (
    SELECT 
        e.employee_id, 
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        COUNT(c.customer_id) AS customers_count
    FROM employees e
    LEFT JOIN customers c ON e.employee_id = c.support_rep_id
    GROUP BY e.employee_id, employee_name
)
SELECT 
    employee_id,
    employee_name,
    customers_count,
    (customers_count / SUM(customers_count) OVER ()) * 100 AS percentage_of_clients
FROM customer_count;

---Задача №4: Дата первой и последней покупки для каждого клиента
SELECT 
    customer_id,
    MIN(invoice_date) AS first_purchase_date,
    MAX(invoice_date) AS last_purchase_date,
    EXTRACT(YEAR FROM AGE(MAX(invoice_date), MIN(invoice_date))) AS years_difference
FROM invoices
GROUP BY customer_id;
