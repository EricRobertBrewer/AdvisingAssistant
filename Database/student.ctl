LOAD DATA
INFILE student.dat
INTO TABLE Student
FIELDS TERMINATED BY '|'
( StudentID, Name, MajorID, StartSemester, StartYear )
