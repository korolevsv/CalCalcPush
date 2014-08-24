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
#import "SVKTimePickerViewController.h"
#import "SVKCalCalc.h"



@interface SVKDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;

@property SVKCalCalc *calCalc;

@end

@implementation SVKDetailViewController

#pragma mark - Subview Actions

- (IBAction)pickDate:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalcPushSegue" bundle:nil];
    
    SVKDatePickerViewController *datePickerViewController = (SVKDatePickerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DatePicker"];
    datePickerViewController.isEventDate = YES;
    datePickerViewController.calCalc = self.calCalc;
//    datePickerViewController.calCalc.startDate = self.event.eventDate;
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:datePickerViewController];
    [self presentViewController:navController animated:YES completion:nil];    
}

- (IBAction)pickTime:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CalcPushSegue" bundle:nil];
    
    SVKTimePickerViewController *timePickerViewController = (SVKTimePickerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TimePicker"];
    timePickerViewController.isEventDate = YES;
    timePickerViewController.calCalc = self.calCalc;
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:timePickerViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark - Lifecycle
- (instancetype)init
{
/*
    self = [super init];
    if (self) {
        _calCalc = [[SVKCalCalc alloc] init];
    }
    _isNew = NO;
    
    return self;
*/
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}


- (instancetype)initForNewEvent:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
//    self = [super init];
    if (self) {
        self.calCalc = [[SVKCalCalc alloc] init];
        if (self) {
            if (isNew) {
                UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                             target:self
                                             action:@selector(save:)];
                self.navigationItem.rightBarButtonItem = doneItem;
                
                UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                               target:self
                                               action:@selector(cancel:)];
                self.navigationItem.leftBarButtonItem = cancelItem;
            }
        }
    }
    
    return self;
}

/*
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                          bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer"
                                   reason:@"Use initForNewItem:"
                                 userInfo:nil];
    return nil;
}
*/

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the new event from the store
    [[SVKEventStore sharedStore] removeEvent:self.event];
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
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
    _event.eventDate = self.calCalc.startDate;
    self.nameField.text = event.eventName;
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

// Overwrite Setter to set CalCalc
- (void)setEvent:(SVKEvent *)event
{
    _event = event;
    _calCalc.startDate = _event.eventDate;
}

@end
