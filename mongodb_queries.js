// Student Deadline and Academic Overload Tracker
// MongoDB: database student_deadline_db, collection students

use('student_deadline_db');

// Insert
db.students.insertMany([
  {student_id: 1, student_name: 'Arun', age: 20,
   courses: [{course_id: 101, course_name: 'DBMS', category: 'Core'},
             {course_id: 102, course_name: 'Operating Systems', category: 'Core'}],
   assignments: [{assignment_id: 301, assignment_title: 'DBMS Mini Project', issue_date: '2026-10-05', due_date: '2026-10-30', workload_hours: 12, faculty_id: 201},
                 {assignment_id: 302, assignment_title: 'OS Lab Record', issue_date: '2026-10-12', due_date: '2026-10-27', workload_hours: 6, faculty_id: 202}]},
  {student_id: 2, student_name: 'Meena', age: 21,
   courses: [{course_id: 103, course_name: 'Machine Learning', category: 'Elective'},
             {course_id: 104, course_name: 'Web Technology Lab', category: 'Lab'}],
   assignments: [{assignment_id: 303, assignment_title: 'ML Case Study', issue_date: '2026-10-15', due_date: '2026-11-05', workload_hours: 10, faculty_id: 203}]},
  {student_id: 3, student_name: 'Divya', age: 22,
   courses: [{course_id: 101, course_name: 'DBMS', category: 'Core'},
             {course_id: 103, course_name: 'Machine Learning', category: 'Elective'}],
   assignments: [{assignment_id: 304, assignment_title: 'SQL Assignment', issue_date: '2026-10-18', due_date: '2026-10-26', workload_hours: 4, faculty_id: 201}]},
  {student_id: 4, student_name: 'Karthik', age: 20,
   courses: [{course_id: 102, course_name: 'Operating Systems', category: 'Core'}],
   assignments: []}
]);

// Read
db.students.find({student_id: 1});
db.students.find({'courses.course_name': 'DBMS'});
db.students.find({'courses.category': 'Core'});

// Update
db.students.updateOne({student_id: 2}, {$set: {age: 22}});

// Delete (insert a test record, then remove it)
db.students.insertOne({student_id: 5, student_name: 'Nisha', age: 21, courses: [], assignments: []});
db.students.deleteOne({student_id: 5});

// Sort, limit, filter
db.students.find().sort({age: 1});
db.students.find().sort({age: -1});
db.students.find().limit(2);
db.students.find({age: {$gt: 20}});

// Overload detection (more than 15 hours)
db.students.aggregate([
  {$project: {student_name: 1, total_hours: {$sum: '$assignments.workload_hours'}}},
  {$match: {total_hours: {$gt: 15}}}
]);