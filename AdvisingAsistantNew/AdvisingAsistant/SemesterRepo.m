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

+(SemesterRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[SemesterRepo alloc] init];
	}
	return instance;
}

-(SemesterDate)semesterDateFromDict:(NSDictionary *)dict {
	Season season = [[dict objectForKey:@"Semester"] isEqualToString:@"F"] ? SeasonFall : SeasonSpring;
	int year = [[dict objectForKey:@"Year"] intValue];
	return SemesterDateMake(season, year);
}

-(Course*)courseFromDict:(NSDictionary *)dict {
	NSString *code = [dict objectForKey:@"DepartmentID"];
	Department *department = [[DepartmentRepo defaultRepo] departmentWithCode:code];
	NSString *number = [dict objectForKey:@"CourseID"];
	Course *course = [[CourseRepo defaultRepo] courseWithDepartment:department andNumber:number];
	course.customName = [dict objectForKey:@"Custom"];
	return course;
}

-(NSArray*)semestersFromDicts:(NSArray *)dicts {
	NSMutableArray *semesters = [[NSMutableArray alloc] init];
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

-(NSMutableDictionary *)dictForDate:(SemesterDate)date {
	
}
-(NSMutableDictionary *)dictForCourse:(Course *)course {
	
}

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

-(void)saveSemesters:(NSArray *)schedules forStudent:(Student*)student {
	if (![self deleteSemestersForStudent:student]) return;
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"insertStudentSchedule.php"];
	
}
-(void)saveSemesters:(NSArray *)schedules forTemplate:(Template*)template {
	self.error = @"Could not connect to server";
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
