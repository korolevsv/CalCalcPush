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

@end

@implementation SVKEventsTableViewController

- (IBAction)addNewItem:(id)sender
{
    // Create a new BNRItem and add it to the store
    SVKEvent *newDate = [[SVKEventStore sharedStore] createEvent];
    
    // Figure out where that item is in the array
    NSInteger lastRow = [[[SVKEventStore sharedStore] allEvents] indexOfObject:newDate];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // Insert this new row into the table.
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}


// Make init the Designated initializer:
- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];

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
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Events";
    
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
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    NSArray *events = [[SVKEventStore sharedStore] allEvents];
    SVKEvent *event = events[indexPath.row];
    
//    cell.textLabel.text = [date description];
    // Configure the cell with the BNRItem
    cell.nameLabel.text = event.eventName;
    cell.dateLabel.text = [event dateDescription];
    cell.timeLabel.text = [event timeDescription];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Later make this method to return selected EventDate to DatesIntervalView !!!
    SVKDetailViewController *detailViewController =
    [[SVKDetailViewController alloc] init];
    NSArray *dates = [[SVKEventStore sharedStore] allEvents];
    SVKEvent *selectedDate = dates[indexPath.row];
    detailViewController.event = selectedDate;
        
    // Push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
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
