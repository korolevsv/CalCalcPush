//
//  SVKCalCalc.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKCalCalc.h"
#import <Foundation/NSCalendar.h>

@interface SVKCalCalc()
- (NSCalendarUnit) getUnits;
@end

@implementation SVKCalCalc
NSCalendar *calendar;
NSDateComponents *components;
NSCalendarUnit units = NSSecondCalendarUnit;

- (instancetype)init {
    NSDate *now = [[NSDate alloc] init];
    components = [[NSDateComponents alloc] init];
    return [self initWithDates:now endDate:now];
}

// Designated initializer
- (instancetype)initWithDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    self = [super init];

    _startDate = startDate;
    _endDate = endDate;
    calendar = [NSCalendar currentCalendar];
    _calcYears = YES;
    _calcMonths = YES;
    _calcDays = YES;
    _calcHours = YES;
    _calcMins = YES;
    _calcSecs = YES;
    
    return self;
}

// Set units in components
- (NSCalendarUnit) getUnits {
    NSCalendarUnit unit = 0;
    if(_calcSecs) {
        unit = unit | NSSecondCalendarUnit;
    }
    if(_calcMins) {
        unit = unit | NSMinuteCalendarUnit;
    }
    if(_calcHours) {
        unit = unit | NSHourCalendarUnit;
    }
    if(_calcDays) {
        unit = unit | NSDayCalendarUnit;
    }
    if(_calcMonths) {
        unit = unit | NSMonthCalendarUnit;
    }
    if(_calcYears) {
        unit = unit | NSYearCalendarUnit;
    }
    return unit;
}


- (NSInteger)intervalYears {
    if (_calcYears) {
        components = [calendar components:[self getUnits]
                             fromDate:self.startDate
                               toDate:self.endDate
                              options:0];
        return [components year];
    } else {
        return 0;
    }
}

- (NSInteger)intervalMonths {
    if(_calcMonths) {
        components = [calendar components:[self getUnits]
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
        return [components month];
        
    } else {
        return 0;
    }
}


- (NSInteger)intervalDays {
    if (_calcDays) {
        components = [calendar components:[self getUnits]
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
        return [components day];

    } else {
        return 0;
    }
}

- (NSInteger)intervalHours {
    if (_calcHours) {
        components = [calendar components:[self getUnits]
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
        return [components hour];

    } else {
        return 0;
    }
}

- (NSInteger)intervalMins {
    if (_calcMins) {
        components = [calendar components:[self getUnits]
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
        return [components minute];

    } else {
        return 0;
    }
}

- (NSInteger)intervalSecs {
    if (_calcSecs) {
        components = [calendar components:[self getUnits]
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
        return [components second];

    } else {
        return 0;
    }
}

/*
For example, timeIntervalSinceNow gives you the time, in seconds, between the current time and the receiving date object.
*/

@end
