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

#pragma mark - Class methods
+ (NSDate *)removeSecondsFromDate:(NSDate*)date
{
    components = [[NSDateComponents alloc] init];
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:date];
    return [cal dateFromComponents:components];
}

+ (NSDate *)removeTimeFromDate:(NSDate*)date
{
    components = [[NSDateComponents alloc] init];
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:date];
    return [cal dateFromComponents:components];
}

#pragma mark - Life cycle

- (instancetype)init {
    NSDate *now = [[NSDate alloc] init];
    NSDate *todayMidnight; // Today midnight (00:00)
    NSDate *todayMidday; // Today midnight (00:00)
    components = [[NSDateComponents alloc] init];
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:now];
    todayMidnight = [cal dateFromComponents:components];
    NSTimeInterval halfDay = 60*60*12;
    todayMidday = [todayMidnight dateByAddingTimeInterval:halfDay];
// return today Midnight-Midday
    return [self initWithDates:todayMidnight endDate:todayMidday
        ];
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


- (long)intervalYears {
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

- (long)intervalMonths {
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


- (long)intervalDays {
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

- (long)intervalHours {
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

- (long)intervalMins {
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

- (NSTimeInterval)intervalSecs {
    NSCalendarUnit unit = [self getUnits];
    if (_calcSecs) {
        if (unit == NSSecondCalendarUnit)
        {
            NSTimeInterval secsNSTime = [self.endDate timeIntervalSinceDate:self.startDate];
//            long vOut = [[NSNumber numberWithDouble:longSecs] longValue];
            return secsNSTime;
            
        } else {
            components = [calendar components:unit
                                 fromDate:self.startDate
                                   toDate:self.endDate
                                  options:0];
            return [components second];
        }

    } else {
        return 0;
    }
}

- (void)setStartNow
{
    // Set time to Now WITHOUT seconds fractions
    NSDate *now = [[NSDate alloc] init];
    components = [[NSDateComponents alloc] init];
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:now];
    _startDate = [cal dateFromComponents:components];
}

- (void)setEndNow
{
    // Set time to Now WITHOUT seconds fractions
    NSDate *now = [[NSDate alloc] init];
    components = [[NSDateComponents alloc] init];
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:now];
    _endDate = [cal dateFromComponents:components];
}


/*
For example, timeIntervalSinceNow gives you the time, in seconds, between the current time and the receiving date object.
*/

@end
