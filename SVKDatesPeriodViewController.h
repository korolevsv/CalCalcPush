//
//  SVKDatesPeriodViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SVKCalCalc.h"

@interface SVKDatesPeriodViewController : UIViewController

@property NSDate *startDate;
@property NSDate *endDate;
@property NSTimeInterval intervalBetweenDates;
//@property SVKCalCalc *@calCalc;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *yearsTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthsTextField;
@property (weak, nonatomic) IBOutlet UITextField *daysTextField;
@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;
@property (weak, nonatomic) IBOutlet UITextField *minsTextField;
@property (weak, nonatomic) IBOutlet UITextField *secsTextField;

@end
