LOAD DATA
INFILE gradRequirement.ctl
INTO TABLE GradRequirement
FIELDS TERMINATED BY '|'
( MajorID, Area, Units, StartSemester, StartYear, EndSemester, EndYear )
