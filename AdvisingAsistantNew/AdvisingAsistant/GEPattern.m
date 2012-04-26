//
//  GEPattern.m
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/23/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "GEPattern.h"

NSString* FormatGEPattern(GEPattern pattern) {
    return (pattern == GEPatternFreshman) ? @"Freshman" : @"Transfer";
}

GEPattern GEPatternFromString(NSString *s) {
    return [s isEqualToString:@"Freshman"] ? GEPatternFreshman : GEPatternTransfer;
}