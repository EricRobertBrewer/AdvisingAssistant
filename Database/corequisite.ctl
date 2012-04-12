LOAD DATA
INFILE corequisite.dat
INTO TABLE Corequisite
FIELDS TERMINATED BY '|'
( DepartmentID, CourseID, CoreqDeptID, CoreqCourseID )
