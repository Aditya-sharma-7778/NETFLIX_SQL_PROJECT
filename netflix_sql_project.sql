create table netflix
(
show_id VARCHAR(6),
type VARCHAr(10),
title VARCHAR(150),
director VARCHAR(250),
casts VARCHAR(1000),
country VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(10),
duration VARCHAR(15),
listed_in	VARCHAR(155),
description VARCHAR(1260)


);
DROP TABLE IF EXISTS netflix;

SELECT * FROM netflix;
l

SELECT count(*) as total_count FROM netflix;

SELECT DISTINCT TYPE FROM netflix;
-- 15 Business Problems & Solutions



-- 1. Count the number of Movies vs TV Shows

 SELECT TYPE , COUNT(*)AS TOTAL_CONTENT FROM netflix GROUP BY TYPE;





-- 2. Find the most common rating for movies and TV shows

SELECT TYPE,RATING,COUNT(*) FROM NETFLIX GROUP BY 1,2 ORDER BY 3 DESC;



-- 3. List all movies released in a specific year (e.g., 2020)

SELECT * FROM NETFLIX
WHERE TYPE='Movie' and
release_year='2020';

-- 4. Find the top 5 countries with the most content on Netflix
SELECT COUNTRY,COUNT(show_id) as number_of_content FROM NETFLIX 
GROUP BY country
order by number_of_content desc  limit 5 ;




-- 5. Identify the longest movie
select max(duration) as max_duration
from netflix
where type='Movie'

-- 6. Find content added in the last 5 years
select *
FROM NETFLIX
WHERE 
TO_DATE(date_added,'Month DD,YYYY')>=CURRENT_DATE -INTERVAL '5 YEARS';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select * from netflix where director like '%Rajiv Chilaka%';
-- 8. List all TV shows with more than 5 seasons
 

select *
from netflix
 where type='TV Show' and
 SPLIT_PART(duration,' ',1)::numeric >5;

-- 9. Count the number of content items in each genre
select UNNEST(STRING_TO_ARRAY(listed_in,','))as genre,
COUNT(show_id)from netflix
group by 1
order by 2 desc;
-- 10.Find each year and the average numbers of content release in India on netflix. 
select EXTRACT(YEAR FROM TO_DATE(date_added,'month DD,YYYY'))AS YEAR,
count(*),
count(*)::numeric/(select count(* ) from netflix where country='India')::numeric *100 as no_of_avg_content
from netflix
where country='India'
group by 1;
-- order by no_of_content desc;

-- return top 5 year with highest avg content release!
-- 11. List all movies that are documentaries
select * from netflix WHERE listed_in ILIKE'%documentaries';


-- 12. Find all content without a director
SELECT * FROM NETFLIX WHERE director is null;
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix 
where casts ilike '%salman khan%'
and release_year>EXTRACT(YEAR FROM CURRENT_DATE)-10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select UNNEST(STRING_TO_ARRAY(CASTS,','))as ACTORS,
COUNT(show_id)from netflix
group by 1
order by 2 desc;
-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2




-- End of reports
