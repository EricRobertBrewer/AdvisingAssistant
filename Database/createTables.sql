--------------------------------------------
-- createTables.sql
-- Eric Brewer
-- Ryan Shaul
-- 4/11/12
-- CS470 - Advanced Software Design Project
-- Kooshesh & Schettler
-- Tables for AdvisingAssistant Database - 
-- 
--------------------------------------------

DROP TABLE Student;
CREATE TABLE Student(
	ID		VARCHAR2( 10 ) NOT NULL,
	Name		VARCHAR2( 50 ) NOT NULL,
	MajorID		INT,
	StartSemester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	StartYear	YEAR NOT NULL,
	PRIMARY KEY( ID )
);

DROP TABLE Template;
CREATE TABLE Template(
	ID		INT NOT NULL AUTO_INCREMENT,
	Name		VARCHAR2( 20 ) NOT NULL,
	DepartmentID	VARCHAR2( 6 ) NOT NULL,
	PRIMARY KEY( ID )
);

DROP TABLE StudentSchedule;
CREATE TABLE StudentSchedule(
	StudentID	VARCHAR2( 10 ) NOT NULL,
	Semester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	Year		YEAR NOT NULL,
	CourseID	VARCHAR2( 15 ) NOT NULL,
	Custom		VARCHAR2( 50 ),
	PRIMARY KEY( StudentID, Semester, Year, CourseID, Custom )
);

DROP TABLE TemplateSchedule;
CREATE TABLE TemplateSchedule(
	TemplateID	INT NOT NULL,
	Semester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	Year		INT NOT NULL,
	CourseID	VARCHAR2( 15 ) NOT NULL,
	Custom		VARCHAR2( 50 ),
	PRIMARY KEY( TemplateID, Semester, Year, CourseID, Custom )
);

DROP TABLE Course
CREATE TABLE Course(
	ID		VARCHAR2( 15 ) NOT NULL,
	DepartmentID	VARCHAR2( 6 ) NOT NULL,
	Name		VARCHAR2( 20 ) NOT NULL,
	Description	TEXT,
	Semester	CHAR( 1 ) CHECK( Semester = 'F' OR Semester = 'S' OR Semester = 'B' ),
	Units		INT,
	PRIMARY KEY( ID )
);

DROP TABLE Prerequisite;
CREATE TABLE Prerequisite(
	CourseID	VARCHAR2( 15 ) NOT NULL,
	PrerequisiteID	VARCHAR2( 15 ) NOT NULL,
	PRIMARY KEY( CourseID, PrerequisiteID )
);

DROP TABLE Corequisite;
CREATE TABLE Corequisite(
	CourseID	VARCHAR2( 15 ) NOT NULL,
	CorequisiteID	VARCHAR2( 15 ) NOT NULL,
	PRIMARY KEY( CourseID, CorequisiteID )
);

DROP TABLE CourseFulfills;
CREATE TABLE CourseFulfills(
	CourseID	VARCHAR2( 15 ) NOT NULL,
	Area		VARCHAR2( 30 ) NOT NULL,
	StartDate	DATE,
	EndDate		DATE,
	PRIMARY KEY( CourseID, Area, StartDate, EndDate )
);

DROP TABLE GradRequirement;
CREATE TABLE GradRequirement(
	MajorID		INT NOT NULL,
	Area		VARCHAR2( 30 ) NOT NULL,
--	UnitsRequired	INT NOT NULL,
	StartDate	DATE,
	EndDate		DATE,
	PRIMARY KEY( MajorID, Area, StartDate, EndDate )
);

DROP TABLE Department;
CREATE TABLE Department(
	ID		VARCHAR2( 6 ) NOT NULL,
	Name		VARCHAR2( 20 ) NOT NULL,
	PRIMARY KEY( ID )
);

DROP TABLE Major;
CREATE TABLE Major(
	ID		INT NOT NULL AUTO_INCREMENT,
	DepartmentID	VARCHAR2( 6 ) NOT NULL,
	Name		VARCHAR2( 20 ) NOT NULL,
	PRIMARY KEY( ID )
);

DROP TABLE AdvisorLogin;
CREATE TABLE AdvisorLogin(
	Username	VARCHAR2( 30 ) NOT NULL,
	Password	VARCHAR2( 100 ) NOT NULL,
	PRIMARY KEY( Username )
);
