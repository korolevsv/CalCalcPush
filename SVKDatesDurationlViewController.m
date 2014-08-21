//
//  SVKDatesPeriodViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 08.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDatesDurationlViewController.h"
#import "SVKCalCalc.h"
#import "SVKSetDateViewController.h"
#import "SVKDatePickerViewController.h"
#import "SVKTimePickerViewController.h"


@interface SVKDatesDurationlViewController ()

@property BOOL isFixedDates; // Calculate with fixed Start and End Dates
@property BOOL isStartNow; // Calculate with startDate=NOW or endDate=NOW

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

- (void)enableStartFields:(BOOL)isEnabled;
- (void)enableEndFields:(BOOL)isEnabled;
- (void)updateView;
- (void)startTimer;
- (void)stopTimer;
- (void)updateTimer;



@end

@implementation SVKDatesDurationlViewController

NSTimer *timerNow;

#pragma mark - NOW and Timer methods
- (IBAction)selectorNow:(id)sender {
    UISegmentedControl *segmentNow;
    segmentNow = sender;
    switch (segmentNow.selectedSegmentIndex) {
        case 0:
        {
            self.isFixedDates = NO;
            self.isStartNow = YES;
            [self startTimer];
            [self enableStartFields:NO];
            [self updateView];
            break;
        }
        case 1:
        {
            self.isFixedDates = YES;
            [self stopTimer];
            [self enableStartFields:YES];
            [self enableEndFields:YES];
            [self updateView];
            break;
        }
        case 2:
        {
            self.isFixedDates = NO;
            self.isStartNow = NO;
            [self startTimer];
            [self enableEndFields:NO];
            [self updateView];
            break;
        }
            
            break;
            
        default:
            break;
    }
    
}
- (void)startTimer
{
    timerNow = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer
{
    if (self.isStartNow) {
        [self.calCalc setStartNow];
    } else {
        [self.calCalc setEndNow];
    }
    [self updateView];
}

- (void)stopTimer
{
    [timerNow invalidate];
}



#pragma mark - Set Start-End Dates
- (IBAction)pickDate:(id)sender {
    [self performSegueWithIdentifier:@"ModalDate" sender:sender];
}
- (IBAction)pickTime:(id)sender {
    [self performSegueWithIdentifier:@"ModalTime" sender:sender];
}


#pragma mark Standard methods
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
    _isFixedDates = YES;
    [self initView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self updateView];
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
    // Use the segue to set the date on the view controller DatePickers
    // Push seque:
    if ([segue.identifier isEqualToString:@"SetStartDate"]) {
        SVKSetDateViewController *setDateController = (SVKSetDateViewController *)segue.destinationViewController;
        setDateController.datesPeriodViewController = self;

        setDateController.isDateStart = YES;
        setDateController.calCalc = self.calCalc;
    }
    if ([segue.identifier isEqualToString:@"SetEndDate"]) {
        SVKSetDateViewController *setDateController = (SVKSetDateViewController *)segue.destinationViewController;
        setDateController.datesPeriodViewController = self;

        setDateController.isDateStart = NO;
        setDateController.calCalc = self.calCalc;
    }
    // Modal view:
 
    if ([segue.identifier isEqualToString:@"ModalDate"]) {
        UINavigationController *navigationController=  (UINavigationController *)segue.destinationViewController;
        SVKDatePickerViewController *datePickerVController = (SVKDatePickerViewController *)navigationController.topViewController;
        if (sender == self.startDateField) {
            datePickerVController.isDateStart = YES;
        } else if (sender == self.endDateField) {
            datePickerVController.isDateStart = NO;
        }
        datePickerVController.calCalc = self.calCalc;
    }
    if ([segue.identifier isEqualToString:@"ModalTime"]) {
        UINavigationController *navigationController=  (UINavigationController *)segue.destinationViewController;
        SVKTimePickerViewController *timePickerVController = (SVKTimePickerViewController *)navigationController.topViewController;
        if (sender == self.startTimeField) {
            timePickerVController.isDateStart = YES;
        } else if (sender == self.endTimeField) {
            timePickerVController.isDateStart = NO;
        }
        timePickerVController.calCalc = self.calCalc;
    }
}


#pragma mark - View fields update
- (void)initView
{
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


- (void)enableStartFields:(BOOL)isEnabled
{
    if (isEnabled) {
        self.startDateField.backgroundColor = _colorTextFieldDefault;
        self.startTimeField.backgroundColor = _colorTextFieldDefault;
        self.startDateField.userInteractionEnabled = YES;
        self.startTimeField.userInteractionEnabled = YES;
    } else {
        self.startDateField.backgroundColor = _colorTextFieldDisabled;
        self.startTimeField.backgroundColor = _colorTextFieldDisabled;
        self.startDateField.userInteractionEnabled = NO;
        self.startTimeField.userInteractionEnabled = NO;
    }
}

- (void)enableEndFields:(BOOL) isEnabled
{
    if (isEnabled) {
        self.endDateField.backgroundColor = _colorTextFieldDefault;
        self.endTimeField.backgroundColor = _colorTextFieldDefault;
        self.endDateField.userInteractionEnabled = YES;
        self.endTimeField.userInteractionEnabled = YES;
    } else {
        self.endDateField.backgroundColor = _colorTextFieldDisabled;
        self.endTimeField.backgroundColor = _colorTextFieldDisabled;
        self.endDateField.userInteractionEnabled = NO;
        self.endTimeField.userInteractionEnabled = NO;
    }
}

- (void) updateView {
//    Print start-end date-time:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    if (_isFixedDates) {  // Fixed Dates
        self.startDateField.text = [formatter stringFromDate:self.calCalc.startDate];
        self.endDateField.text = [formatter stringFromDate:self.calCalc.endDate];
    } else if (_isStartNow) {  // Start = NOW
        self.startDateField.text = @"TODAY";
        self.endDateField.text = [formatter stringFromDate:self.calCalc.endDate];
        
    } else {  // End = NOW
        self.startDateField.text = [formatter stringFromDate:self.calCalc.startDate];
        self.endDateField.text = @"TODAY";
        
    }
    
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    self.startTimeField.text = [formatter stringFromDate:self.calCalc.startDate];
    self.endTimeField.text = [formatter stringFromDate:self.calCalc.endDate];
    
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
