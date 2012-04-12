LOAD DATA
INFILE prerequisite.dat
INTO TABLE Prerequisite
FIELDS TERMINATED BY '|'
( DepartmentID, CourseID, PrereqDeptID, PrereqCourseID )
