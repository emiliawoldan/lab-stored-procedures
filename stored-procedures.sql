
-- 1 Stored Procedure
DELIMITER //
create procedure customers_names_and_emails()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end //
DELIMITER ;

call customers_names_and_emails();

-- 2 Now keep working on the previous stored procedure to make it more dynamic. 
-- Update the stored procedure in a such manner that it can take a string argument for 
-- the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.


DELIMITER //
create procedure customers_names_and_emails_v2 (in param1 varchar(30))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param1
  group by first_name, last_name, email;
end //
DELIMITER ;

call customers_names_and_emails_v2("Action");


-- drop procedure if exists customers_names_and_emails_v2;



-- 3 Write a query to check the number of movies released in each movie category. 
SELECT name as category, COUNT(film_id) AS number_of_movies FROM sakila.film_category
JOIN category USING (category_id)
GROUP BY name
ORDER BY name;


-- 4 Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
-- Pass that number as an argument in the stored procedure.

DELIMITER //
CREATE PROCEDURE movies_per_category (in x int)
begin
	SELECT name FROM sakila.film_category
	JOIN category USING (category_id)
	GROUP BY name
	HAVING COUNT(film_id) > x;
end //
DELIMITER //

-- drop procedure if exists movies_per_category;

call movies_per_category(70);
-- select @num;



 
 
/* extra
DELIMITER //
CREATE PROCEDURE movies_per_category_v2 (in x int, out y varchar(30))
begin
	SELECT count(name) into y FROM sakila.film_category
	JOIN category USING (category_id);
	-- GROUP BY name
	-- COUNT(film_id) > x;
end //
DELIMITER //

-- drop procedure if exists movies_per_category_v2;

call movies_per_category_v2(70, @num);
select @num;


SELECT count(name) FROM sakila.category;



SELECT count(name) FROM sakila.film_category
JOIN category USING (category_id)
GROUP BY name
HAVING COUNT(film_id) > 50;

*/
