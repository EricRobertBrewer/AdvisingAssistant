//
//  AANotify.h
//  AdvisingAsistant
//
//  Created by Ryan Shaul on 4/28/12.
//  Copyright (c) 2012 Allied Information Networks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKNotify.h"

@interface AANotify : NSObject

+(void)present:(CKNotifyAlertType)type title:(NSString *)title body:(NSString *)body duration:(float)duration;

@end
