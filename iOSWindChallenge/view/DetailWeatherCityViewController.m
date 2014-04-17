//
//  DetailWeatherCityViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#import "DetailWeatherCityViewController.h"
#import "WindPredictionCell.h"
#import "Wind.h"
#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController.h"
#import "JHMCity.h"
#import "AlertsViewController.h"

@interface DetailWeatherCityViewController ()

@property (strong, nonatomic) NSArray * windPredictions;

@end

@implementation DetailWeatherCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City"
                                              inManagedObjectContext:self.model.context];
    [fetchRequest setEntity:entity];
    
    NSPredicate * predicateByIdCity = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"idCity=%@",self.selectedCity.idCity]];
    
    [fetchRequest setPredicate:predicateByIdCity];
    
    NSError *error;
    NSArray *fetchedObjects = [self.model.context executeFetchRequest:fetchRequest error:&error];
    
    if ((fetchedObjects == nil) || ([fetchedObjects count] == 0)) {
        
        [self.configureAlertsButton setEnabled:NO];
        
    } else {
        [self.configureAlertsButton setEnabled:YES];
        
    }
    

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setTitle:[NSString stringWithFormat:@"Wind prediction for %@", self.selectedCity.name]];
    [self loadWindPredictions ];

    NSLog(@"Log Debug Trace ::: self.selectedCity.name : %@", self.selectedCity.name);
    NSLog(@"Log Debug Trace :::     self.selectedCity.idCity : %@",     self.selectedCity.idCity);
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
    return self.windPredictions.count;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WindPredictionCell  *cellWindPrediction = [tableView dequeueReusableCellWithIdentifier:@"WindPredictionCell"];
    Wind * windPrediction = [self.windPredictions objectAtIndex:indexPath.row];

    
    cellWindPrediction.windImageView.center = CGPointMake(100.0, 100.0);
    //rotate rect
    cellWindPrediction.windImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS([windPrediction.degrees doubleValue])); //rotation in radians
    
    
    
    // Convert dt Epoch from NSString to NSTimeInterval
    NSTimeInterval seconds = [windPrediction.dt doubleValue];
    
    // (Step 1) Create NSDate object
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    // (Step 2) Use NSDateFormatter to display epochNSDate in local time zone
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd "];
    
    cellWindPrediction.theTitle.text=[NSString stringWithFormat:@"%@  Wind Speed :%@",[dateFormatter stringFromDate:epochNSDate], windPrediction.speed];

    
    
    return cellWindPrediction;
}


-(void) loadWindPredictions {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Allocate a reachability object
    if([reach isReachable]) {
        

        
        
        NSDictionary *queryParams = @{
                                      @"id" : @"524901"
                                      };
        [SVProgressHUD show];
        
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/data/2.5/forecast/daily"
                                               parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      
                                                      [SVProgressHUD dismiss];
                                                      
                                                      self.windPredictions = mappingResult.array;
                                                      
                                                      if (self.windPredictions.count >0 ) {
                                                          [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Found %i predictions",self.windPredictions.count ]];
                                                            [self.tableView reloadData];
                                                          
                                                      }
                                                      else {

                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [SVProgressHUD showErrorWithStatus:
                                                               [NSString stringWithFormat:
                                                                @"The server could not find any city named with %@",self.theSearchBar.text] ];
                                                          });
                                                          
                                                      }
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      NSLog(@"Log Error Trace :::Operation Failed %@", error);
                                                      [SVProgressHUD showErrorWithStatus:
                                                       [NSString stringWithFormat:
                                                        @"Error getting data for %@",self.theSearchBar.text] ];
                                                  }];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"There is not an Internet Connection"];
        
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showAlertController"]) {
        AlertsViewController * alertsViewController = (AlertsViewController *) segue.destinationViewController;
        alertsViewController.selectedCity  = self.selectedCity;
    }
}


@end
