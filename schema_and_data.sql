-- Student Deadline and Academic Overload Tracker
-- MySQL: table creation and sample data

CREATE DATABASE IF NOT EXISTS deadline_tracker;
USE deadline_tracker;

CREATE TABLE Student(
  student_id INT PRIMARY KEY,
  student_name VARCHAR(15) NOT NULL,
  age INT
);

CREATE TABLE Course(
  course_id INT PRIMARY KEY,
  course_name VARCHAR(20),
  category VARCHAR(20)
);

CREATE TABLE Faculty(
  faculty_id INT PRIMARY KEY,
  faculty_name VARCHAR(20),
  department VARCHAR(30)
);

CREATE TABLE Student_Course(
  student_id INT,
  course_id INT,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Assignment(
  assignment_id INT PRIMARY KEY,
  student_id INT,
  faculty_id INT,
  assignment_title VARCHAR(30),
  issue_date DATE,
  due_date DATE,
  workload_hours INT,
  FOREIGN KEY (student_id) REFERENCES Student(student_id),
  FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

INSERT INTO Student(student_id, student_name, age) VALUES
(1, 'Arun', 20),
(2, 'Meena', 21),
(3, 'Divya', 22),
(4, 'Karthik', 20);

INSERT INTO Course(course_id, course_name, category) VALUES
(101, 'DBMS', 'Core'),
(102, 'Operating Systems', 'Core'),
(103, 'Machine Learning', 'Elective'),
(104, 'Web Technology Lab', 'Lab');

INSERT INTO Faculty(faculty_id, faculty_name, department) VALUES
(201, 'Dr. Kumar', 'Computer Science'),
(202, 'Dr. Priya', 'Information Tech'),
(203, 'Dr. Ravi', 'Mathematics');

INSERT INTO Student_Course(student_id, course_id) VALUES
(1, 101), (1, 102),
(2, 103), (2, 104),
(3, 101), (3, 103),
(4, 102);

INSERT INTO Assignment
(assignment_id, student_id, faculty_id, assignment_title, issue_date, due_date, workload_hours)
VALUES
(301, 1, 201, 'DBMS Mini Project', '2026-10-05', '2026-10-30', 12),
(302, 1, 202, 'OS Lab Record', '2026-10-12', '2026-10-27', 6),
(303, 2, 203, 'ML Case Study', '2026-10-15', '2026-11-05', 10),
(304, 3, 201, 'SQL Assignment', '2026-10-18', '2026-10-26', 4),
(305, 4, 202, 'Web Lab Report', '2026-10-20', '2026-11-02', 5);
