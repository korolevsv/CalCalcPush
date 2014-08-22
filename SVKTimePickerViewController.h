//
//  SVKTimePickerViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 13.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "SVKCalCalc.h"
@class SVKCalCalc;

@interface SVKTimePickerViewController : UIViewController

@property SVKCalCalc *calCalc;
@property (nonatomic) BOOL isDateStart;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@property BOOL isEventDate;

@end
