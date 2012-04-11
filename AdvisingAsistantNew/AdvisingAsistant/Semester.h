//
//  Semester.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

typedef enum {
	SeasonFall,
	SeasonSpring
} Season;

typedef struct {
	Season season;
	int year;
} Semester;

Semester SemesterMake(Season season, int year);