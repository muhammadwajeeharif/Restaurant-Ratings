													-- RESTAURANT RATINGS
-- Q1) How many times restaurants get lowest and highest ratings ?
SELECT Overall_Rating,COUNT(*)
FROM restaurants
INNER JOIN ratings
ON restaurants.Restaurant_ID=ratings.Restaurant_ID
WHERE Overall_Rating IN (0,2)   
GROUP BY Overall_Rating;

-- Q2) How many restaurants get lowest and highest ratings and by which consumers?
SELECT Overall_Rating,COUNT(*), consumers.Consumer_ID
FROM restaurants
INNER JOIN ratings
ON restaurants.Restaurant_ID=ratings.Restaurant_ID
INNER JOIN consumers
ON ratings.Consumer_ID=consumers.Consumer_ID
WHERE Overall_Rating IN (0,2) 
GROUP BY consumers.Consumer_ID
ORDER BY COUNT(*) DESC;


-- Q3) Select all restaurants where public parking is available and their budget is low?
SELECT Name,Parking,Price
FROM restaurants
WHERE Parking="Public" AND Price ="Low";

-- Q4) What can you learn from the top three highest rated and lowest rated restaurants ? Do consumer preferences have an effect on ratings?

SELECT * FROM restaurants;
-- Top 5 Highet rated restaurants
SELECT Name,Smoking_Allowed,Alcohol_Service,Area,Franchise,Parking
FROM restaurants
INNER JOIN ratings 
ON restaurants.Restaurant_ID=ratings.Restaurant_ID
WHERE Overall_Rating=2 AND Food_Rating=2 AND Service_Rating=2
GROUP BY Name
ORDER BY COUNT(Overall_Rating) DESC
LIMIT 5;
-- Top 5 lowests rated restaurants
SELECT Name,Smoking_Allowed,Alcohol_Service,Area,Franchise,Parking
FROM restaurants
INNER JOIN ratings 
ON restaurants.Restaurant_ID=ratings.Restaurant_ID
WHERE Overall_Rating=0 AND Food_Rating=0 AND Service_Rating=0
GROUP BY Name
ORDER BY COUNT(Overall_Rating) DESC
LIMIT 5;

SELECT Preferred_Cuisine,COUNT(Overall_Rating),COUNT(Food_Rating),COUNT(Service_Rating)
FROM ratings
INNER JOIN  consumer_preferences
ON ratings.Consumer_ID=consumer_preferences.Consumer_ID
WHERE Overall_Rating=2 AND Food_Rating=2 AND Service_Rating=2
GROUP BY Preferred_Cuisine
ORDER BY COUNT(Overall_Rating) DESC;


-- Q5) What are the consumer demographics? Does this indicate a bias in the data sample?

SELECT  City,Budget,Age,COUNT(Age)
FROM consumers
GROUP BY City,Budget,Age
ORDER BY City ,Age;

-- Q6) Are there any demand & supply gaps that you have analyzed so far?
SELECT restaurants.Name,consumers.Budget,restaurants.Price
FROM restaurants
INNER JOIN consumers 
ON restaurants.City=consumers.City;


-- Q7) If you were to invest into restaurants, which charactersitics would you be looking for?
SELECT Name,City,Alcohol_Service,Smoking_Allowed,Price,Franchise,Area,
Parking,ROUND((ratings.Overall_Rating+ratings.Food_Rating+ratings.Service_Rating)/3) AS Restaurant_Rating
FROM restaurants
INNER JOIN ratings
ON restaurants.Restaurant_ID=ratings.Restaurant_ID
WHERE Alcohol_Service <> "None" AND Parking <> "None" AND Smoking_Allowed <> "No" 
GROUP BY Name
ORDER BY Restaurant_Rating DESC;


-- Q8) What kind of transportation do customers used to reach restaurants, what are their ages and occupation?

SELECT Consumer_ID,Age,Occupation,Transportation_Method
FROM consumers
GROUP BY Consumer_ID
ORDER BY Consumer_ID;

-- Q9) How many consumers prefer both drinking and smoking in restaurants and what kind of restaurants do they prefer?

SELECT consumers.Consumer_ID,smoker,Drink_Level,consumer_preferences.Preferred_Cuisine
FROM consumers
	INNER JOIN consumer_preferences
		ON consumers.Consumer_ID=consumer_preferences.Consumer_ID
WHERE smoker="yes"
GROUP BY Consumer_ID
ORDER BY Consumer_ID;

-- Q10) what kind of restaurants allows smoking and drinking services in their restuarants and what are their Preferred Cuisines ?
SELECT  R.Restaurant_ID , Name , RC.Cuisine , Smoking_Allowed , Alcohol_Service 
FROM restaurants as R
INNER JOIN restaurant_cuisines as RC
ON R.Restaurant_ID = RC.Restaurant_ID
WHERE Smoking_Allowed <> 'No'and  Alcohol_Service <> 'None'
GROUP BY  Restaurant_ID
ORDER BY Restaurant_ID;

-- Q11) Which city has highest number of restaurants and which of them are highly rated?

SELECT R.Restaurant_ID , name , city , Consumer_ID , round((overall_rating+ food_rating + service_rating )/3) as Ratings
FROM restaurants as R
INNER JOIN ratings AS RA
ON R.Restaurant_ID = RA.Restaurant_ID
GROUP BY Restaurant_ID
ORDER BY overall_rating DESC ;

-- Q12) how much do customers prefer spending in restaurants and what kind of cuisine?
SELECT C.Consumer_ID, budget, CP.Preferred_Cuisine
FROM consumers as C
	INNER JOIN consumer_preferences as CP
		ON C.Consumer_ID= CP.Consumer_ID
GROUP BY Consumer_ID,budget
ORDER BY Consumer_ID;

/* Q13) Which restaurant allowed smoking and parking;their consumer rating VS
Which restaurant doesn’t allow smoking and doesn’t allow parking; their consumer rating? */
SELECT R.Restaurant_ID , name , Smoking_allowed , parking ,
Consumer_ID ,round((overall_rating+ food_rating + service_rating )/3) AS Customer_Ratings
FROM restaurants AS R
inner join ratings AS RA
on R.Restaurant_ID = RA.Restaurant_ID 
where Parking <> "None" AND Smoking_Allowed <> "No"
ORDER BY Customer_Ratings DESC;

SELECT R.Restaurant_ID , name , Smoking_allowed , parking ,
Consumer_ID ,round((overall_rating+ food_rating + service_rating )/3) AS Customer_Ratings
FROM restaurants AS R
inner join ratings AS RA
on R.Restaurant_ID = RA.Restaurant_ID 
where Parking = "None" AND Smoking_Allowed = "No"
ORDER BY Customer_Ratings DESC;


