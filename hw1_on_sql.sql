w/*
Имя: Aziz Sadiev
Описание: Запросы для анализа таблицы track
*/

select name, genre_id 
FROM track;

select name as song, unit_price as price, composer as author 
from track;

select name, (milliseconds / 60000.0) AS duration_minutes 
from track 
order by duration_minutes desc;

select name, genre_id 
from track 
limit 15;

select * 
from track 
offset 49;

select name 
from track 
where bytes > (100 * 1048576);

select name, composer 
from track 
where composer <> 'U2' 
limit 11 offset 9;










