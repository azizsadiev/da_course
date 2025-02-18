select 
    min(invoice_date) as first_purchase, 
    max(invoice_date) as last_purchase
from invoice;

select avg(total) AS avg_check
from invoice
where billing_country = 'USA';

select billing_city, count(*) as client_count
from customer
group by billing_city
having count(*) > 1;

select phone
from customer
where phone not like '%(%' and phone not like '%)%';

select initcap('lorem ipsum') as formatted_text;

select name
from track
where name ILIKE '%run%';

select *
from customer
where email ilike '%@gmail.com';

select name, LENGTH(name) as name_length
from track
order by name_length desc
limit 1;

select 
    extract(month from invoice_date) as month_id, 
    sum(total) as sales_sum
from invoice
where extract(year from invoice_date) = 2021
group by month_id
order by month_id;


select 
    extract(month from invoice_date) as month_id, 
    to_char(invoice_date, 'Month') as month_name, 
    SUM(total) as sales_sum
from invoice
where extract(year from invoice_date) = 2021
group by month_id, month_name
group by month_id;

select 
    first_name || ' ' || last_name as full_name, 
    birth_date, 
    date_part('year', age(birth_date)) as age_now
from employee
order by age_now desc
limit 3;

select
    avg(date_part('year', age(birth_date)) + 3 + (4/12)) as avg_age_future
from employee;

select
    extract (year from invoice_date) as year, 
    billing_country, 
    sum(total) as sales_sum
from invoice
group by year, billing_country
having sum(total) > 20
order by year asc, sales_sum desc;












