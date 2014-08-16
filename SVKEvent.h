//
//  SVKDate.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVKEvent : NSObject <NSCoding>

@property NSString *eventName;
@property NSDate *eventDate;

- (NSString *) dateDescription;
- (NSString *) timeDescription;

@end
