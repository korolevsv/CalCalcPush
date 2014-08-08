//
//  SVKCalCalc.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVKCalCalc : NSObject

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) NSTimeInterval intervalBetweenDates;

// Designated initializer
- (instancetype)initWithDates:(NSDate *)startDate endDate:(NSDate *)endDate;
//- (instancetype) setStartDate;
- (NSNumber *)intervalYears;
- (NSNumber *)intervalMonths;
- (long)intervalDays;
- (NSNumber *)intervalHours;
- (NSNumber *)intervalSecs;


@end
