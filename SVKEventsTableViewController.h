//
//  SVKDatesTableViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVKCalCalc.h"

@interface SVKEventsTableViewController : UITableViewController

@property BOOL isPickingFromDatePicker;
@property BOOL isDateStart;
@property SVKCalCalc *calCalcBuffer;

@end
