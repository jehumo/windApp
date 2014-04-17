//
//  DetailWeatherCityViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "DetailWeatherCityViewController.h"
#import "WindPredictionCell.h"
#import "Wind.h"
#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController.h"

@interface DetailWeatherCityViewController ()

@property (strong, nonatomic) NSArray * windPredictions;

@end

@implementation DetailWeatherCityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    ViewController * vc =[[ViewController alloc]init];
    
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController setTitle:[NSString stringWithFormat:@"%@ forecast",self.selectedCity.name]];
    
    
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
    cellWindPrediction.theTitle.text=windPrediction.speed;
    
//    City * city = [self.cities objectAtIndex:indexPath.row];
    // Map into my City Object
//    cell.theTitle.text = city.name;
    //            //set point of rotation
    //            imgViewLeft.center = CGPointMake(100.0, 100.0);
    //
    //            //rotate rect
    //            annotationView.transform = CGAffineTransformMakeRotation([aCityAnnotation.cityData.wind.degrees doubleValue]); //rotation in radians
    //
    //            [leftCAV addSubview  :favoriteButton];
    //            //[leftCAV addSubview : yourFirstLabel];
    
    
    //            //[leftCAV addSubview : yourSecondLabel];

    return cellWindPrediction;
}
#pragma mark - Restkit Setup

- (void)configureSecondRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    // 1. Wind Mapping
    RKObjectMapping * windMapping = [RKObjectMapping mappingForClass:[Wind class]];
    [windMapping addAttributeMappingsFromDictionary:@{
                                                      @"speed":@"speed",
                                                      @"deg":@"degrees",
                                                      @"dt":@"dt"
                                                      }];
  
    // register mappings with the provider using a response descriptor
    // api.openweathermap.org/data/2.5/forecast/daily?id=524901&cnt=15
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:windMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"data/2.5/forecast/daily"
                                                                                           keyPath:@"list"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
}


-(void) loadWindPredictions {
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    [self configureSecondRestKit];
    // Allocate a reachability object
    if([reach isReachable]) {
        

        
        
        NSDictionary *queryParams = @{
                                      @"id" : @"524901"
                                      };
        [SVProgressHUD show];
        
        //http://api.openweathermap.org/data/2.5/forecast/daily?id=524901&lang=zh_cn
        //http://api.openweathermap.org/2.5/forecast/daily?id=524901&mode=json
        //http://api.openweathermap.org/data/2.5/forecast/daily?id=524901
        
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




@end
