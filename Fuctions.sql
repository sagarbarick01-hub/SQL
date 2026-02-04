#Question 1 : Create a ranking of students based on score (highest first).

create DATABASE data_db;
use data_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    score INT,
    attendance INT,
    course VARCHAR(50),
    join_date DATE,
    city VARCHAR(50)
);
INSERT INTO students VALUES
(1, 'Rahul', 95, 90, 'SQL', '2023-06-15', 'Mumbai'),
(2, 'Amit', 88, 85, 'Python', '2023-07-10', 'Delhi'),
(3, 'Neha', 88, 92, 'SQL', '2023-05-20', 'Mumbai'),
(4, 'Priya', 75, 80, 'Java', '2023-08-01', 'Chennai'),
(5, 'Karan', 60, 70, 'Python', '2023-09-12', 'Pune');
SELECT * FROM students;
SELECT
    student_id,
    student_name,
    score,
    RANK() OVER (ORDER BY score DESC) AS score_rank
FROM students;

#Question 2 : Show each student's score and the previous student’s score (based on score order).

SELECT
    student_id,
    student_name,
    score,
    LAG(score) OVER (ORDER BY score DESC) AS previous_score
FROM students;

#Question 3 : Convert all student names to uppercase and extract the month name from join_date.

SELECT
    student_id,
    UPPER(student_name) AS student_name_upper,
    MONTHNAME(join_date) AS join_month
FROM students;

#Question 4 : Show each student's name and the next student’s attendance (ordered by attendance).

SELECT
    student_name,
    attendance,
    LEAD(attendance) OVER (ORDER BY attendance) AS next_student_attendance
FROM students;

#Question 5 : Assign students into 4 performance groups using NTILE().

SELECT
    student_id,
    student_name,
    score,
    NTILE(4) OVER (ORDER BY score DESC) AS performance_group
FROM students;

# Question 6 : For each course, assign a row number based on attendance (highest first).

SELECT
    student_id,
    student_name,
    course,
    attendance,
    ROW_NUMBER() OVER (
        PARTITION BY course
        ORDER BY attendance DESC
    ) AS row_num
FROM students;

#Question 7 : Calculate the number of days each student has been enrolled (from join_date to today).

SELECT
    student_id,
    student_name,
    join_date,
    DATEDIFF('2025-01-01', join_date) AS days_enrolled
FROM students;
 
 #  Question 8 : Format join_date as “Month Year” (e.g., “June 2023”).
 
 (2023-06-15)
 (June 2023)
DATE_FORMAT(date, format)
SELECT
    student_id,
    student_name,
    join_date,
    DATE_FORMAT(join_date, '%M %Y') AS formatted_join_date
FROM students;

#Question 9 : Replace the city ‘Mumbai’ with ‘MUM’ for display purposes

SELECT
    student_id,
    student_name,
    city,
    CASE
        WHEN city = 'Mumbai' THEN 'MUM'
        ELSE city
    END AS display_city
FROM students;

#Question 10 : For each course, find the highest score using FIRST_VALUE().

SELECT
    student_id,
    student_name,
    course,
    score,
    FIRST_VALUE(score) OVER (
        PARTITION BY course
        ORDER BY score DESC
    ) AS highest_score_in_course
FROM students;














