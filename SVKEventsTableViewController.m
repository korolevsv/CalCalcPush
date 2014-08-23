//
//  SVKDatesTableViewController.m
//  CalCalcPush
//
//  Created by Sergey Korolev on 14.08.14.
//  Copyright (c) 2014 SelfEducation. All rights reserved.
//

#import "SVKEventsTableViewController.h"
#import "SVKEvent.h"
#import "SVKEventStore.h"
#import "SVKDetailViewController.h"
#import "SVKEventCell.h"

@interface SVKEventsTableViewController ()

@property UIColor *colorTextInteracive;
@property UIColor *colorTextNoninteractive;

@end

@implementation SVKEventsTableViewController

- (IBAction)addNewEvent:(id)sender
{
    // Create a new BNRItem and add it to the store
    SVKEvent *newEvent = [[SVKEventStore sharedStore] createEvent];
    
/*
    // Figure out where that item is in the array
    NSInteger lastRow = [[[SVKEventStore sharedStore] allEvents] indexOfObject:newEvent];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
*/
    SVKDetailViewController *detailViewController =
    [[SVKDetailViewController alloc] initForNewEvent:YES];
    
    detailViewController.event = newEvent;
    [detailViewController setEventTitle:newEvent];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    
    [self presentViewController:navController animated:YES completion:nil];
}


// Make init the Designated initializer:
- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    self.isPickingFromDatePicker = NO;
    
    return self;
}



- (instancetype)initWithStyle:(UITableViewStyle)style
{

    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    _colorTextNoninteractive = [UIColor blackColor];
    UIColor *colorTextInteractive = [UIColor colorWithRed:0
                                                    green:0.478431
                                                     blue:1
                                                    alpha:1.0];
    _colorTextInteracive = colorTextInteractive;
    
    // Called from DatePicker or Events Tab?
    if (self.isPickingFromDatePicker) {
        self.navigationItem.title = @"Pick Event";
    } else {
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.title = @"Events";
    }
    
    // Load the NIB file
    UINib *nib = [UINib nibWithNibName:@"SVKEventCell" bundle:nil];
    
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"SVKEventCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[SVKEventStore sharedStore] allEvents] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a new or recycled cell
    SVKEventCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"SVKEventCell"
                                    forIndexPath:indexPath];
    // Set cell accessory type
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    // Show if cell is active for picking event
    if (self.isPickingFromDatePicker) {
        cell.nameLabel.textColor = _colorTextInteracive;
    } else {
        cell.nameLabel.textColor = _colorTextNoninteractive;
    }
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    // Configure the cell with the BNRItem
    NSArray *events = [[SVKEventStore sharedStore] allEvents];
    SVKEvent *event = events[indexPath.row];
    cell.nameLabel.text = event.eventName;
    cell.dateLabel.text = [event dateDescription];
    cell.timeLabel.text = [event timeDescription];
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
//    SVKDetailViewController *detailViewController = [[SVKDetailViewController alloc] init];
    SVKDetailViewController *detailViewController = [[SVKDetailViewController alloc] initForNewEvent:NO];
    
    NSArray *events = [[SVKEventStore sharedStore] allEvents];
    SVKEvent *selectedEvent = events[indexPath.row];
    detailViewController.event = selectedEvent;
    [detailViewController setEventTitle:selectedEvent];
    
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Use this selection to set Event as start or end date
    if (self.isPickingFromDatePicker) {
        NSArray *events = [[SVKEventStore sharedStore] allEvents];
        SVKEvent *selectedEvent = events[indexPath.row];
     
        if (self.isPickingFromDatePicker) {
            if (self.isDateStart) {
                self.calCalcBuffer.startDate = selectedEvent.eventDate;
            } else {
                self.calCalcBuffer.endDate = selectedEvent.eventDate;
            }
        }

        [self.presentingViewController dismissViewControllerAnimated:YES
                                                          completion:nil];

        // Push it onto the top of the navigation controller's stack
//        [self.navigationController pushViewController:detailViewController
//                                             animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSArray *eDates = [[SVKEventStore sharedStore] allEvents];
        SVKEvent *eDate = eDates[indexPath.row];
        [[SVKEventStore sharedStore] removeEvent:eDate];
        
        // Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[SVKEventStore sharedStore] moveEventAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
