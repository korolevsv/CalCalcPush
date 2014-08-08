//
//  SVKCalCalc.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKCalCalc.h"
#import <Foundation/NSCalendar.h>

@implementation SVKCalCalc
NSCalendar *calendar;
NSDateComponents *components;
NSCalendarUnit units;

- (instancetype)init {
    NSDate *now = [[NSDate alloc] init];
    return [self initWithDates:now endDate:now];
}

// Designated initializer
- (instancetype)initWithDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];

    _startDate = startDate;
    _endDate = endDate;
    _intervalBetweenDates = [endDate timeIntervalSinceDate:startDate];
    calendar = [NSCalendar currentCalendar];

    return self;
}

/*
- (double)intervalYears {
    return 1;
}
- (double)intervalMonths {
    return 1;
    
}
*/

- (long)intervalDays {
    NSNumber *days = [[NSNumber alloc] init];
    units = NSDayCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components day];    
}
/*
- (double)intervalHours {
    
    return 1;
}
- (double)intervalSecs {
    
    return 1;
}
*/

/*
 units = NSWeekCalendarUnit;
 components = [calendar components:units
 fromDate:startDate
 toDate:endDate
 options:0];

 */

@end
