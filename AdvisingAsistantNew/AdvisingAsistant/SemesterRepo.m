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
	course = [Course courseWithCourse:course]; // Make a copy
	course.customName = [dict objectForKey:@"Custom"];
	if (course.customName.length == 0) course.customName = nil;
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

-(NSArray*)semestersFromDicts:(NSArray *)dicts {
	NSMutableArray *semesters = [NSMutableArray array];
	Semester *semester = nil;
	for (NSDictionary *dict in dicts) {
		SemesterDate date = [self semesterDateFromDict:dict];
		if (!SemesterDateEqual(date, semester.date)) {
			[semesters addObject:semester];
			semester = nil;
		}
		if (!semester) {
			semester = [[Semester alloc] init];
			semester.date = date;
		}
		Course *course = [self courseFromDict:dict];
		[semester.courses addObject:course];
	}
	if (semester) [semesters addObject:semester];
	return semesters;
}

-(NSArray*)semestersForStudent:(Student*)student {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getStudentSchedule.php"];
	[options.postData setInt:student.id forKey:@"StudentID"];
	return [self semestersFromDicts:[self connect:options]];
}

-(NSArray*)semestersForTemplate:(Template*)template {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getTemplateSchedule.php"];
	[options.postData setInt:template.id forKey:@"TemplateID"];
	return [self semestersFromDicts:[self connect:options]];
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
