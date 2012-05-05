-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 04, 2012 at 05:49 PM
-- Server version: 5.1.62
-- PHP Version: 5.3.2-1ubuntu4.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ebrewer`
--

-- --------------------------------------------------------

--
-- Table structure for table `Advisor`
--

CREATE TABLE IF NOT EXISTS `Advisor` (
  `Username` varchar(30) NOT NULL,
  `Password` varchar(100) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Corequisite`
--

CREATE TABLE IF NOT EXISTS `Corequisite` (
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `CoreqDeptID` varchar(6) NOT NULL,
  `CoreqCourseID` varchar(15) NOT NULL,
  PRIMARY KEY (`DepartmentID`,`CourseID`,`CoreqDeptID`,`CoreqCourseID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE IF NOT EXISTS `Course` (
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Description` text,
  `Semester` char(1) DEFAULT NULL,
  `Units` int(11) DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`,`CourseID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `CourseFulfills`
--

CREATE TABLE IF NOT EXISTS `CourseFulfills` (
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `Area` varchar(30) NOT NULL,
  `StartSemester` char(1) NOT NULL DEFAULT '',
  `StartYear` int(11) NOT NULL,
  `EndSemester` char(1) NOT NULL DEFAULT '',
  `EndYear` int(11) NOT NULL,
  PRIMARY KEY (`DepartmentID`,`CourseID`,`Area`,`StartSemester`,`StartYear`,`EndSemester`,`EndYear`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE IF NOT EXISTS `Department` (
  `DepartmentID` varchar(6) NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `GEArea`
--

CREATE TABLE IF NOT EXISTS `GEArea` (
  `Pattern` varchar(30) NOT NULL DEFAULT '',
  `Area` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`Pattern`,`Area`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `GradRequirement`
--

CREATE TABLE IF NOT EXISTS `GradRequirement` (
  `Area` varchar(30) NOT NULL,
  `ParentArea` varchar(30) NOT NULL DEFAULT 'none',
  `Title` varchar(30) NOT NULL,
  `Units` int(11) NOT NULL,
  `StartSemester` char(1) NOT NULL DEFAULT '',
  `StartYear` int(11) NOT NULL,
  `EndSemester` char(1) NOT NULL DEFAULT '',
  `EndYear` int(11) NOT NULL,
  PRIMARY KEY (`Area`,`StartSemester`,`StartYear`,`EndSemester`,`EndYear`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Major`
--

CREATE TABLE IF NOT EXISTS `Major` (
  `MajorID` int(11) NOT NULL AUTO_INCREMENT,
  `DepartmentID` varchar(6) NOT NULL,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`MajorID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `MajorArea`
--

CREATE TABLE IF NOT EXISTS `MajorArea` (
  `MajorID` int(11) NOT NULL,
  `Area` varchar(30) NOT NULL,
  PRIMARY KEY (`MajorID`,`Area`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Prerequisite`
--

CREATE TABLE IF NOT EXISTS `Prerequisite` (
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `PrereqDeptID` varchar(6) NOT NULL,
  `PrereqCourseID` varchar(15) NOT NULL,
  PRIMARY KEY (`DepartmentID`,`CourseID`,`PrereqDeptID`,`PrereqCourseID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE IF NOT EXISTS `Student` (
  `StudentID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `StartSemester` char(1) DEFAULT NULL,
  `StartYear` int(11) NOT NULL,
  `Pattern` varchar(30) NOT NULL,
  PRIMARY KEY (`StudentID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `StudentSchedule`
--

CREATE TABLE IF NOT EXISTS `StudentSchedule` (
  `StudentID` varchar(10) NOT NULL,
  `Semester` char(1) NOT NULL DEFAULT '',
  `Year` int(11) NOT NULL,
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `Custom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`StudentID`,`Semester`,`Year`,`DepartmentID`,`CourseID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Template`
--

CREATE TABLE IF NOT EXISTS `Template` (
  `TemplateID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `DepartmentID` varchar(6) NOT NULL,
  `Pattern` varchar(30) NOT NULL,
  PRIMARY KEY (`TemplateID`),
  UNIQUE KEY `Name` (`Name`,`DepartmentID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `TemplateSchedule`
--

CREATE TABLE IF NOT EXISTS `TemplateSchedule` (
  `TemplateID` int(11) NOT NULL,
  `Semester` char(1) NOT NULL DEFAULT '',
  `Year` int(11) NOT NULL,
  `DepartmentID` varchar(6) NOT NULL,
  `CourseID` varchar(15) NOT NULL,
  `Custom` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TemplateID`,`Semester`,`Year`,`DepartmentID`,`CourseID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
