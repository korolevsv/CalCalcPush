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
@property BOOL calcYears;
@property BOOL calcMonths;
@property BOOL calcDays;
@property BOOL calcHours;
@property BOOL calcMins;
@property BOOL calcSecs;

//@property (nonatomic) NSTimeInterval intervalBetweenDates;

// Designated initializer
- (instancetype)initWithDates:(NSDate *)startDate endDate:(NSDate *)endDate;
/*
 - (void) setComponents:(BOOL)isSecs withMins:(BOOL)isMins withHours:(BOOL)isHours withDays:(BOOL)isDays withMonths:(BOOL)isMonths withYears:(BOOL)isYears;
*/

- (NSInteger)intervalYears;
- (NSInteger)intervalMonths;
- (NSInteger)intervalDays;
- (NSInteger)intervalHours;
- (NSInteger)intervalMins;
- (NSInteger)intervalSecs;


@end
