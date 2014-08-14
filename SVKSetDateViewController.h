//
//  SVKSetDateViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 09.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVKDatesIntervalViewController.h"
#import "SVKCalCalc.h"

@interface SVKSetDateViewController : UIViewController

//@property (nonatomic, strong) NSDate *date;
@property SVKCalCalc *calCalc;
@property (nonatomic) SVKDatesIntervalViewController *datesPeriodViewController;
@property (nonatomic) BOOL isDateStart;

@end
