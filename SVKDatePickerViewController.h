//
//  SVKPickerViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 12.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "SVKCalCalc.h"
@class SVKCalCalc;

@interface SVKDatePickerViewController : UIViewController
@property SVKCalCalc *calCalc;
@property (nonatomic) BOOL isDateStart;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIButton *pickEventButton;

@property BOOL isEventDate;

@end
