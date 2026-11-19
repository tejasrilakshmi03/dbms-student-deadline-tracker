-- Student Deadline and Academic Overload Tracker
-- Run schema_and_data.sql first.

-- ALTER examples
ALTER TABLE Student ADD email VARCHAR(20);
ALTER TABLE Student MODIFY student_name VARCHAR(20);
ALTER TABLE Student DROP COLUMN email;

-- SELECT
SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Faculty;
SELECT * FROM Student_Course;
SELECT * FROM Assignment;

-- UPDATE
UPDATE Student SET age = 21 WHERE student_id = 1;
UPDATE Course SET category = 'Open Elective' WHERE course_id = 103;

-- DELETE (child records first, because of the foreign keys)
DELETE FROM Assignment WHERE assignment_id = 305;
DELETE FROM Student_Course WHERE student_id = 4;
DELETE FROM Student WHERE student_id = 4;

-- JOIN queries
-- 1. INNER JOIN: students and their courses
SELECT s.student_id, s.student_name, c.course_name
FROM Student s
INNER JOIN Student_Course sc ON s.student_id = sc.student_id
INNER JOIN Course c ON sc.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

-- 2. LEFT JOIN
SELECT s.student_name, c.course_name
FROM Student s
LEFT JOIN Student_Course sc ON s.student_id = sc.student_id
LEFT JOIN Course c ON sc.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

-- 3. RIGHT JOIN
SELECT s.student_name, c.course_name
FROM Student s
INNER JOIN Student_Course sc ON s.student_id = sc.student_id
RIGHT JOIN Course c ON sc.course_id = c.course_id
ORDER BY c.course_id, s.student_id;

-- 4. Assignments and faculty
SELECT a.assignment_title, f.faculty_name, f.department
FROM Assignment a
INNER JOIN Faculty f ON a.faculty_id = f.faculty_id;

-- 5. Students, courses and category
SELECT s.student_name, c.course_name, c.category
FROM Student s
JOIN Student_Course sc ON s.student_id = sc.student_id
JOIN Course c ON sc.course_id = c.course_id
ORDER BY s.student_id, c.course_id;

-- 6. Academic overload detection (more than 15 hours)
SELECT s.student_name, SUM(a.workload_hours) AS total_hours
FROM Student s
JOIN Assignment a ON s.student_id = a.student_id
GROUP BY s.student_name
HAVING SUM(a.workload_hours) > 15;

-- 7. Approaching deadlines (within 7 days of 2026-10-25)
SELECT s.student_name, a.assignment_title, a.due_date
FROM Student s
JOIN Assignment a ON s.student_id = a.student_id
WHERE a.due_date BETWEEN '2026-10-25' AND DATE_ADD('2026-10-25', INTERVAL 7 DAY)
ORDER BY a.due_date;

-- NESTED queries
-- 1. Above-average workload
SELECT assignment_title, workload_hours FROM Assignment
WHERE workload_hours > (SELECT AVG(workload_hours) FROM Assignment);

-- 2. Maximum workload
SELECT assignment_title, workload_hours FROM Assignment
WHERE workload_hours = (SELECT MAX(workload_hours) FROM Assignment);

-- 3. Students enrolled in DBMS
SELECT student_name FROM Student
WHERE student_id IN (
  SELECT student_id FROM Student_Course
  WHERE course_id = (SELECT course_id FROM Course WHERE course_name = 'DBMS')
);

-- 4. Assignments given by Dr. Kumar
SELECT assignment_title FROM Assignment
WHERE faculty_id = (SELECT faculty_id FROM Faculty WHERE faculty_name = 'Dr. Kumar');

-- 5. Assignments due before the DBMS Mini Project
SELECT assignment_title, due_date FROM Assignment
WHERE due_date < (SELECT due_date FROM Assignment WHERE assignment_title = 'DBMS Mini Project');

-- 6. Students older than Meena
SELECT student_name, age FROM Student
WHERE age > (SELECT age FROM Student WHERE student_name = 'Meena');

-- 7. Courses that have enrolled students
SELECT course_name FROM Course
WHERE course_id IN (SELECT course_id FROM Student_Course);
