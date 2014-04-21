
//
//  AlertsViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "AlertsViewController.h"
#import "JHMCity.h"
#import "JHMAlert.h"
#import "AddAlertViewController.h"
@interface AlertsViewController ()
@property (strong, nonatomic) NSArray * alertsFetchedForCity;

@end

@implementation AlertsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];

    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setTitle:[NSString stringWithFormat:@"Alerts for %@", self.selectedCity.name]];

    NSLog(@"Log Debug Trace ::: self.selectedCity.name : %@", self.selectedCity.name);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alert"
                                              inManagedObjectContext:self.model.context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.alertsFetchedForCity = [self.model.context executeFetchRequest:fetchRequest error:&error];

    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  //  return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];

    return [self.alertsFetchedForCity count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    JHMAlert * alert  = (JHMAlert *) [self.alertsFetchedForCity objectAtIndex:indexPath.row];
    // Get list of local notifications
//    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
//    UILocalNotification *localNotification = [localNotifications objectAtIndex:indexPath.row];
//    
    // Display notification info
//    [cell.textLabel setText:localNotification.alertBody];
//    [cell.detailTextLabel setText:[localNotification.fireDate description]];
  
    [cell.textLabel setText:alert.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"Between %i and %i degrees", [alert.degreesMin intValue],[alert.degreesMax intValue]]];
    return cell;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showAddAlert"]) {
        AddAlertViewController * addAlertViewController = (AddAlertViewController *) segue.destinationViewController;
        addAlertViewController.selectedCity  = self.selectedCity;
    }
}

@end
