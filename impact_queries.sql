USE impactDB;

-- How did the pilot school 5th graders’ ELA mean scores compare to the non-pilot 5th graders in 2017 (2016 - 2017 school year)? 
SELECT pilot, AVG(overall_ela_mean_scale_score) AS average_score
FROM scores
WHERE year = 2017
AND test_name LIKE 'ELA/Literacy Grade 5'
GROUP BY pilot;

-- Which pilot school exhibited the most growth in ELA mean scale scores from the 2016 test through the 2017 test?
SELECT M1.school_id, (2017score - 2016score) AS highest_growth
FROM
(SELECT T1.school_id, 2016score, 2017score
FROM 
(SELECT DISTINCT school_id, year, overall_ela_mean_scale_score as 2016score
FROM scores
WHERE year = 2016
AND pilot = 1
AND test_name LIKE 'ELA/Literacy Grade 5') AS T1
JOIN 
(SELECT DISTINCT school_id, year, overall_ela_mean_scale_score as 2017score
FROM scores
WHERE year = 2017
AND pilot = 1
AND test_name LIKE 'ELA/Literacy Grade 5') AS T2
ON T1.school_id = T2.school_id) AS M1;


-- What is the percentage difference in this school’s 5th grade growth from 2016 through 2017 compared to the other pilot schools’ 5th grade average growth during the same time period?
SELECT M1.school_id, ((2017score - 2016score)/2016score)*100 AS percent_growth
FROM
(SELECT T1.school_id, 2016score, 2017score
FROM 
(SELECT DISTINCT school_id, year, overall_ela_mean_scale_score as 2016score
FROM scores
WHERE year = 2016
AND pilot = 1
AND test_name LIKE 'ELA/Literacy Grade 5') AS T1
JOIN 
(SELECT DISTINCT school_id, year, overall_ela_mean_scale_score as 2017score
FROM scores
WHERE year = 2017
AND pilot = 1
AND test_name LIKE 'ELA/Literacy Grade 5') AS T2
ON T1.school_id = T2.school_id) AS M1;

-- What was the average percentage of students who received free/reduced lunch in the 5 pilot schools in 2017?
SELECT pilot, AVG(percentage) AS average_percentage
FROM demographics
WHERE year = 2017
AND pilot = 1
GROUP BY pilot;

-- What was the average ELA mean test score of the non-pilot schools that have an equal or greater percentage of students who qualify for free/reduced lunch as the pilot schools? Please only look at the 5th grade class in the 2017 school year.
SELECT AVG(overall_ela_mean_scale_score) AS average_score
FROM scores
WHERE test_name LIKE 'ELA/Literacy Grade 5'
AND school_id IN
(SELECT school_id
FROM demographics
WHERE pilot = 0
AND year = 2017
AND percentage >= 0.2564399987459183);













 