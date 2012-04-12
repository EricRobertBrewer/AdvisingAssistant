LOAD DATA
INFILE template.dat
INTO TABLE Template
FIELDS TERMINATED BY '|'
( TemplateID, Name, DepartmentID )
