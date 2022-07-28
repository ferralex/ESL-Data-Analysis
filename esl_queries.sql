--1)lessons rating average by school
SELECT sc.name AS school_name, ROUND(AVG(l.rating),2) AS rating_avg, ROUND(AVG(l.rating),2)-
(
	SELECT ROUND(AVG(l.rating) ,2)
	FROM lesson AS l
) AS avg_diff
FROM school AS sc
JOIN lesson AS l ON sc.school_id = l.school_id 
GROUP BY sc.name
UNION 
SELECT 'ALL SCHOOLS', ROUND(AVG(l.rating) ,2), '0'
	FROM lesson AS l
ORDER BY rating_avg

--2)lesson rating average by teacher
SELECT t.first_name AS teacher_name, ROUND(AVG(l.rating),2) AS rating_avg, ROUND(AVG(l.rating),2)-
(
	SELECT ROUND(AVG(l.rating) ,2)
	FROM lesson AS l
) AS avg_diff
FROM lesson AS l
JOIN teacher AS t ON l.teacher_id = t.teacher_id  
GROUP BY teacher_name 
UNION 
SELECT 'ALL TEACHERS', ROUND(AVG(l.rating) ,2), '0'
	FROM lesson AS l
ORDER BY rating_avg

--3)staff with the lowest signup percentage
SELECT staff_name,ROUND((signed/total)*100,2) as p_sign_ups
FROM 
( 
	SELECT s.first_name AS staff_name, COUNT(*)::DECIMAL total,  SUM(CASE WHEN signed = 'Y' THEN 1 ELSE 0 END) signed 
	FROM trial t 
	JOIN staff s ON t.staff_id = s.staff_id
GROUP BY s.first_name
) x
ORDER BY p_sign_ups

--4)number of students are enrolled in each school
SELECT sc.name AS school_name, COUNT (*) AS enrolled_students
FROM student AS st
JOIN school AS sc ON st.school_id = sc.school_id 
WHERE st.enrolled = 'Y'
GROUP BY school_name
ORDER BY enrolled_students

--5a)relation between rating and native speakers vs non native speakers
SELECT 'Native speaker' AS skill, CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
WHERE t.native = 'Y'
UNION 
SELECT 'Non native speaker', CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
WHERE t.native = 'N'

--5b)relation between rating and japanese speakers vs non japanese speakers
SELECT 'Japanese speaker' AS skill, CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
WHERE t.japanese_speaker = 'Y'
UNION 
SELECT 'Non Japanese speaker', CAST(AVG (l.rating) AS DECIMAL (10,2))
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
WHERE t.japanese_speaker = 'N'

--6a)highest appreciation for japanese speaker teacher by level
SELECT s.student_level AS level, CAST(AVG (l.rating) AS DECIMAL (10,2)) average_rating
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
JOIN student AS s ON l.student_id = s.student_id 
WHERE t.japanese_speaker = 'Y'
GROUP BY level
ORDER BY average_rating DESC

--6b)highest appreciation for native speaker teacher by level
SELECT s.student_level AS level, CAST(AVG (l.rating) AS DECIMAL (10,2)) average_rating
FROM lesson AS l
JOIN teacher AS t ON t.teacher_id = l.teacher_id 
JOIN student AS s ON l.student_id = s.student_id 
WHERE t.native = 'Y'
GROUP BY level
ORDER BY average_rating DESC

--7)less appreciated type of lesson
SELECT lesson_type, CAST(AVG (rating) AS DECIMAL (10,2)) AS rating_average
FROM lesson
GROUP BY lesson_type 
ORDER BY rating_average

--8)students average age of enrolled students 
SELECT sc.name, CAST(AVG(DATE_PART('year',AGE(birth_date))) AS DECIMAL(10,2)) AS age_average
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id 
WHERE st.enrolled ='Y'
GROUP BY sc.name
UNION 
SELECT 'ESL SCHOOLS', CAST(AVG(DATE_PART('year',AGE(birth_date))) AS DECIMAL(10,2)) AS age_average
FROM student 
WHERE enrolled = 'Y'
ORDER BY age_average

--9a)favorite lesson time in general
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
GROUP BY time
ORDER BY number_of_students DESC

--9b)favorite lesson time in Osaka school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id 
WHERE s.name ='ESL Osaka'
GROUP BY time
ORDER BY number_of_students DESC

--9c)favorite lesson time in Kyoto school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id 
WHERE s.name ='ESL Kyoto'
GROUP BY time
ORDER BY number_of_students DESC

--9d)favorite lesson time in Kobe school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id 
WHERE s.name ='ESL Kobe'
GROUP BY time
ORDER BY number_of_students DESC

--9e)favorite lesson time in Nara school
SELECT l.lesson_time AS time, COUNT(*) AS number_of_students
FROM lesson AS l
JOIN school AS s ON s.school_id = l.school_id 
WHERE s.name ='ESL Nara'
GROUP BY time
ORDER BY number_of_students DESC

--10a)most chosen plan by students in general
SELECT st.plan, COUNT (st.plan) AS chosen_times
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id  
WHERE st.enrolled ='Y'
GROUP BY st.plan
ORDER BY chosen_times DESC


--10b)most chosen plan by students by school
SELECT sc.name AS school_name, st.plan, COUNT (st.plan) AS chosen_times
FROM student AS st
JOIN school AS sc ON sc.school_id = st.school_id  
WHERE st.enrolled ='Y'
GROUP BY sc.name, st.plan
ORDER BY school_name, chosen_times DESC

--11a)amount of signups by month in all schools
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
WHERE t.signed = 'Y'
GROUP BY month 
ORDER BY signups DESC

--11b)amount of signups by month in Osaka school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id 
WHERE t.signed = 'Y' AND s.name ='ESL Osaka'
GROUP BY month 
ORDER BY signups DESC

--11c)amount of signups by month in Kyoto school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id 
WHERE t.signed = 'Y' AND s.name ='ESL Kyoto'
GROUP BY month 
ORDER BY signups DESC

--11d)amount of signups by month in Kobe school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id 
WHERE t.signed = 'Y' AND s.name ='ESL Kobe'
GROUP BY month 
ORDER BY signups DESC

--11e)amount of signups by month in Nara school
SELECT TO_CHAR(t.trial_date , 'MM') AS month, COUNT(*) AS signups
FROM trial AS t
JOIN school AS s ON s.school_id = t.school_id 
WHERE t.signed = 'Y' AND s.name ='ESL Nara'
GROUP BY month 
ORDER BY signups DESC

--12a)most satisfied students by gender
SELECT s.gender, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id 
GROUP BY s.gender
ORDER BY rating_average DESC

--12b)most satisfied gender by school
SELECT sc.name AS school_name, s.gender, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id 
JOIN school AS sc ON sc.school_id = l.school_id 
GROUP BY school_name, s.gender
ORDER BY school_name, rating_average DESC

--13)most satisfied students by prefecture
SELECT s.prefecture, CAST(AVG (l.rating) AS DECIMAL (10,2)) AS rating_average
FROM student AS s
JOIN lesson AS l ON s.student_id =l.student_id 
GROUP BY s.prefecture
ORDER BY rating_average DESC

--14a)students satisfaction by age range
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s 
JOIN lesson AS l ON s.student_id= l.student_id 
GROUP BY age_category 
ORDER BY rating_average DESC

--14b)students satisfaction by age range in Osaka school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s 
JOIN lesson AS l ON s.student_id= l.student_id 
JOIN school AS sc ON sc.school_id = l.school_id 
WHERE sc.name='ESL Osaka'
GROUP BY age_category 
ORDER BY rating_average DESC

--14c)students satisfaction by age range in Kyoto school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s 
JOIN lesson AS l ON s.student_id= l.student_id 
JOIN school AS sc ON sc.school_id = l.school_id 
WHERE sc.name='ESL Kyoto'
GROUP BY age_category 
ORDER BY rating_average DESC


--14d)students satisfaction by age range in Kobe school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s 
JOIN lesson AS l ON s.student_id= l.student_id 
JOIN school AS sc ON sc.school_id = l.school_id 
WHERE sc.name='ESL Kobe'
GROUP BY age_category 
ORDER BY rating_average DESC

--14e)students satisfaction by age range in Nara school
SELECT (CASE WHEN DATE_PART('year',AGE(s.birth_date)) <= 18 THEN '<= 18'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 19 AND 24 then 'between 19 and 24'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 25 AND 34 then 'between 25 and 34'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 35 AND 44 then 'between 35 and 44'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 45 AND 54 then 'between 45 and 54'
             WHEN DATE_PART('year',AGE(s.birth_date)) BETWEEN 55 AND 64 then 'between 55 and 64'
             ELSE '> 65'
        END) AS age_category,
ROUND(AVG(l.rating),2) AS rating_average
FROM student AS s 
JOIN lesson AS l ON s.student_id= l.student_id 
JOIN school AS sc ON sc.school_id = l.school_id 
WHERE sc.name='ESL Nara'
GROUP BY age_category 
ORDER BY rating_average DESC
