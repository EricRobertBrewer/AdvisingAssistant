LOAD DATA
INFILE major.dat
INTO TABLE Major
FIELDS TERMINATED BY '|'
( MajorID, DepartmentID, Name )
