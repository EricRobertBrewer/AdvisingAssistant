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
	StudentID	VARCHAR( 10 ) NOT NULL,
	Name		VARCHAR( 50 ) NOT NULL,
	MajorID		INT,
	StartSemester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	StartYear	INT NOT NULL,
	PRIMARY KEY( StudentID )
);

DROP TABLE Template;
CREATE TABLE Template(
	TemplateID	INT NOT NULL AUTO_INCREMENT,
	Name		VARCHAR( 50 ) NOT NULL,
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	PRIMARY KEY( TemplateID )
);

DROP TABLE StudentSchedule;
CREATE TABLE StudentSchedule(
	StudentID	VARCHAR( 10 ) NOT NULL,
	Semester	CHAR( 1 ) CHECK( Semester = 'F' OR Semester = 'S' ),
	Year		INT NOT NULL,
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	Custom		VARCHAR( 80 ),
	PRIMARY KEY( StudentID, Semester, Year, DepartmentID, CourseID, Custom )
);

DROP TABLE TemplateSchedule;
CREATE TABLE TemplateSchedule(
	TemplateID	INT NOT NULL,
	Semester	CHAR( 1 ) CHECK( Semester = 'F' OR Semester = 'S' ),
	Year		INT NOT NULL,
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	Custom		VARCHAR( 80 ),
	PRIMARY KEY( TemplateID, Semester, Year, DepartmentID, CourseID, Custom )
);

DROP TABLE Course;
CREATE TABLE Course(
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	Name		VARCHAR( 50 ) NOT NULL,
	Description	TEXT,
	Semester	CHAR( 1 ) CHECK( Semester = 'F' OR Semester = 'S' OR Semester = 'B' ),
	Units		INT,
	PRIMARY KEY( DepartmentID, CourseID )
);

DROP TABLE Prerequisite;
CREATE TABLE Prerequisite(
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	PrereqDeptID	VARCHAR( 6 ) NOT NULL,
	PrereqCourseID	VARCHAR( 15 ) NOT NULL,
	PRIMARY KEY( DepartmentID, CourseID, PrereqDeptID, PrereqCourseID )
);

DROP TABLE Corequisite;
CREATE TABLE Corequisite(
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	CoreqDeptID	VARCHAR( 6 ) NOT NULL,
	CoreqCourseID	VARCHAR( 15 ) NOT NULL,
	PRIMARY KEY( DepartmentID, CourseID, CoreqDeptID, CoreqCourseID )
);

DROP TABLE CourseFulfills;
CREATE TABLE CourseFulfills(
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	CourseID	VARCHAR( 15 ) NOT NULL,
	Area		VARCHAR( 30 ) NOT NULL,
	StartSemester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	StartYear	INT NOT NULL,
	EndSemester	CHAR( 1 ) CHECK( EndSemester = 'F' OR EndSemester = 'S' ),
	EndYear		INT NOT NULL,
	PRIMARY KEY( DepartmentID, CourseID, Area, StartSemester, StartYear, EndSemester, EndYear )
);

DROP TABLE GradRequirement;
CREATE TABLE GradRequirement(
	MajorID		INT NOT NULL,
	Area		VARCHAR( 30 ) NOT NULL,
	Units		INT NOT NULL,
	StartSemester	CHAR( 1 ) CHECK( StartSemester = 'F' OR StartSemester = 'S' ),
	StartYear	INT NOT NULL,
	EndSemester	CHAR( 1 ) CHECK( EndSemester = 'F' OR EndSemester = 'S' ),
	EndYear		INT NOT NULL,
	PRIMARY KEY( MajorID, Area, StartSemester, StartYear, EndSemester, EndYear )
);

DROP TABLE Department;
CREATE TABLE Department(
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	Name		VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY( DepartmentID )
);

DROP TABLE Major;
CREATE TABLE Major(
	MajorID		INT NOT NULL AUTO_INCREMENT,
	DepartmentID	VARCHAR( 6 ) NOT NULL,
	Name		VARCHAR( 50 ) NOT NULL,
	PRIMARY KEY( MajorID )
);

DROP TABLE Advisor;
CREATE TABLE Advisor(
	Username	VARCHAR( 30 ) NOT NULL,
	Password	VARCHAR( 100 ) NOT NULL,
	PRIMARY KEY( Username )
);
