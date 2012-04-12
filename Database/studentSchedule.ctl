LOAD DATA
INFILE studentSchedule.dat
INTO TABLE StudentSchedule
FIELDS TERMINATED BY '|'
( StudentID, Semester, Year, DepartmentID, CourseID, Custom )
