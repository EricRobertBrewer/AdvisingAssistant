LOAD DATA
INFILE department.ctl
INTO TABLE Department
FIELDS TERMINATED BY '|'
( DepartmentID, Name )
