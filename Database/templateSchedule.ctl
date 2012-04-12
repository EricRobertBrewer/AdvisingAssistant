LOAD DATA
INFILE templateSchedule.dat
INTO TABLE TemplateSchedule
FIELDS TERMINATED BY '|'
( TemplateID, Semester, Year, DepartmentID, CourseID, Custom )
