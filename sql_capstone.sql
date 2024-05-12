SELECT * FROM sql_capstone.amazon;

---- 1. What is the count of distinct cities in the dataset?

select COUNT(distinct city) as cities from sql_capstone.amazon;

---- 2. For each branch, what is the corresponding city?

select branch,city from sql_capstone.amazon;

---- 3. What is the count of distinct product lines in the dataset?

select COUNT(distinct 'Product line') as distinct_product_lines from sql_capstone.amazon;

---- 4. Which payment method occurs most frequently?

SELECT payment, COUNT(*) AS payment_method_occurance
FROM sql_capstone.amazon
GROUP BY payment
ORDER BY payment_method_occurance DESC
LIMIT 1; 


---- 5. Which product line has the highest sales?

SELECT `Product line`, COUNT(`Invoice ID`) AS sales_count
FROM sql_capstone.amazon
GROUP BY `Product line`
ORDER BY sales_count DESC
LIMIT 1;


---- 6. How much revenue is generated each month?

SELECT MONTHNAME(`date`) AS month, COUNT(`Invoice ID`) AS revenue
FROM sql_capstone.amazon
GROUP BY month
ORDER BY revenue DESC;


---- 7. In which month did the cost of goods sold reach its peak?

SELECT MONTHNAME(`date`) AS month, SUM(cogs) AS total_cogs
FROM sql_capstone.amazon
GROUP BY month
ORDER BY total_cogs DESC
LIMIT 1;


---- 8. Which product line generated the highest revenue?

SELECT `Product line`, SUM(Total) AS revenue
FROM sql_capstone.amazon
GROUP BY `Product line`
ORDER BY revenue DESC
LIMIT 1;


---- 9. In which city was the highest revenue recorded?

SELECT City, SUM(Total) AS revenue
FROM sql_capstone.amazon
GROUP BY City
ORDER BY revenue DESC;


---- 10. Which product line incurred the highest Value Added Tax?

SELECT `Product line`, SUM(`Tax 5%`) AS Highest_value_tax
FROM sql_capstone.amazon
GROUP BY `Product line`
ORDER BY Highest_value_tax DESC
LIMIT 1;


---- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT
  `Product line`,
  SUM(Total) AS revenue,
  CASE
    WHEN SUM(Total) < (SELECT AVG(Total) FROM sql_capstone.amazon) THEN 'Bad'
    ELSE 'Good'
  END AS sales_evaluation
FROM
  sql_capstone.amazon
GROUP BY `Product line`
ORDER BY revenue DESC ;


---- 12. Identify the branch that exceeded the average number of products sold.

SELECT
  branch,
  SUM(Quantity) AS Total_No_product_sold,
  CASE
    WHEN SUM(Quantity) > (SELECT AVG(Quantity) FROM sql_capstone.amazon) THEN 'Exceeded'
    ELSE 'Not Exceeded'
  END AS sales_evaluation
  FROM sql_capstone.amazon
GROUP BY branch;


---- 13. Which product line is most frequently associated with each gender?

SELECT gender, `Product line`, COUNT(*) AS product_line_count
FROM sql_capstone.amazon
GROUP BY gender, `Product line`
ORDER BY gender, product_line_count DESC;

---- 14. Calculate the average rating for each product line.

SELECT `Product line`, AVG(rating) AS average_rating
FROM sql_capstone.amazon
GROUP BY `Product line`;


---- 15. Count the sales occurrences for each time of day on every weekday.

SELECT 
    DAYNAME(date) AS dayname,
    CASE 
        WHEN EXTRACT(HOUR FROM time) >= 0 AND EXTRACT(HOUR FROM time) < 6 THEN 'Night'
        WHEN EXTRACT(HOUR FROM time) >= 6 AND EXTRACT(HOUR FROM time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time) >= 12 AND EXTRACT(HOUR FROM time) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS timeofday,
    COUNT(`Invoice Id`) AS count_of_sales
FROM sql_capstone.amazon
WHERE DAYNAME(date) NOT IN ('Saturday', 'Sunday') 
GROUP BY dayname, timeofday
ORDER BY dayname DESC, count_of_sales DESC;


---- 16. Identify the customer type contributing the highest revenue.

SELECT `customer type`, SUM(Total) AS Highest_revenue
FROM sql_capstone.amazon
GROUP BY `customer type`
ORDER BY Highest_revenue DESC;

--- AS Per Conclusion the Customer type which is contributing the Highest Revenue is "Member".


---- 17. Determine the city with the highest VAT percentage.

SELECT city, AVG(`Tax 5%` / total) * 100 AS Highest_VAT_percentage
FROM sql_capstone.amazon
GROUP BY city
ORDER BY Highest_VAT_percentage
LIMIT 1;

---- AS Per Conclusion the city which has highest VAT percentage is "Mandalay".


---- 18. Identify the customer type with the highest VAT payments.

SELECT `Customer type`,SUM(`Tax 5%`) AS Highest_VAT_payment
FROM sql_capstone.amazon
GROUP BY `Customer type`
ORDER BY Highest_VAT_payment DESC
LIMIT 1;

--- AS Per Conclusion the Customer type which is contributing the highest VAT payments is "Member".


---- 19. What is the count of distinct customer types in the dataset?

SELECT COUNT(DISTINCT `customer type`) AS count_of_distinct_customer_types
FROM sql_capstone.amazon;

---- AS Per Conclusion the count of distinct of Customer type is "2".


---- 20. What is the count of distinct payment methods in the dataset?

SELECT COUNT(DISTINCT payment ) AS count_of_distinct_payment_methods
FROM sql_capstone.amazon;

---- AS Per Conclusion the count of distinct payment methods is "3".

---- 21. Which customer type occurs most frequently?

SELECT `customer type`, COUNT(*) AS occurrence_count
FROM sql_capstone.amazon
GROUP BY `customer type`
ORDER BY occurrence_count DESC
LIMIT 1;

---- AS Per Conclusion the Most Frequent Customer type is "Member".


---- 22. Identify the customer type with the highest purchase frequency.


SELECT `customer type`, COUNT(*) AS Purchase_Frequency
FROM sql_capstone.amazon
GROUP BY `customer type`
ORDER BY Purchase_Frequency DESC
LIMIT 1;

---- AS Per Conclusion the highest purchase frequency Customer type is "Member".


---- 23. Determine the predominant gender among customers.


SELECT gender, COUNT(*) AS predominant_gender
FROM sql_capstone.amazon
GROUP BY gender
ORDER BY predominant_gender;

---- AS per Conclusion the "Female" is the predominant gender among customers.


---- 24. Examine the distribution of genders within each branch.

SELECT branch, gender ,COUNT(*) AS gender_count
FROM sql_capstone.amazon
GROUP BY branch,gender
ORDER BY branch,gender;


---- 25. Identify the time of day when customers provide the most ratings.

SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM time) >= 0 AND EXTRACT(HOUR FROM time) < 6 THEN 'Night'
        WHEN EXTRACT(HOUR FROM time) >= 6 AND EXTRACT(HOUR FROM time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time) >= 12 AND EXTRACT(HOUR FROM time) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS timeofday,
    COUNT(*) AS ratings
FROM sql_capstone.amazon 
GROUP BY timeofday
ORDER BY ratings DESC;

---- Afternoon is the time of day when customers provide the most ratings


---- 26. Determine the time of day with the highest customer ratings for each branch.

SELECT 
	branch,
	CASE
		WHEN EXTRACT(HOUR FROM time) >= 0 AND EXTRACT(HOUR FROM time) < 6 Then 'Night'
		WHEN EXTRACT(HOUR FROM time) >= 6 AND EXTRACT(HOUR FROM time) < 12 Then 'Morning'
		WHEN EXTRACT(HOUR FROM time) >= 12 AND EXTRACT(HOUR FROM time) < 18 Then 'Afternoon'
		ELSE 'Evening'
		END AS timeofday,
        COUNT(*) Highest_customer_rating
	FROM sql_capstone.amazon 
    GROUP BY branch,timeofday
    ORDER BY Branch, timeofday DESC;
    

---- 27. Identify the day of the week with the highest average ratings.

SELECT DAYNAME(date) AS day_of_week, AVG(rating) AS average_rating
FROM sql_capstone.amazon 
GROUP BY day_of_week
ORDER BY average_rating
LIMIT 1;

---- AS per Conclusion "Wednesday" is the day of the week with the highest average ratings.


---- 28. Determine the day of the week with the highest average ratings for each branch.

 SELECT branch, DAYNAME(date) AS day_of_week,AVG(rating) AS average_rating
 FROM sql_capstone.amazon 
 GROUP BY branch, day_of_week
 ORDER BY branch, average_rating DESC;


    
    


