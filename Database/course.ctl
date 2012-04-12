LOAD DATA
INFILE course.dat
INTO TABLE Course
FIELDS TERMINATED BY '|'
( DepartmentID, CourseID, Name, Description, Semester, Units )
