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

@interface SVKDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;

@end

@implementation SVKDetailViewController

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
    /* Use this to set a common navigation item name for the view
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Details";
    }
     */
    return self;
}

// Set navigation item name as an EventDate.name
-(void)setEDate:(SVKEvent *)eDate
{
    _eDate = eDate;
    self.navigationItem.title = _eDate.eventName;    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SVKEvent *date = self.eDate;
    self.nameField.text = date.eventName;
    
    // You need an NSDateFormatter that will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateField.text = [dateFormatter stringFromDate:date.eventDate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    SVKEvent *eDate = self.eDate;
    if(eDate) {
        eDate.eventName = self.nameField.text;
    }
}

@end
