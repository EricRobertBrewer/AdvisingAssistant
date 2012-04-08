//
//  Semester.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

typedef enum _Season {
	SeasonFall,
	SeasonSpring
} Season;

typedef struct _Semester {
	Season season;
	int year;
} Semester;

Semester SemesterMake(Season season, int year);