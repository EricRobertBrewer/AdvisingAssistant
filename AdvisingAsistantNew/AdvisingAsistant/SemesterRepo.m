//
//  ScheduleRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "SemesterRepo.h"
#import "DepartmentRepo.h"
#import "CourseRepo.h"

static SemesterRepo *instance = nil;

@implementation SemesterRepo

/*
	SERIALIZING TO/FROM DICTIONARIES
*/

-(SemesterDate)semesterDateFromDict:(NSDictionary *)dict {
	Season season = [[dict objectForKey:@"Semester"] isEqualToString:@"F"] ? SeasonFall : SeasonSpring;
	int year = [[dict objectForKey:@"Year"] intValue];
	return SemesterDateMake(season, year);
}
-(NSMutableDictionary *)dictForSemesterDate:(SemesterDate)date {
	NSString *season = (date.season == SeasonFall) ? @"F" : @"S";
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setValue:season forKey:@"Semester"];
	[dict setInt:date.year forKey:@"Year"];
	return dict;
}

-(Course*)courseFromDict:(NSDictionary *)dict {
	NSString *code = [dict objectForKey:@"DepartmentID"];
	Department *department = [[DepartmentRepo defaultRepo] departmentWithCode:code];
	NSString *number = [dict objectForKey:@"CourseID"];
	Course *course = [[CourseRepo defaultRepo] courseWithDepartment:department andNumber:number];
	
	id custom = [dict objectForKey:@"Custom"];
	if (custom && custom != [NSNull null] && [custom length] > 0) {
		course.customName = custom;
	}

	return course;
}

-(NSMutableDictionary *)dictForCourse:(Course *)course {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setValue:course.department.code forKey:@"DepartmentID"];
	[dict setValue:course.number forKey:@"CourseID"];
	if (course.customName) {
		[dict setValue:course.customName forKey:@"Custom"];
	}
	return dict;
}

/*
	GETTING SEMESTERS
*/


-(Semester *)semesterForDate:(SemesterDate)date inArray:(NSMutableArray *)semesters {
	for (Semester *semester in semesters) {
		if (SemesterDateEqual(date, semester.date)) return semester;
	}
	Semester *newSemester = [[Semester alloc] init];
	newSemester.date = date;
	[semesters addObject:newSemester];
	return [newSemester autorelease];
}

// The schedule comes from the server as a single flat list.
// We group the courses by (Semester,Year) here
// And make sure we return them in a normalized fashion
-(NSArray *)semestersFromDicts:(NSArray *)dicts startDate:(SemesterDate)start {
	NSMutableArray *normal = [NSMutableArray array];
	
	// Start with initial 4 semesters
	for (int i=0; i < 4; i++) {
		Semester *semester = [[Semester alloc] init];
		Season season = (i % 2 == 0) ? SeasonFall : SeasonSpring;
		int year = start.year + (i/2);
		semester.date = SemesterDateMake(season, year);
		[normal addObject:semester];
		[semester release];
	}
	
	// Add courses
	for (NSDictionary *dict in dicts) {
		SemesterDate date = [self semesterDateFromDict:dict];
		Semester *semester = [self semesterForDate:date inArray:normal];
		[semester.courses addObject:[self courseFromDict:dict]];
	}
	
	// Fill in any gaps with blank semesters
	for (int i=0; i < normal.count; i++) {
		Semester *semester = [normal objectAtIndex:i];
		if (semester.date.season == SeasonSpring && i % 2 == 0) {
			Semester *blankFall = [[Semester alloc] init];
			blankFall.date = SemesterDateMake(SeasonFall, semester.date.year-1);
			[normal insertObject:blankFall atIndex:i];
			[blankFall release];
		} else if (semester.date.season == SeasonFall && i % 2 == 1) {
			Semester *blankSpring = [[Semester alloc] init];
			blankSpring.date = SemesterDateMake(SeasonSpring, semester.date.year+1);
			[normal insertObject:blankSpring atIndex:i];
			[blankSpring release];
		}
	}
	
	// Make sure we end with spring and not fall
	if (normal.count % 2 == 1) {
		Semester *lastSemester = [normal objectAtIndex:(normal.count-1)];
		//assert(lastSemester.date.season == SeasonFall);
		Semester *blankSpring = [[Semester alloc] init];
		blankSpring.date = SemesterDateMake(SeasonSpring, lastSemester.date.year+1);
		[normal addObject:blankSpring];
		[blankSpring release];
	}

	return normal;
}

-(NSArray*)semestersForStudent:(Student*)student {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getStudentSchedule.php"];
	[options.postData setInt:student.id forKey:@"StudentID"];
	return [self semestersFromDicts:[self connect:options] startDate:student.started];
}

-(NSArray*)semestersForTemplate:(Template*)template {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getTemplateSchedule.php"];
	[options.postData setInt:template.id forKey:@"TemplateID"];
	SemesterDate start = SemesterDateMake(SeasonFall, 0);
	return [self semestersFromDicts:[self connect:options] startDate:start];
}



/*
	SAVING SEMESTERS
*/

-(BOOL)deleteSemestersForStudent:(Student *)student {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"deleteStudentSchedule.php"];
	[options.postData setInt:student.id forKey:@"StudentID"];
	return [self connect:options] != nil;
}

-(BOOL)deleteSemestersForTemplate:(Template *)template {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"deleteTemplateSchedule.php"];
	[options.postData setInt:template.id forKey:@"TemplateID"];
	return [self connect:options] != nil;
}

-(void)saveSemesters:(NSArray *)semesters withOptions:(ConnectOptions *)options {
	for (Semester *semester in semesters) {
		NSDictionary *semesterDate = [self dictForSemesterDate:semester.date];
		for (Course *course in semester.courses) {
			ConnectOptions *localOptions = [ConnectOptions optionsWithOptions:options]; // Make a copy
			[localOptions.postData setValues:semesterDate];
			[localOptions.postData setValues:[self dictForCourse:course]];
			if (![self connect:localOptions]) return;
		}
	}
}
-(void)saveSemesters:(NSArray *)semesters forStudent:(Student*)student {
	if (![self deleteSemestersForStudent:student]) return;
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"insertStudentSchedule.php"];
	[options.postData setInt:student.id forKey:@"StudentID"];
	[self saveSemesters:semesters withOptions:options];
}
-(void)saveSemesters:(NSArray *)semesters forTemplate:(Template*)template {
	if (![self deleteSemestersForTemplate:template]) return;
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"insertTemplateSchedule.php"];
	[options.postData setInt:template.id forKey:@"TemplateID"];
	[self saveSemesters:semesters withOptions:options];
}


/*
	SINGLETON STUFF
*/

+(SemesterRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[SemesterRepo alloc] init];
	}
	return instance;
}

+(id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (instance == nil) {
			instance = [super allocWithZone:zone];
			return instance; // assignment and return on first allocation
		}
	}
	return nil; // on subsequent allocation attempts return nil
}

@end
