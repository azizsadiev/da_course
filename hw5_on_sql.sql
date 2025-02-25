-- Задача 1: Количество клиентов, закреплённых за каждым сотрудником
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    COUNT(c.customer_id) AS customer_count,
    ROUND((COUNT(c.customer_id) * 100.0) / (SELECT COUNT(*) FROM customer), 2) AS percentage_of_total_clients
FROM employee e
LEFT JOIN customer c ON e.employee_id = c.support_rep_id
GROUP BY e.employee_id;

-- Задача 2: Альбомы, треки из которых не продавались
SELECT 
    a.title AS album_name, 
    ar.name AS artist_name
FROM album a
JOIN artist ar ON a.artist_id = ar.artist_id
WHERE NOT EXISTS (
    SELECT 1
    FROM track t
    JOIN invoice_items ii ON t.track_id = ii.track_id
    WHERE t.album_id = a.album_id
);

-- Задача 3: Сотрудники без подчинённых
SELECT 
    e.employee_id, 
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employee e
LEFT JOIN employee m ON e.employee_id = m.manager_id
WHERE m.employee_id IS NULL;


-- Задача 4: Треки, продавшиеся и в США, и в Канаде
SELECT 
    t.track_id, 
    t.name AS track_name
FROM track t
JOIN invoice_items ii ON t.track_id = ii.track_id
JOIN invoices i ON ii.invoice_id = i.invoice_id
WHERE i.billing_country = 'USA'
AND t.track_id IN (
    SELECT t.track_id
    FROM track t
    JOIN invoice_items ii ON t.track_id = ii.track_id
    JOIN invoices i ON ii.invoice_id = i.invoice_id
    WHERE i.billing_country = 'Canada'
);

-- Задача 5: Треки, которые продавались в Канаде, но не продавались в США
SELECT 
    t.track_id, 
    t.name AS track_name
FROM track t
JOIN invoice_items ii ON t.track_id = ii.track_id
JOIN invoices i ON ii.invoice_id = i.invoice_id
WHERE i.billing_country = 'Canada'
AND t.track_id NOT IN (
    SELECT t.track_id
    FROM track t
    JOIN invoice_items ii ON t.track_id = ii.track_id
    JOIN invoices i ON ii.invoice_id = i.invoice_id
    WHERE i.billing_country = 'USA'
);

