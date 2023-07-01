ANALYSIS OF DVD RENTAL DATABASE


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/ec7cfa15-4538-4e87-8c43-20c823f56a1f)



INTRODUCTION
A DVD rental database is a structured collection of information that stores data related to DVD rentals. It is designed to efficiently manage and organize various aspects of a DVD rental business, such as inventory management, customer information, rental transactions, and more. This type of database enables rental businesses to streamline their operations, track rentals and returns, and provide better customer service.
The DVD rental database typically consists of multiple interconnected tables that hold different types of data. Here are some key components commonly found in a DVD rental database:
Movies Table: This table contains information about the movies available for rental, including their titles, release dates, genres, and other relevant details. Each movie is assigned a unique identifier, which serves as a primary key.
Customers Table: This table stores customer information, such as names, addresses, contact details, and membership status. Each customer is assigned a unique identifier as a primary key, which helps in identifying and tracking individual customer activity.
Rentals Table: This table records the rental transactions, including the customer renting a specific movie, the rental start and return dates, and any associated fees. It typically includes foreign keys that reference the customer and movie tables to establish relationships.
Returns Table: This table tracks the return transactions, including the rental ID, return date, and any applicable late fees. It helps to manage the inventory and calculate charges accurately.
Inventory Table: This table maintains the inventory of available DVDs, linking each movie to the number of copies in stock. It helps in tracking the availability of movies for rental and managing stock levels.
Payments Table: This table stores payment information related to DVD rentals, including payment method, amount, and transaction details. It helps in managing billing and financial aspects of the rental business.
The DVD rental database allows rental businesses to perform various operations, such as adding new movies to the inventory, registering new customers, recording rentals and returns, generating reports on customer activity, and handling payment transactions.
By leveraging a well-designed DVD rental database, businesses can enhance their efficiency, improve customer service, and gain valuable insights into rental trends and preferences. The database serves as a central hub of information, facilitating better decision-making and ensuring smoother operations in the DVD rental industry.

DVD RENTAL DATABASE AND THEIR CONNECTIONS
select * from inventory--film_id, store_id,inventory_id
select * from payment--payment_id,customer_id, staff_id,rental_id
select * from film--film_id
select * from film_actor--actor_id,film_id
select * from film_category--film_id,category_id,
select * from rental--rental_id,inventory_id,customer_id,staff_id
select * from customer--customer_id,store_id,address_id
select * from address--address_id,city_id
select * from city--city_id,country_id
select * from staff--staff_id,address_id,store_id
select * from store--store_id,manager_staff_id
select * from country --country_id;

ERD DATABASE


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/1113a36e-8152-4e90-9da0-18fb703942a3)

 
CODE
1. SELECT CONCAT(a.first_name,' ',a.last_name) as full_name,
f.title, f.description, f.length
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id;


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/d3187489-b20b-4813-bb05-ba2501032a0b)


 
•	In this query, we select the concatenated full name of actors using the CONCAT function, combining the first_name and last_name columns from the actor table.
•	We then join the actor table with the film_actor table on the actor_id column and join the resulting set with the film table on the film_id column. 
•	This allows us to retrieve the desired information, including the film title, description, and length.

2. with E as
(
select payment_id,rental_id,staff_id,amount,row_number() over( order by amount asc) as rank from payment
) select * from E where rank =160;


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/d30ab512-f466-404f-85de-9afc847abb73)

 
•	The query retrieves the payment details from the "payment" table and assigns a rank to each payment based on the ascending order of the payment amount. 
•	It then selects the row where the rank is equal to 160.


3. select (select max(p.amount) from payment p) as max,
(select avg(p.amount) from payment p) as avg , 
p.payment_id,p.customer_id from payment p 
where p.customer_id=any(select c.customer_id from customer c where store_id=1);


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/96e3e771-e373-4c61-ab07-9bce3dca2695)

 
•	In this query, we have a main query that retrieves the maximum payment amount (max) from the payment table and the average payment amount (avg) from the same table. 
•	Additionally, it selects the payment_id and customer_id columns from the payment table.
•	The WHERE clause filters the results to include only those rows where the customer_id matches any of the customer_id values returned by the subquery.
•	The subquery retrieves customer_id values from the customer table where the store_id is 1.



4. select c.customer_id as "C_ID",c.first_name ||' '||c.last_name as "NAME",c.email as "MAIL" 
from customer c where c.customer_id =any 
(select c.customer_id from customer c union select p.customer_id from payment p union all select r.customer_id from rental r);


 ![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/0d3ce6be-7a44-4f45-b30f-f68bf48724d6)

	
•	In this query, we select the customer_id column as "C_ID", concatenate the first_name and last_name columns with a space in between as "NAME", and select the email column as "MAIL" from the customer table.
•	The WHERE clause filters the results to include only those rows where the customer_id matches any of the customer_id values returned by the combined subquery. 
•	The subquery combines the customer_id values from the customer, payment, and rental tables using UNION and UNION ALL to ensure distinct values are returned.		
5. SELECT f.rating, sum(p.amount) AS sum
from film f
join inventory i ON f.film_id = i.film_id
join rental r ON i.inventory_id = r.inventory_id
join payment p ON r.rental_id = p.rental_id
group by f.rating
having sum(p.amount) <> 10000 and sum(p.amount)<12000
order by sum ASC;

 
![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/2ccc42e8-f9eb-4bb3-af67-b599fc86a179)


•	The provided SQL query retrieves the film rating (f.rating) and the sum of payment amounts (sum(p.amount)) as "sum". It joins the film, inventory, rental, and payment tables based on their respective relationships. It then groups the results by film rating (f.rating) and applies the following conditions:
•	Excludes rows where the sum of payment amounts is equal to 10,000 (sum(p.amount) <> 10000).
•	Excludes rows where the sum of payment amounts is greater than or equal to 12,000 (sum(p.amount) < 12000).
•	This query will return the film rating and the sum of payment amounts for each rating, excluding rows with a sum of 10,000 and filtering out rows with sums greater than or equal to 12,000. The results will be sorted in ascending order based on the "avg" column.


6. SELECT a.actor_id, CONCAT(a.first_name,' ',a.last_name) as actor_name,
COUNT(*) movie_count
FROM actor a
JOIN film_actor fa ON a.actor_id=fa.actor_id
JOIN film f ON f.film_id=fa.film_id
GROUP BY 1,2
ORDER BY COUNT(*)DESC;


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/7ae7b095-4148-4b49-8be7-8399c1d0c659)


 
•	The provided SQL query retrieves the actor ID (a.actor_id), the concatenation of the actor's first name and last name (CONCAT(a.first_name,' ',a.last_name)), and the count of movies in which each actor appears (COUNT(*) AS movie_count). 
•	It joins the actor, film_actor, and film tables based on their respective relationships. It then groups the results by actor ID and actor name, and finally, it orders the results in descending order based on the count of movies.
•	This query will return the actor ID, actor name (concatenation of first name and last name), and the count of movies in which each actor appears. The results will be grouped by actor ID and name and sorted in descending order based on the movie count.

7.  select city_id,last_update, city,rank()
   over(partition by last_update order by country_id asc) 
   from city group by city_id 
   having city like 'B%'


 ![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/9a3da7b1-abb6-4a08-934b-fa879b096347)



•	In this query, we select the city_id, last_update, and city columns from the city table. We then use the RANK() function with the OVER clause to calculate the rank of each city within its respective last_update partition, ordered by country_id in ascending order.
•	The results are grouped by city_id, as specified in the GROUP BY clause. The HAVING clause filters the results to include only those rows where the city column starts with 'B'.
•	Please note that the RANK() function requires an ORDER BY clause to determine the ranking order. In this query, I have used country_id for ordering, but you can modify it according to your specific requirements.

8. SELECT P.AMOUNT AS "Product PRICE", P.RENTAL_ID, R.RENTAL_DATE   
FROM PAYMENT P, RENTAL R  
WHERE P.RENTAL_ID=R.RENTAL_ID 
AND R.INVENTORY_ID=(SELECT MAX(I.INVENTORY_ID) FROM INVENTORY I WHERE I.FILM_ID =
(SELECT F.FILM_ID FROM FILM F WHERE F.TITLE='Academy Dinosaur') );


![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/9fe9422d-29fa-43bd-a11c-3b52adcb759d)


 
•	This query will return the amount, rental ID, and rental date for payments that are associated with the rental of the film titled 'Academy Dinosaur'.
•	It achieves this by comparing the INVENTORY_ID of the RENTAL table with the maximum INVENTORY_ID value obtained from the subquery, which retrieves the FILM_ID of the film with the title 'Academy Dinosaur' from the FILM table.

9. SELECT CITY_ID, CITY FROM CITY WHERE CITY_ID IN(SELECT CITY_ID FROM ADDRESS WHERE ADDRESS_ID<5)ORDER BY COUNTRY_ID ASC

    ![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/9194af39-b83e-4b54-987a-fedc24525296)

 
•	In this query, we select the CITY_ID and CITY columns from the CITY table. The WHERE clause filters the results to include only those rows where the CITY_ID is present in the subquery result. The subquery retrieves CITY_ID values from the ADDRESS table where the ADDRESS_ID is less than 5.
•	Finally, the results are sorted in ascending order based on the COUNTRY_ID column.
•	Note that the subquery in the WHERE clause helps to filter the cities based on certain conditions related to the ADDRESS table.

10. SELECT f.film_id, f.title
from film f
join inventory i ON f.film_id = i.film_id
join rental r ON i.inventory_id = r.inventory_id
join payment p ON r.rental_id = p.rental_id
group by f.film_id having count(16)<>length(title);


 ![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/729a384d-4148-4a7a-83fc-5fd82e0dbf86)


•	In this query, we select the film_id and title columns from the film table. We join the film, inventory, rental, and payment tables based on their respective relationships. The GROUP BY clause groups the results by film_id.
•	The HAVING clause filters the results to include only those groups where the count of 16 is not equal to the length of the title. It compares the result of COUNT(16) (which counts the occurrences of the number 16 within the group) with the length of the title column.
•	This query will return the film ID and title for groups where the count of the number 16 is not equal to the length of the film title.
11. select c.city_id,c.city,c.country_id,a.district,a.postal_code 
from city 
c right outer join address a on c.city_id=a.city_id 
where city like 'C%' and 
country_id=any(select distinct c.country_id from city c);

 ![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/65228839-bfca-4e63-a9a4-31559109e9aa)

•	In this query, we select the city_id, city, country_id, district, and postal_code columns. We perform a right outer join between the city and address tables based on the city_id column.
•	The WHERE clause filters the results to include only those rows where the city starts with 'C' and the country_id is present in the subquery result. The subquery retrieves distinct country_id values from the city table.
•	This query will return the city_id, city, country_id, district, and postal_code for matching records between the city and address tables where the city name starts with 'C' and the country_id is in the set of distinct country_ids from the city table.
12.SELECT f.rating, count(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
HAVING count(p.amount) > 1000 
ORDER BY total_revenue DESC;

![image](https://github.com/Savitha2512/Week-2-project/assets/137802187/6224b1ff-f7af-4b4a-9877-00a0b37ed162)

 
•	The provided SQL query retrieves the film rating (f.rating) and the count of payment amounts (count(p.amount)) as "total_revenue".
•	It joins the film, inventory, rental, and payment tables based on their respective relationships. It then groups the results by film rating (f.rating). 
•	The HAVING clause filters the groups to include only those with a count of payment amounts greater than 1000. Finally, the results are sorted in descending order based on the total revenue.
•	This query will return the film rating and the count of payment amounts as total revenue for each rating, filtering out groups with a count of payment amounts less than or equal to 1000. The results will be sorted in descending order based on the total revenue.

CONCLUSION

DVD rental database consists of many clients where in order to satisfy client, we have to provide the code which satisfy their needs. This will help them to improve the product experience to their clients. 
The company has sport-loving customers and they would be advisable to stock more sport-related films to increase total sales compared to music-related movies. It would be a good idea to increase the average rental rate of sport genre films since it is not a major factor in renting for the customers. 
The data is segregated based on total revenue and baseline is provided with which we can increase the rating by taking preventive measures.
