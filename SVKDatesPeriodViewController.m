//
//  SVKDatesPeriodViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDatesPeriodViewController.h"
#import "SVKCalCalc.h"
#import "SVKSetDateViewController.h"

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
    self.startDate = self.calCalc.startDate;
    self.endDate = self.calCalc.endDate;

    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.calCalc.startDate = self.startDate;
    self.calCalc.endDate = self.endDate;
    
    [self updateView];
    
    // Restore settings from Date and Time Pickers
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SVKSetDateViewController *setDateController = (SVKSetDateViewController *)segue.destinationViewController;
    setDateController.datesPeriodViewController = self;

    // Use the segue to set the date on the view controller DatePickers
    if ([segue.identifier isEqualToString:@"SetStartDate"]) {
        setDateController.date = self.startDate;
        setDateController.isDateStart = YES;
    }
    else if ([segue.identifier isEqualToString:@"SetEndDate"]) {
        setDateController.date = self.endDate;
        setDateController.isDateStart = NO;
    }
}


#pragma mark - View fields setting
- (void) updateView {
//    NSString *text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
//    self.startDate = self.calCalc.startDate;
//    self.endDate = self.calCalc.endDate;
//    self.intervalBetweenDates = self.calCalc.intervalBetweenDates;

    self.startDateLabel.text = [formatter stringFromDate:self.startDate];
    self.daysTextField.text = [NSString stringWithFormat:@"%d", [self.calCalc intervalDays]];

    self.intervalBetweenDates = [self.endDate timeIntervalSinceDate:self.startDate];
    self.secsTextField.text = [NSString stringWithFormat:@"%d", (double)self.intervalBetweenDates];

    
    
    
}
@end
