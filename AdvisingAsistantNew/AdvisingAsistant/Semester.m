//
//  Semester.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "Semester.h"

Semester SemesterMake(Season season, int year) {
	Semester s;
	s.season = season;
	s.year = year;
	return s;
}