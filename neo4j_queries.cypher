// Student Deadline and Academic Overload Tracker
// Neo4j: nodes, relationships and queries

// Nodes
CREATE
(:Student {student_id: 1, student_name: 'Arun', age: 20}),
(:Student {student_id: 2, student_name: 'Meena', age: 21}),
(:Student {student_id: 3, student_name: 'Divya', age: 22}),
(:Student {student_id: 4, student_name: 'Karthik', age: 20});

CREATE
(:Course {course_id: 101, course_name: 'DBMS', category: 'Core'}),
(:Course {course_id: 102, course_name: 'Operating Systems', category: 'Core'}),
(:Course {course_id: 103, course_name: 'Machine Learning', category: 'Elective'}),
(:Course {course_id: 104, course_name: 'Web Technology Lab', category: 'Lab'});

CREATE
(:Faculty {faculty_id: 201, faculty_name: 'Dr. Kumar', department: 'Computer Science'}),
(:Faculty {faculty_id: 202, faculty_name: 'Dr. Priya', department: 'Information Tech'}),
(:Faculty {faculty_id: 203, faculty_name: 'Dr. Ravi', department: 'Mathematics'});

CREATE
(:Assignment {assignment_id: 301, assignment_title: 'DBMS Mini Project', issue_date: '2026-10-05', due_date: '2026-10-30', workload_hours: 12}),
(:Assignment {assignment_id: 302, assignment_title: 'OS Lab Record', issue_date: '2026-10-12', due_date: '2026-10-27', workload_hours: 6}),
(:Assignment {assignment_id: 303, assignment_title: 'ML Case Study', issue_date: '2026-10-15', due_date: '2026-11-05', workload_hours: 10}),
(:Assignment {assignment_id: 304, assignment_title: 'SQL Assignment', issue_date: '2026-10-18', due_date: '2026-10-26', workload_hours: 4});

// Relationships
UNWIND [[1,101],[1,102],[2,103],[2,104],[3,101],[3,103],[4,102]] AS pair
MATCH (s:Student {student_id: pair[0]}), (c:Course {course_id: pair[1]})
CREATE (s)-[:ENROLLED_IN]->(c);

UNWIND [[1,301],[1,302],[2,303],[3,304]] AS pair
MATCH (s:Student {student_id: pair[0]}), (a:Assignment {assignment_id: pair[1]})
CREATE (s)-[:HAS_DEADLINE]->(a);

UNWIND [[301,201],[302,202],[303,203],[304,201]] AS pair
MATCH (a:Assignment {assignment_id: pair[0]}), (f:Faculty {faculty_id: pair[1]})
CREATE (a)-[:ASSIGNED_BY]->(f);

// Queries
MATCH (s:Student)-[:ENROLLED_IN]->(c:Course) RETURN s, c;
MATCH (s:Student)-[r:HAS_DEADLINE]->(a:Assignment) RETURN s, r, a;
MATCH (s:Student)-[:HAS_DEADLINE]->(a:Assignment)-[:ASSIGNED_BY]->(f:Faculty) RETURN s, a, f;
MATCH (n)-[r]->(m) RETURN n, r, m;

// Overload detection (more than 15 hours)
MATCH (s:Student)-[:HAS_DEADLINE]->(a:Assignment)
WITH s, SUM(a.workload_hours) AS total_hours
WHERE total_hours > 15
RETURN s.student_name AS student, total_hours;
