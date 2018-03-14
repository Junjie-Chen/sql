/*
  Car
  # Find all movie-names that have the word "Car" as the first word in the name
*/

SELECT *
FROM movies
WHERE name LIKE 'Car %';

/*
  Birth Year
  # Find all movies made in the yea ryou were born
*/

SELECT *
FROM movies
WHERE year = 1990;

/*
  1982
  # How many movies does our dataset have for the year 1982?
*/

SELECT COUNT(*), year
FROM movies
WHERE year = 1982
GROUP BY year;

/*
  Stacktors
  # Find actors who have "stack" in their last name
*/

SELECT *
FROM actors
WHERE last_name LIKE '%stack%';
