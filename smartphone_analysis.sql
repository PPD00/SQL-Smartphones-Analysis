CREATE TABLE smartphones (
    brand_name VARCHAR(50),
    model VARCHAR(100),
    price INT,
    rating INT,
    has_5g BOOLEAN,
    has_ir_blaster BOOLEAN,
    processor_brand VARCHAR(50),
    num_cores INT,
    processor_speed DECIMAL(3,1),  
    battery_capacity INT,          
    fast_charging_available BOOLEAN,
    fast_charging INT,             
    ram_capacity INT,              
    internal_memory INT,           
    screen_size DECIMAL(3,1),      
    refresh_rate INT,              
    num_rear_cameras INT,
    os VARCHAR(50),
    resolution_width INT,
    resolution_height INT
);

select * from smartphones


1. What are the top 5 models with the highest battery capacity?

SELECT model, battery_capacity
FROM smartphones
WHERE battery_capacity IS NOT NULL
ORDER BY battery_capacity DESC
LIMIT 5

2. Calculate the rolling average price of smartphones within each brand using a window function.

SELECT brand_name, model, price, 
       ROUND(AVG(price) OVER(PARTITION BY brand_name ORDER BY model
	    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_price
FROM smartphones
GROUP BY brand_name, model, price

3. How many brands are in the store, and how many models does each brand have?

SELECT COUNT(DISTINCT brand_name) AS no_of_brands
FROM smartphones

SELECT brand_name, COUNT(DISTINCT model) AS no_of_models
FROM smartphones
GROUP BY brand_name
ORDER BY no_of_models DESC

4. What is the total price of smartphones for each brand and model?

SELECT brand_name, model, SUM(price) AS total_price
FROM smartphones
GROUP BY brand_name, model
ORDER BY total_price DESC

5. Which are the top 3 highest-rated brands and models?

SELECT brand_name, model, rating
FROM smartphones
WHERE rating IS NOT NULL
ORDER BY rating DESC

6. Which mobiles do not have 5G or have an IR blaster?

SELECT brand_name, model
FROM smartphones
WHERE has_5g = 'false' OR has_ir_blaster = 'true'

7. How many processor brands are available, and how many processors does each brand have?

SELECT COUNT(DISTINCT processor_brand) AS no_of_processor_brand
FROM smartphones

SELECT brand_name, COUNT(DISTINCT processor_brand) AS no_of_processor
FROM smartphones
GROUP BY brand_name
ORDER BY no_of_processor DESC

8. How many cores does each model have, and how are they ranked by the number of cores?

SELECT DISTINCT model, num_cores
FROM smartphones
WHERE num_cores IS NOT NULL
ORDER BY num_cores DESC

SELECT DISTINCT model, num_cores, DENSE_RANK() OVER(ORDER BY num_cores DESC) AS rank
FROM smartphones
WHERE num_cores IS NOT NULL
ORDER BY rank

9. Which model and brand have the highest processor speed?

SELECT brand_name, model, processor_speed
FROM smartphones
WHERE processor_speed IS NOT NULL
ORDER BY processor_speed DESC
LIMIT 1

10. Which 5 brands have the highest RAM capacity and internal memory?

SELECT brand_name, MAX(ram_capacity) AS max_ram, MAX(internal_memory) AS max_memory
FROM smartphones
GROUP BY brand_name
ORDER BY max_ram, max_memory DESC
LIMIT 5

11. Which are the top 10 models with the smallest screen size?

SELECT model, MIN(screen_size) AS min_screen_size
FROM smartphones
GROUP BY model
ORDER BY min_screen_size
LIMIT 10

12. How are brands ranked based on their refresh rate?

SELECT brand_name,refresh_rate, DENSE_RANK() OVER(ORDER BY refresh_rate DESC) AS rank
FROM smartphones
ORDER BY rank

13. Which model and brand have the most rear cameras?

SELECT brand_name, model, MAX(num_rear_cameras) AS most_rear_cameras
FROM smartphones
GROUP BY brand_name, model
ORDER BY most_rear_cameras DESC

14. What are the different OS types for each brand?

SELECT brand_name, COUNT(DISTINCT os) AS diff_no_of_OS
FROM smartphones
GROUP BY brand_name
ORDER BY diff_no_of_OS DESC

15. Which are the top 5 models with the highest resolution?

SELECT model, (resolution_width * resolution_height) AS resolution
FROM smartphones
ORDER BY resolution DESC
LIMIt 5

16. How are brands ranked based on the highest resolution, lowest refresh rate, and highest internal memory?

SELECT brand_name,
       RANK() OVER (ORDER BY MAX(resolution_width * resolution_height) DESC) AS resolution_rank,
       RANK() OVER (ORDER BY MIN(refresh_rate) ASC) AS refresh_rate_rank,
       RANK() OVER (ORDER BY MAX(internal_memory) DESC) AS memory_rank
FROM smartphones   
GROUP BY brand_name

17. What are the processor speeds by processor brand, and which are the top 3 brands?

SELECT DISTINCT processor_brand, processor_speed
FROM smartphones
WHERE processor_speed IS NOT NULL
ORDER BY processor_speed DESC
LIMIT 3

18. What is the average price of smartphones for each brand?

SELECT brand_name, ROUND(AVG(price), 2) AS avg_price
FROM smartphones
GROUP BY brand_name
ORDER BY avg_price DESC

19. What is the average user rating for smartphones of each brand?

SELECT brand_name, ROUND(AVG(rating), 2) AS avg_rating
FROM smartphones
WHERE rating IS NOT NULL
GROUP BY brand_name
ORDER BY avg_rating DESC

20. What percentage of smartphones support 5G?

SELECT (COUNT(CASE WHEN has_5g = TRUE THEN 1 END) * 100.0) / COUNT(*) AS percentage_5g_supported
FROM smartphones
WHERE has_5g IS NOT NULL

21. What is the correlation between screen size and refresh rate for each brand?

SELECT brand_name, CORR(screen_size, refresh_rate) AS correlation
FROM smartphones
GROUP BY brand_name




select * from smartphones