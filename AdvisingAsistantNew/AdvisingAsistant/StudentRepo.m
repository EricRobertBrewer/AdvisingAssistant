//
//  StudentRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/8/12.
//  Copyright (c) 2012 The Children All rights reserved.
//

#import "StudentRepo.h"

static StudentRepo *instance = nil;

@implementation StudentRepo

/*
	SERIALIZING TO/FROM DICTIONARIES
*/

-(Student *)studentFromDict:(NSDictionary*)dict {
	Student *student = [[Student alloc] init];
	student.id = [[dict objectForKey:@"StudentID"] intValue];
	student.name = [dict objectForKey:@"Name"];
	Season season = [[dict objectForKey:@"StartSemester"] isEqualToString:@"F"] ? SeasonFall : SeasonSpring;
	int year = [[dict objectForKey:@"StartYear"] intValue];
	student.started = SemesterDateMake(season, year);
	return [student autorelease];
}

-(NSMutableDictionary *)dictFromStudent:(Student *)student {
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	NSString *id = [NSString stringWithFormat:@"%i", student.id];
	NSString *season = (student.started.season == SeasonFall) ? @"F" : @"S";
	NSString *year = [NSString stringWithFormat:@"%i", student.started.year];
	[dict setValue:id forKey:@"StudentID"];
	[dict setValue:student.name forKey:@"Name"];
	[dict setValue:season forKey:@"StartSemester"];
	[dict setValue:year forKey:@"StartYear"];
	return [dict autorelease];
}

/*
	GETTING STUDENTS
*/

-(Student*)studentWithId:(int)id {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getStudent.php"];
	[options.postData setInt:id forKey:@"StudentID"];
	NSArray *dicts = [self connect:options];
	for (NSDictionary *dict in dicts) {
		Student *student = [self studentFromDict:dict];
		if (student.id == id) return student;
	}
	return nil;
}

/*
	SAVING STUDENTS
*/

-(void)saveStudent:(Student *)student {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"insertStudent.php"];
	options.postData = [self dictFromStudent:student];
	[self connect:options];
}

/*
	SINGLETON STUFF
*/

+(StudentRepo*)defaultRepo {
	if (instance == nil) {
		instance = [[StudentRepo alloc] init];
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
