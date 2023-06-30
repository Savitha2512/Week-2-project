
1.SELECT CONCAT(a.first_name,' ',a.last_name) as full_name,
f.title, f.description, f.length
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id;


2.with E as
(
select payment_id,rental_id,staff_id,amount,row_number() over( order by amount asc) as rank from payment
) select * from E where rank =160;

3.select (select max(p.amount) from payment p) as max,
(select avg(p.amount) from payment p) as avg,p.payment_id,p.customer_id from payment p 
where p.customer_id=any(select c.customer_id from customer c where store_id=1);

4.select c.customer_id as "C_ID",c.first_name ||' '||c.last_name as "NAME",c.email as "MAIL" from 
customer c where c.customer_id = any (select c.customer_id from customer c 
union select p.customer_id from payment p union all select r.customer_id from rental r);
									
5.SELECT f.rating, sum(p.amount) AS sum
from film f
join inventory i ON f.film_id = i.film_id
join rental r ON i.inventory_id = r.inventory_id
join payment p ON r.rental_id = p.rental_id
group by f.rating
having sum(p.amount) <> 10000 and sum(p.amount)<12000
order by sum ASC;


6.SELECT a.actor_id, CONCAT(a.first_name,' ',a.last_name) as actor_name,
COUNT(*) movie_count
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
GROUP BY 1,2
ORDER BY COUNT(*)DESC;


7.select city_id,last_update, city,rank()over(partition by last_update order by country_id asc) 
from city group by city_id having city like 'B%'

8.SELECT P.AMOUNT AS "Product PRICE", 
       P.RENTAL_ID,
       R.RENTAL_DATE
   FROM PAYMENT P, RENTAL R
   WHERE P.RENTAL_ID=R.RENTAL_ID
   AND R.INVENTORY_ID=(SELECT MAX(I.INVENTORY_ID) FROM INVENTORY I WHERE I.FILM_ID =(SELECT F.FILM_ID FROM FILM F WHERE F.TITLE='Academy Dinosaur') );

9.SELECT CITY_ID, CITY,COUNTRY_ID 
FROM CITY 
WHERE CITY_ID IN(SELECT CITY_ID FROM ADDRESS WHERE ADDRESS_ID<5)
ORDER BY COUNTRY_ID ASC

10.SELECT f.film_id, f.title
from film f
join inventory i ON f.film_id = i.film_id
join rental r ON i.inventory_id = r.inventory_id
join payment p ON r.rental_id = p.rental_id
group by f.film_id having count(16)<>length(title);


11.select c.city_id,c.city,c.country_id,a.district,a.postal_code 
from city 
c right outer join address a on c.city_id=a.city_id 
where city like 'C%' and 
country_id=any(select distinct c.country_id from city c);
	
	
12. SELECT f.rating, count(p.amount) AS total_revenue
from film f
join inventory i ON f.film_id = i.film_id
join rental r ON i.inventory_id = r.inventory_id
join payment p ON r.rental_id = p.rental_id
group by f.rating
having count(p.amount) > 1000 
order by total_revenue DESC;
