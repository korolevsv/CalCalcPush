//
//  SVKSetDateViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 09.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVKDatesPeriodViewController.h"

@interface SVKSetDateViewController : UIViewController

@property (nonatomic, strong) NSDate *date;
@property (nonatomic) SVKDatesPeriodViewController *datesPeriodViewController;
@property (nonatomic) BOOL isDateStart;

@end
