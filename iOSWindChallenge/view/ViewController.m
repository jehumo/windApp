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
#import "CityCell.h"
#import "DetailWeatherCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserHereTrackingAnnotation.h"
#import "CityAnnotation.h"

@interface ViewController ()


@property (nonatomic,strong) City * selectedCityForecast;
@property (nonatomic,strong)  CLLocation * currentLocation;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic) CLLocationDistance distanceToFarestCity;
@property (nonatomic,strong)  CLLocationManager * locationManager;
@property (strong, nonatomic) NSArray * cities;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic,strong) NSMutableArray * CityVenues;
@property (nonatomic,strong) NSMutableArray * closestCityVenues;
//@property (nonatomic,strong) CLLocation * hereLocation;
@property (nonatomic,strong) CLLocation * foundLocation;
@property (nonatomic, strong) MKLocalSearch *localSearch;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    [self.locationManager startUpdatingLocation];
    
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.theSearchBar setHidden:NO];
    [self.theSearchBar setDelegate:self];
//    [self.viewTableContainer setHidden:NO];
//    [self.viewMapContainer setHidden:YES];
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    // Init my own location controller and defining this class as the delegate
//    self.locationController = [[CustomLocationManager alloc]init];
//    self.locationController.delegate = self;
//    [self.locationController startStandardUpdates];
    
    
    // Setting delegate
    self.mapView.delegate = self;
    
    
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
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Failed to Get Your Location"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    self.currentLocation  = [locations lastObject];
    PFGeoPoint * aPFGeoPoint = [PFGeoPoint geoPointWithLatitude:self.currentLocation.coordinate.latitude
                                                      longitude:self.currentLocation.coordinate.longitude];
    
    
    UserHereTrackingAnnotation * userHereDirectionAnnotation = [[UserHereTrackingAnnotation alloc]initWithUserGeoPoint:aPFGeoPoint];
    userHereDirectionAnnotation.title = @"You are here";
    
    //CLLocationDistance distanceFromFoundPlace = [self.foundLocation distanceFromLocation:self.currentLocation];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mapView addAnnotation:userHereDirectionAnnotation];
        
        [self locateMe:self];
    });
    
    
    [self.locationManager stopUpdatingLocation];

    
}

#pragma mark - mapkit
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isMemberOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isMemberOfClass:[UserHereTrackingAnnotation class]])
    {
        static NSString * const identifier = @"UserHereAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView){
            annotationView.annotation = annotation;
        } else {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
        }
        
        // set your annotationView properties
        
        annotationView.image = [UIImage imageNamed:@"me_location"];
        annotationView.canShowCallout = YES;
        
        return annotationView;
    } if ([annotation isMemberOfClass:[CityAnnotation class]])
    {
        static NSString * const identifier = @"CityAnnotation";
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        CityAnnotation * aCityAnnotation= (CityAnnotation*) annotation;
        
        if (annotationView) {
            annotationView.annotation = aCityAnnotation;
        }
        else {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:aCityAnnotation
                                                          reuseIdentifier:identifier];
            
            annotationView.image = [UIImage imageNamed:@"pin"];
            
            
            

            // leftCalloutAccessoryView. Image wind rotated
            UIView *leftCAV = [[UIView alloc] initWithFrame:CGRectMake(0,0,23,23)];
            //UIImageView * imgViewLeft = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fav"]];
            
            UIButton * favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            favoriteButton.frame = CGRectMake(0, 0, 23, 23);
            [favoriteButton setBackgroundImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
            //annotationView.leftCalloutAccessoryView = favoriteButton;
//            //set point of rotation
//            imgViewLeft.center = CGPointMake(100.0, 100.0);
//            
//            //rotate rect
//            annotationView.transform = CGAffineTransformMakeRotation([aCityAnnotation.cityData.wind.degrees doubleValue]); //rotation in radians
//            
            [leftCAV addSubview  :favoriteButton];
//            //[leftCAV addSubview : yourFirstLabel];
//            //[leftCAV addSubview : yourSecondLabel];
            annotationView.leftCalloutAccessoryView = leftCAV;
            annotationView.canShowCallout = YES;
            
            

            
            // Right. Button on rightCalloutAccessoryView for segue
            UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
            weatherButton.frame = CGRectMake(0, 0, 88, 23);
            [weatherButton setBackgroundImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
            annotationView.rightCalloutAccessoryView = weatherButton;
        


            
        }
        return annotationView;
    }
//    if ([annotation isMemberOfClass:[UserFoundDirectionAnnotation class]])
//    {
//        static NSString * const identifier = @"UserFoundDirection";
//        
//        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//        if (annotationView) {
//            annotationView.annotation = annotation;
//        } else{
//            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:identifier];
//        }
//        
//        annotationView.image = [UIImage imageNamed:@"map_direction"];
//        annotationView.canShowCallout = YES;
//        
//        return annotationView;
//    }
//    
    
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annView calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped: annotation = %@", annView.annotation);
    CityAnnotation * myAnn = (CityAnnotation *) annView.annotation;
    NSLog(@"Log Debug Trace ::: cityData.idCity : %@",   myAnn.cityData.idCity);

    self.selectedCityForecast = myAnn.cityData;
    
    [self performSegueWithIdentifier:@"showDetailViewController" sender:self];
    
}
- (void)zoomToLocation:(CLLocation *)location radius:(CGFloat)radius {
    NSLog(@"Zoomming to this radius %f",radius);
    
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.65
                              delay:0
                            options:options
                         animations:^{
                             MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 2 * radius, 2 *radius);
                             @try {
                                 [self.mapView setRegion:region animated:YES];
                             }
                             @catch (NSException *exception) {
                                 
                                 UIAlertView * message = [[UIAlertView alloc]initWithTitle:@"Localization Error"
                                                                                   message:@"Not posible to zoom in in this localization"
                                                                                  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                 [message show];
                             }
                        }
                        completion:nil
         ];
    });
    
}


#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setText:@"Cadiz"];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
//    [self.tableView setHidden:NO];
    
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
        //[SVProgressHUD show];
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/data/2.5/find"
                                               parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      
                                                      [SVProgressHUD dismiss];
                                                      self.cities = mappingResult.array;
                                                      
                                                      if (self.cities.count >0 ) {
                                                          [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"Found %@",self.theSearchBar.text]];
                                                          
                                                          City * cityReturned = (City *) [self.cities objectAtIndex:0];
                                                          CLLocation * cityReturnedLocation = [[CLLocation alloc] initWithLatitude:[cityReturned.coordinate.lat
 doubleValue]
                                                                                                                         longitude:[cityReturned.coordinate.lon doubleValue]];
                                                          
                                                          NSLog(@"Exito!!!!!!");
                                                          NSLog(@"Log Debug Trace ::: cityReturned : %@", cityReturned.name);
                                                          CLLocation * hereLocation = [[CLLocation alloc] initWithLatitude:self.currentLocation.coordinate.latitude
                                                                                                                        longitude:self.currentLocation.coordinate.longitude];
                                                          
                                                          
                                                          PFGeoPoint * geoPoint = [PFGeoPoint geoPointWithLatitude:[cityReturned.coordinate.lat doubleValue]
                                                                                                         longitude:[cityReturned.coordinate.lon doubleValue]];
                                                          
//                                                          CityAnnotation * currentCityAnnotation = [[CityAnnotation alloc] initWithUserGeoPoint:geoPoint];
                                                          
                                                          
                                                          
                                                          cityReturned.distance = [self.currentLocation distanceFromLocation:cityReturnedLocation];
                                                          

                                                          CityAnnotation * cityReturnedAnnotation = [[CityAnnotation alloc]  initWithCity:cityReturned geopoint:geoPoint];
                                                          
                                                          cityReturnedAnnotation.title=cityReturned.name;
                                                          cityReturnedAnnotation.subtitle=cityReturned.wind.speed;
                                                          cityReturnedAnnotation.idCity = cityReturned.idCity;

                                                          //cityReturnedAnnotation.cityData = cityReturned;
                                                          
                                                          [self.mapView addAnnotation:cityReturnedAnnotation];
                                                          
                                                          
                                                          [self zoomToLocation:hereLocation radius:cityReturned.distance];
                                                          
                                                          //[self.tableView reloadData];

                                                      } else {
                                                          //[self.tableView setHidden:NO];
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cities.count;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CityCell"];
//    self.selectedCity= [self.cities objectAtIndex:indexPath.row];
    
//    [self.viewTableContainer setHidden:YES];
//    [self.viewMapContainer setHidden:NO];

    
 //   CLLocation * currentCityLocation = [[CLLocation alloc] initWithLatitude:[self.selectedCity.coordinate.lat doubleValue]
 //                                       longitude:[self.selectedCity.coordinate.lon doubleValue]];
    
    
 //   PFGeoPoint * geoPoint = [PFGeoPoint geoPointWithLatitude:[self.selectedCity.coordinate.lat doubleValue]
 //                                                  longitude:[self.selectedCity.coordinate.lon doubleValue]];
 //   CityAnnotation * currentCityAnnotation = [[CityAnnotation alloc] initWithUserGeoPoint:geoPoint];
    
    
    
//    self.selectedCity.distance = [self.currentLocation distanceFromLocation:currentCityLocation];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.mapView addAnnotation:currentCityLocation];
//        [self zoomToLocation:self.currentLocation radius:self.selectedCity.distance];
//    });
    
    
//    [self performSegueWithIdentifier:@"showDetailViewController" sender:self];
    
}


/**
 * This function prepare the segue, by loading the parameters properly.
 * (Prepare the specific segue to be loaded by comparing the segue identifier.)
 *
 * @param segue
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetailViewController"]) {
        DetailWeatherCityViewController * detailViewController = (DetailWeatherCityViewController *) segue.destinationViewController;
        detailViewController.selectedCity   = self.selectedCityForecast;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 47;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
    City * city = [self.cities objectAtIndex:indexPath.row];
    // Map into my City Object
    cell.theTitle.text = city.name;
    
    return cell;
}

#pragma mark - IBActions
- (IBAction)locateMe:(id)sender {
    [self zoomToLocation:self.currentLocation radius:2000];
    
}

@end
