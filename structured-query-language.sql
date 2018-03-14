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

/*
  Popular Names
  # What are the 10 most popular first names and last names in the business?
*/

SELECT first_name, COUNT(*) AS occurences
FROM actors
GROUP BY first_name
ORDER BY occurences DESC
LIMIT 10;

SELECT last_name, COUNT(*) AS occurences
FROM actors
GROUP BY last_name
ORDER BY occurences DESC
LIMIT 10;

/*
  Prolific
  # List the top 100 most active actors and the number of roles they have starred in
*/

SELECT first_name, last_name, COUNT(*) AS num_roles
FROM actors
INNER JOIN roles ON actors.id = roles.actor_id
GROUP BY actors.id
ORDER BY num_roles DESC
LIMIT 100;

/*
  Bottom of the Barrel
  # How many movies does IMDB have of each genre, ordered by least popular genre?
*/

SELECT genre, COUNT(*) AS num_movies
FROM movies_genres;
GROUP BY genre
ORDER BY num_movies ASC;

/*
  Braveheart
  # List the first and last names of all the actors who played in the 1995 movie 'Braveheart', arranged alphabetically by last name
*/

SELECT first_name, last_name
FROM actors
INNER JOIN roles ON actors.id = roles.actor_id
  INNER JOIN movies ON roles.movie_id = movies.id
  AND movies.name = 'Braveheart'
  AND movies.year = 1995;
    ORDER BY actors.last_name;
