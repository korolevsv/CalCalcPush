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
@property UIColor *colorTextFieldDefault;
@property UIColor *colorTextFieldDisabled;


@property (weak, nonatomic) IBOutlet UITextField *startDateField;
@property (weak, nonatomic) IBOutlet UITextField *endDateField;
@property (weak, nonatomic) IBOutlet UITextField *startTimeField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeField;


@property (weak, nonatomic) IBOutlet UITextField *yearsTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthsTextField;
@property (weak, nonatomic) IBOutlet UITextField *daysTextField;
@property (weak, nonatomic) IBOutlet UITextField *hoursTextField;
@property (weak, nonatomic) IBOutlet UITextField *minsTextField;
@property (weak, nonatomic) IBOutlet UITextField *secsTextField;

@property (weak, nonatomic) IBOutlet UISwitch *switchYears;
@property (weak, nonatomic) IBOutlet UISwitch *switchMonths;
@property (weak, nonatomic) IBOutlet UISwitch *switchDays;
@property (weak, nonatomic) IBOutlet UISwitch *switchHours;
@property (weak, nonatomic) IBOutlet UISwitch *switchMins;
@property (weak, nonatomic) IBOutlet UISwitch *switchSecs;

@end

@implementation SVKDatesPeriodViewController
- (IBAction)setStartDateTime:(id)sender {
    [self performSegueWithIdentifier:@"SetStartDate" sender:self];
}
- (IBAction)setEndDateTime:(id)sender {
    [self performSegueWithIdentifier:@"SetEndDate" sender:self];
}


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
    
    _colorTextFieldDefault = [UIColor whiteColor];
    _colorTextFieldDisabled = [UIColor lightGrayColor];
    // Set initial switches and text backgrounds:
    self.switchYears.on = YES;
    [self switchYears:self.switchYears];
    self.switchMonths.on = YES;
    [self switchMonths:self.switchMonths];
    self.switchDays.on = YES;
    [self switchDay:self.switchDays];
    self.switchHours.on = NO;
    [self switchHour:self.switchHours];
    self.switchMins.on = NO;
    [self switchMin:self.switchMins];
    self.switchSecs.on = NO;
    [self switchSec:self.switchSecs];

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
/*
// Debug code
    NSDateComponents *compsDebug = [[NSDateComponents alloc] init];
    [compsDebug setYear:1065];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *dateDebug = [calendar dateFromComponents:compsDebug];
    self.startDate = dateDebug;
// End of debug
*/
    self.calCalc.startDate = self.startDate;
    self.calCalc.endDate = self.endDate;
    
    [self updateView];
    
    // Restore settings from Date and Time Pickers
}

#pragma mark - Switch processing
- (IBAction)switchYears:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcYears = sw.on;
    if(sw.on) {
        self.yearsTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.yearsTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
}
- (IBAction)switchMonths:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcMonths = sw.on;
    if(sw.on) {
        self.monthsTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.monthsTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
}
- (IBAction)switchDay:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcDays = sw.on;
    if(sw.on) {
        self.daysTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.daysTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
}
- (IBAction)switchHour:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcHours = sw.on;
    if(sw.on) {
        self.hoursTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.hoursTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
}
- (IBAction)switchMin:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcMins = sw.on;
    if(sw.on) {
        self.minsTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.minsTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
}
- (IBAction)switchSec:(id)sender {
    UISwitch *sw = sender;
    self.calCalc.calcSecs = sw.on;
    if(sw.on) {
        self.secsTextField.backgroundColor = _colorTextFieldDefault;
    }
    else {
        self.secsTextField.backgroundColor = _colorTextFieldDisabled;
    }
    [self updateView];
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
//    Print start-end date-time:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    self.startDateField.text = [formatter stringFromDate:self.startDate];
    self.endDateField.text = [formatter stringFromDate:self.endDate];

    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    self.startTimeField.text = [formatter stringFromDate:self.startDate];
    self.endTimeField.text = [formatter stringFromDate:self.endDate];
    
// Show Interval
    self.yearsTextField.text = [NSString localizedStringWithFormat:@"%ld", [self.calCalc intervalYears]];
    self.monthsTextField.text = [NSString localizedStringWithFormat:@"%ld", [self.calCalc intervalMonths]];
    self.daysTextField.text = [NSString localizedStringWithFormat:@"%ld", [self.calCalc intervalDays]];
    self.hoursTextField.text = [NSString localizedStringWithFormat:@"%ld", [self.calCalc intervalHours]];
    self.minsTextField.text = [NSString localizedStringWithFormat:@"%ld", [self.calCalc intervalMins]];
    self.secsTextField.text = [NSString localizedStringWithFormat:@"%ld", (long)[self.calCalc intervalSecs]];
//    self.secsTextField.text = [NSString stringWithFormat:@"%ld", (long)[self.calCalc intervalSecs]];
}
@end
