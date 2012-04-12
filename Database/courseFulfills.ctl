LOAD DATA
INFILE courseFulfills.dat
INTO TABLE CourseFulfills
FIELDS TERMINATED BY '|'
( DepartmentID, CourseID, Area, StartSemester, StartYear, EndSemester, EndYear )
