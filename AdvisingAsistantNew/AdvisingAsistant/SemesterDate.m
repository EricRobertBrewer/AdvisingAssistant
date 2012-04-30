//
//  Semester.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/7/12.
//  Copyright (c) 2012 Humanity All rights reserved.
//

#import "SemesterDate.h"

SemesterDate SemesterDateMake(Season season, int year) {
	SemesterDate s;
	s.season = season;
	s.year = year;
	return s;
}

BOOL SemesterDateEqual(SemesterDate d1, SemesterDate d2) {
	return d1.season == d2.season && d1.year == d2.year;
}

NSString *FormatSeason(Season s) {
	return (s == SeasonFall) ? @"Fall" : @"Spring";
}
NSString *FormatSemesterDate(SemesterDate d) {
	NSString *season = FormatSeason(d.season);
	return [NSString stringWithFormat:@"%@ %i", season, d.year];
}

SemesterDate SemesterDateNow(void) {
    return SemesterDateMake(SeasonSpring, 2012);
}

SemesterDate SemesterDatePrevious(SemesterDate d) {
    if (d.season == SeasonFall) {
        return SemesterDateMake(SeasonSpring, d.year);
    } else {
        return SemesterDateMake(SeasonFall, d.year-1);
    }
}

BOOL SemesterDateGreaterThan(SemesterDate d1, SemesterDate d2) {
    if (d1.year > d2.year) return true;
    if (d1.year == d2.year) {
        if (d1.season == SeasonFall && d2.season == SeasonSpring) return true;
    }
    return false;
}