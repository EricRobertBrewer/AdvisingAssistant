LOAD DATA
INFILE advisor.dat
INTO TABLE Advisor
FIELDS TERMINATED BY '|'
( Username, Password )
