//
//  SVKDatesPeriodViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDatesPeriodViewController.h"
#import "SVKCalCalc.h"

@interface SVKDatesPeriodViewController ()

@property SVKCalCalc *calCalc;

@end

@implementation SVKDatesPeriodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _calCalc = [[SVKCalCalc alloc] init];
    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - View fields setting
- (void) updateView {
//    NSString *text;
    self.startDate = self.calCalc.startDate;
    self.endDate = self.calCalc.endDate;
    self.intervalBetweenDates = self.calCalc.intervalBetweenDates;
    
    self.secsTextField.text = [NSString stringWithFormat:@"%d", (double)self.intervalBetweenDates];
    self.daysTextField.text = [NSString stringWithFormat:@"%d", [self.calCalc intervalDays]];
    
    
    
}
@end
