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
} SemesterDate;

SemesterDate SemesterDateMake(Season season, int year);
SemesterDate SemesterDateNow(void);
BOOL SemesterDateEqual(SemesterDate d1, SemesterDate d2);

NSString *FormatSeason(Season s);
NSString *FormatSemesterDate(SemesterDate d);