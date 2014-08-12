//
//  SVKSetDateViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 09.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKSetDateViewController.h"
#import <Foundation/NSCalendar.h>

@interface SVKSetDateViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

@end

@implementation SVKSetDateViewController
- (IBAction)datePickerSet:(id)sender {
    self.timePicker.date = self.datePicker.date;
    if (self.isDateStart) {
        self.calCalc.startDate = self.datePicker.date;
    } else {
        self.calCalc.endDate = self.datePicker.date;
    }
    
}
- (IBAction)timePickerSet:(id)sender {
    self.datePicker.date = self.timePicker.date;
    if (self.isDateStart) {
        self.calCalc.startDate = self.datePicker.date;
    } else {
        self.calCalc.endDate = self.datePicker.date;
    }

}
/* Today-Now buttonn deleted
- (IBAction)buttonToday:(id)sender {
    NSDate *today = [NSDate date]; // Today without time
    unsigned unitFlagsDateOnly = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:unitFlagsDateOnly fromDate:today];
    today = [cal dateFromComponents:components];
    self.date = today;
    self.datePicker.date = self.date;
    self.timePicker.date = today;
}

- (IBAction)buttonNow:(id)sender {
    self.date = [NSDate date];
    self.datePicker.date = self.date;
    self.timePicker.date = self.date;
}
*/

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set Date and Time Pickers
    if (self.isDateStart) {
        self.datePicker.date = self.calCalc.startDate;
        self.timePicker.date = self.calCalc.startDate;
        self.navigationItem.title = @"Set Start Date";
    } else {
        self.datePicker.date = self.calCalc.endDate;
        self.timePicker.date = self.calCalc.endDate;
        self.navigationItem.title = @"Set End Date";
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
/*
    if (self.isDateStart) {
        self.datesPeriodViewController.startDate = self.date;
    } else {
        self.datesPeriodViewController.endDate = self.date;
    }
*/
}

@end
