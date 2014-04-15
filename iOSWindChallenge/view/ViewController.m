//
//  ViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "ViewController.h"
#import "City.h"
#import "Coordinate.h"
#import "Weather.h"
#import "Wind.h"

#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    
        self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // En la busqueda se queda siempre visible
    [self.theSearchBar setHidden:NO];
    [self.theSearchBar setDelegate:self];
    
    //[[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"Cancelar" forState:UIControlStateNormal];
//    [self.viewTableContainer setHidden:NO];
//    [self.viewMapContainer setHidden:YES];
//    if (![self.locationController isLocationAuthoritationEnabled]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ajustes de la aplicación"
//                                                        message:@"Por favor, active la geolocalización en su iPhone"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCity:(id)sender {


//    JHMCity * newCity = [JHMCity cityWithName:self.cityNameTextField.text
//                                longitudeCity:[NSNumber numberWithDouble:-3.1]
//                                 latitudeCity:[NSNumber numberWithDouble:44.1]
//                               temperatureNow:[NSNumber numberWithDouble:12.2]
//                                     speedNow:[NSNumber numberWithDouble:69.69]
//                                  pressureNow:[NSNumber numberWithDouble:1024.24]
//                                      gustNow:[NSNumber numberWithDouble:12.12]
//                                   degreesNow:[NSNumber numberWithDouble:12.12]
//                                      context:self.model.context];
//    
//    
//    [self.model saveWithErrorBlock:^(NSError *error) {
//        NSLog(@"Error saving %s \n\n %@",__func__, error);
//    }];
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setText:@"Londres"];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];

    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Configuramos los dos bloques de código para los cambios de estado
    // de la conectividad
    // En el main thread, capturamos los eventos.
    
    // Allocate a reachability object
    
    if([reach isReachable]) {
        
        [self configureRestKit];
        
        
        NSDictionary *queryParams = @{
                                      @"q" : [theSearchBar text],
                                      @"mode" : @"json"
                                      };
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/data/2.5/find"
                                               parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      
                                                      NSArray * resultCities = mappingResult.array;
                                                      City * resultCity = (City *)[resultCities objectAtIndex:0];
                                                      
                                                      NSLog(@"Exito!!!!!!");
                                                      NSLog(@"Log Debug Trace ::: resultCity.name : %@", resultCity.name);
                                                      NSLog(@"Log Debug Trace ::: rresultCity.coordinate.lat: %@", resultCity.coordinate.lat);
                                                      NSLog(@"Log Debug Trace ::: resultCity.coordinate.lon: %@", resultCity.coordinate.lon);


                                                      
                                                      //_venues = mappingResult.array;
                                                      //[self.tableView reloadData];
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      NSLog(@"Log Error Trace :::Operation Failed %@", error);
                                                  }];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"There is not an Internet Connection"];
        
    }
}


- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    // 1. CityMapping
    RKObjectMapping *cityMapping = [RKObjectMapping mappingForClass:[City class]];
    [cityMapping addAttributeMappingsFromArray:@[@"name"]];
    [cityMapping addAttributeMappingsFromDictionary:@{@"id":@"idCity" }];

    // 2. Coordinate Mapping
    RKObjectMapping *coordinateMapping = [RKObjectMapping mappingForClass:[Coordinate class]];
    [coordinateMapping addAttributeMappingsFromArray:@[@"lat", @"lon"]];
    
    // Linking abd defining relationship mapping
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord"
                                                                                toKeyPath:@"coordinate"
                                                                              withMapping:coordinateMapping]];
    
    // 3. Wind Mapping
    RKObjectMapping * windMapping = [RKObjectMapping mappingForClass:[Wind class]];
    [windMapping addAttributeMappingsFromDictionary:@{
                                                         @"speed":@"speed",
                                                        @"deg":@"degrees"
                                                            }];
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind"
                                                                                toKeyPath:@"wind"
                                                                              withMapping:windMapping]];
    

    // 4. Weather Mapping
    RKObjectMapping * weatherMapping = [RKObjectMapping  mappingForClass:[Weather class]];
    [weatherMapping addAttributeMappingsFromDictionary:@{
                                                        //@"temp": @"temperature",
                                                        @"main":@"mainDescription",
                                                        @"icon":@"icon"
                                                         }];
    [cityMapping addPropertyMapping:[RKRelationshipMapping  relationshipMappingFromKeyPath:@"weather"
                                                                                toKeyPath:@"weather"
                                                                              withMapping:weatherMapping]];
    

    
    
    

    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:cityMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"data/2.5/find"
                                                                                           keyPath:@"list"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
}
@end
