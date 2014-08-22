//
//  SVKDetailViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDetailViewController.h"
#import "SVKEvent.h"
#import "SVKEventStore.h"
#import "SVKDatePickerViewController.h"
#import "SVKCalCalc.h"



@interface SVKDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;

@property SVKCalCalc *calCalc;

@end

@implementation SVKDetailViewController

#pragma marl - Modal View Pickers Experiment
- (IBAction)dateButton:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalcPushSegue" bundle:nil];
    
    SVKDatePickerViewController *datePickerViewController = (SVKDatePickerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DatePicker"];
    datePickerViewController.isEventDate = YES;
    datePickerViewController.calCalc = self.calCalc;
    datePickerViewController.calCalc.startDate = self.event.eventDate;
    UINavigationController *navController = [[UINavigationController alloc]
                                              initWithRootViewController:datePickerViewController];    
    [self presentViewController:navController animated:YES completion:nil];
    
}


#pragma mark - Stable code
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.calCalc = [[SVKCalCalc alloc] init];
    }
    return self;
}

// Set navigation item name as an EventDate.name
-(void)setEventTitle:(SVKEvent *)event
{
    _event = event;
    self.navigationItem.title = _event.eventName;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SVKEvent *event = self.event;
    self.nameField.text = event.eventName;
/*
    // You need an NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
 self.dateField.text = [dateFormatter stringFromDate:date.eventDate];
*/
    self.dateField.text = [event dateDescription];
    self.timeField.text = [event timeDescription];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    SVKEvent *eDate = self.event;
    if(eDate) {
        eDate.eventName = self.nameField.text;
    }
}

@end
