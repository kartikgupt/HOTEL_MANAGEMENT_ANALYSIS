create database project -- database creation
use project 
CREATE TABLE hotel(    -- table creation to import data
    Booking_ID INT PRIMARY KEY,
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR(50),
    room_type_reserved VARCHAR(50),
    lead_time INT,
    arrival_date DATE,
    market_segment_type VARCHAR(50),
    avg_price_per_room DECIMAL(10, 2),
    booking_status VARCHAR(20)
);
ALTER TABLE hotel
MODIFY COLUMN booking_id VARCHAR(50); -- modifying because booking id's data tye was initiated wrong
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE hotel MODIFY arrival_date VARCHAR(255);-- modifying because of error invalid value of date
UPDATE hotel -- updating the date to its original formate
SET arrival_date = STR_TO_DATE(arrival_date, '%d-%m-%Y');
select * from hotel-- checking the data

-- 1. What is the total number of reservations in the dataset? 
select count(distinct booking_id) from hotel -- using distinct to avoid duplicate data

-- 2. Which meal plan is the most popular among guests? 
select type_of_meal_plan ,count(type_of_meal_plan) from hotel
group by type_of_meal_plan
-- we can see meal plan 1 is most popular 

-- 3. What is the average price per room for reservations involving children? 
select avg(avg_price_per_room) from hotel
where no_of_children > 0 ;

-- 4. How many reservations were made for the year 20XX (replace XX with the desired year)? 
select count(*) from hotel
where year(arrival_date) =2018 ;

-- 5. What is the most commonly booked room type? 
select count(room_type_reserved) , 
room_type_reserved from hotel
group by room_type_reserved;

-- 6. How many reservations fall on a weekend (no_of_weekend_nights > 0)? 
select count(booking_id) from hotel
where no_of_weekend_nights > 0

-- 7. What is the highest and lowest lead time for reservations? 
select min(lead_time) , max(lead_time) from hotel

-- 8. What is the most common market segment type for reservations? 
select market_segment_type , count(market_segment_type) 
from hotel
group by market_segment_type;

-- 9. How many reservations have a booking status of "Confirmed"? 
select count(booking_id) from hotel
where booking_status = "Not_Canceled"; -- in a case where we are assuming not_cancelled as confirmed


-- 10. What is the total number of adults and children across all reservations? 
select sum(no_of_adults) + sum(no_of_children) from hotel

-- 11. What is the average number of weekend nights for reservations involving children? 
select avg(no_of_weekend_nights) from hotel
where no_of_children>0;

-- 12. How many reservations were made in each month of the year? 
SELECT
    MONTH(arrival_date) AS reservation_month, year(arrival_date) AS reservation_year,
    COUNT(*) AS total_reservations FROM hotel
GROUP BY reservation_month,reservation_year
ORDER BY reservation_month,reservation_year

-- 13.What is the average number of nights (both weekend and weekday) spent by guests for each room type? 
SELECT room_type_reserved, AVG(no_of_weekend_nights + no_of_week_nights) AS avg_nights
FROM hotel
GROUP BY room_type_reserved;

-- 14 For reservations involving children, what is the most common room type, and what is the average price for that room type? 
select room_type_reserved , avg(avg_price_per_room)
from hotel
where no_of_children >0
group by room_type_reserved
order by room_type_reserved;

-- 15. Find the market segment type that generates the highest average price per room.

SELECT market_segment_type, AVG(avg_price_per_room) AS avg_price
FROM hotel
GROUP BY market_segment_type
ORDER BY avg_price DESC
LIMIT 1;





    






