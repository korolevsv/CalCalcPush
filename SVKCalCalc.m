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


- (long)intervalYears {
    units = NSYearCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components year];
}

- (long)intervalMonths {
    units = NSMonthCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components month];
}


- (long)intervalDays {
    units = NSDayCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components day];    
}

- (long)intervalHours {
    units = NSHourCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components hour];
}

- (long)intervalMins {
    units = NSMinuteCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components minute];
}

- (long)intervalSecs {
    units = NSSecondCalendarUnit;
    components = [calendar components:units
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
    return [components second];
}


@end
