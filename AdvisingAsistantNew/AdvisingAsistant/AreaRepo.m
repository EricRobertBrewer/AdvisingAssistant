//
//  AreaRepo.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/23/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import "AreaRepo.h"

static AreaRepo *instance = nil;

@implementation AreaRepo

/*
    SERIALIZING DICTIONARIES
*/

-(Area *)areaFromDict:(NSDictionary *)dict {
    Area *area = [[Area alloc] init];
    area.name = [dict objectForKey:@"Area"];
    area.title = [dict objectForKey:@"Title"];
    return [area autorelease];
}

-(NSArray *)areasFromDicts:(NSArray *)dicts {
    NSMutableArray *areas = [NSMutableArray array];
    for (NSDictionary *dict in dicts) {
        [areas addObject:[self areaFromDict:dict]];
    }
    return areas;
}

/*
    GETTING AREAS
*/

-(NSArray *)areasForArea:(Area *)area {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getAreasForArea.php"];
    [options.postData setValue:area.name forKey:@"Area"];
	return [self areasFromDicts:[self connect:options]];
}

-(NSArray *)areasForDepartment:(Department *)department date:(SemesterDate)date {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getAreasForDepartment.php"];
    [options.postData setValue:department.code forKey:@"DepartmentID"];
	return [self areasFromDicts:[self connect:options]];
}

-(NSArray *)areasForGEPattern:(GEPattern)pattern date:(SemesterDate)date {
	ConnectOptions *options = [ConnectOptions optionsWithUrl:@"getAreasForGEPattern.php"];
    [options.postData setValue:FormatGEPattern(pattern) forKey:@"Pattern"];
	return [self areasFromDicts:[self connect:options]];
}


/*
    SINGLETON STUFF
*/

+(AreaRepo *)defaultRepo {
	if (instance == nil) {
		instance = [[AreaRepo alloc] init];
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
