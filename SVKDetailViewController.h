//
//  SVKDetailViewController.h
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVKEvent;

@interface SVKDetailViewController : UIViewController

@property (strong, nonatomic) SVKEvent *event;
@property BOOL isNew;

-(void)setEventTitle:(SVKEvent *)event;

@end
