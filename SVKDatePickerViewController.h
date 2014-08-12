//
//  SVKPickerViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 12.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVKCalCalc.h"

@interface SVKDatePickerViewController : UIViewController
//@property NSDate *date;
@property (nonatomic) BOOL isDateStart;
@property SVKCalCalc *calCalc;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;

@end
