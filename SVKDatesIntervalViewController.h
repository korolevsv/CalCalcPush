//
//  SVKDatesPeriodViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SVKCalCalc.h"

@interface SVKDatesIntervalViewController : UIViewController

@property (nonatomic, strong)NSDate *startDate;
@property (nonatomic, strong)NSDate *endDate;
@property NSTimeInterval intervalBetweenDates;
//@property SVKCalCalc *@calCalc;

@end
