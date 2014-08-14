//
//  SVKPickerViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 12.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKDatePickerViewController.h"
#import "SVKCalCalc.h"

@interface SVKDatePickerViewController ()

@end

@implementation SVKDatePickerViewController
- (IBAction)doneButton:(id)sender {
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
    
    // Set Date Picker
    if (self.isDateStart) {
        self.DatePicker.date = self.calCalc.startDate;
        self.navigationItem.title = @"Set Start Date";
    } else {
        self.navigationItem.title = @"Set End Date";
        self.DatePicker.date = self.calCalc.endDate;
    }
}
@end
