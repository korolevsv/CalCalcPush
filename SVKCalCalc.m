//
//  SVKCalCalc.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKCalCalc.h"

@implementation SVKCalCalc

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
    return self;
}
@end
