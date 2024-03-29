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

/*
  Leap Noir
  # List all the directors who directed a 'Film-Noir' movie in a leap year (you need to check that the genre is 'Film-Noir' and may, for the sake of this challenge, pretend that all years divisible by 4 are leap years) Your query should return director name, the movie name, and the year, sorted by movie name
*/

SELECT *
FROM movies AS m
INNER JOIN movies_genres AS mg ON m.id = mg.movie_id
AND mg.genre = 'Film-Noir'
  INNER JOIN movies_directors AS md ON m.id = md.movie_id
    INNER JOIN directors AS d ON md.director_id = d.id;
      WHERE year % 4 = 0;
      ORDER BY m.name ASC;

/*
  Bacon
  # List all the actors that have worked with Kevin Bacon in Drama movies (include the movie name)
*/

SELECT *, a.first_name || " " || a.last_name AS full_name
FROM actors AS a
INNER JOIN roles AS r ON r.actor_id = a.id
  INNER JOIN movies AS m ON r.movie_id = m.id
    INNER JOIN movies_genres AS mg ON mg.movie_id = m.id
    AND mg.genre = 'Drama'
      WHERE m.id IN (
        SELECT m2.id
        FROM movies AS m2
        INNER JOIN roles AS r2 ON r2.movie_id = m2.id
          INNER JOIN actors AS a2 ON r2.actor_id = a2.id
          AND a2.first_name = 'Kevin'
          AND a2.last_name = 'Bacon'
      )
        AND full_name != 'Kevin Bacon'
        ORDER BY a.last_name ASC;

/*
  Immortals
  # Which actors have acted in a film before 1900 and also in a film after 2000?
*/

SELECT actors.id, actors.first_name, actors.last_name
FROM actors
INNER JOIN roles ON roles.actor_id = actors.id
  INNER JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year < 1990
INTERSECT
SELECT actors.id, actors.first_name, actors.last_name
FROM actors
INNER JOIN roles ON roles.actor_id = actors.id
  INNER JOIN movies ON movies.id = roles.movie_id
    WHERE movies.year > 2000;

/*
  Busy Filming
  # Find actors that played five or more roles in the same movie after the year 1990. Notice that ROLES may have occasional duplicates, but we are not interested in these: we want actors that had five or more distinct (cough cough) roles in the same movie. Write a query that returns the actors' names, the movie name, and the number of distinct roles that they played in that movie (which will be ≥ 5)
*/

SELECT COUNT(DISTINCT roles.role) AS num_roles_in_movies, *
FROM actors
INNER JOIN roles ON roles.actor_id = actors.id
  INNER JOIN movies ON roles.movie_id = movies.id
    WHERE movies.year > 1990
    GROUP BY actors.id, movies.id
    HAVING num_roles_in_movies > 4;

/*
  Female Actors Only
  # For each year, count the number of movies in that year that had only female actors
  # For movies where no one was casted, you can decide whether to consider them female-only
*/

SELECT movies.year, COUNT(*) AS movies_in_year
FROM movies
WHERE movies.id NOT IN (
  SELECT DISTINCT movies.id
  FROM movies
  INNER JOIN roles ON movies.id = roles.movie_id
    INNER JOIN actors ON roles.actor_id = actors.id
    AND actors.gender = 'M';
)
AND movies.id IN (
  SELECT DISTINCT movies.id
  FROM movies
  INNER JOIN roles ON movies.id = roles.movie_id
    INNER JOIN actors ON roles.actor_id = actors.id
    AND actors.gender = 'F';
)
GROUP BY movies.year;
