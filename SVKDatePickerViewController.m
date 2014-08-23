//
//  SVKPickerViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 12.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDatePickerViewController.h"
#import "SVKCalCalc.h"
#import "SVKEventsTableViewController.h"

@interface SVKDatePickerViewController ()

@end

@implementation SVKDatePickerViewController
- (IBAction)doneButton:(id)sender {
    // Call from Event Detail View
    if (self.isEventDate) {
        self.calCalc.startDate = self.DatePicker.date;
        [self dismiss:sender];
        return;
    }
    
    // Call from Dates-Duration View
    if (self.isDateStart) {
        self.calCalc.startDate = self.DatePicker.date;
    } else {
        self.calCalc.endDate = self.DatePicker.date;
    }
    [self dismiss:sender];
}

- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
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
    if(self.isEventDate) {
        self.pickEventButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Set Date Picker
    if (self.isEventDate) {
        self.DatePicker.date = self.calCalc.startDate;
        self.navigationItem.title = @"Set Event Date";       
        return;
    }
    
    if (self.isDateStart) {
        self.DatePicker.date = self.calCalc.startDate;
        self.navigationItem.title = @"Set Start Date";
    } else {
        self.navigationItem.title = @"Set End Date";
        self.DatePicker.date = self.calCalc.endDate;
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     // Use the segue to set the date on the view controller DatePickers
     // Push seque:
     if ([segue.identifier isEqualToString:@"PickEvent"]) {
         SVKEventsTableViewController *eventsTableController = (SVKEventsTableViewController *)segue.destinationViewController;
         eventsTableController.isPickingFromDatePicker = YES;
         eventsTableController.isDateStart = self.isDateStart;
         eventsTableController.calCalcBuffer = self.calCalc;
     }
 }


/*
#pragma mark - Event date picker
- (instancetype)initForEventWithDate:(NSDate*)eventDate
{
    self = [super initWithNibName:nil bundle:nil];
    
    
    if (self) {
        self.navigationItem.title = @"Set Event Date";
        self.isEventDate = YES;
    }
    
    return self;
}
*/
@end
