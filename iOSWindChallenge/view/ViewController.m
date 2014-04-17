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
#import "DetailWeatherCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserHereTrackingAnnotation.h"
#import "CityAnnotation.h"
#import "JHMCity.h"
#import "UtilRestkit.h"

@interface ViewController ()


@property (nonatomic,strong) City * selectedCityForecast;
@property (nonatomic,strong)  CLLocation * currentLocation;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic,strong)  CLLocationManager * locationManager;
@property (strong, nonatomic) NSArray * cities;
@property (nonatomic,strong) NSMutableArray * CityVenues;
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
    UtilRestkit * restkit = [[UtilRestkit alloc]init];
    [restkit configureRestKit];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.theSearchBar setHidden:NO];
    [self.theSearchBar setDelegate:self];
    

    
    // Setting delegate
    self.mapView.delegate = self;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City"
                                              inManagedObjectContext:self.model.context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [self.model.context executeFetchRequest:fetchRequest error:&error];
    for (JHMCity * favoriteCity in fetchedObjects) {
        NSLog(@"Name: %@", favoriteCity.name);
        
        City * city = [[City alloc] init];
        city.idCity=favoriteCity.idCity;
        city.name=favoriteCity.name;
        PFGeoPoint * geoPoint = [PFGeoPoint geoPointWithLatitude:[favoriteCity.latitude doubleValue]
                                                       longitude:[favoriteCity.longitude doubleValue]];
        
        
        CityAnnotation * cityReturnedAnnotation = [[CityAnnotation alloc]  initWithCity:city geopoint:geoPoint];
        
        cityReturnedAnnotation.title=favoriteCity.name;
        cityReturnedAnnotation.subtitle=favoriteCity.speed;
        cityReturnedAnnotation.idCity = favoriteCity.idCity;
        
        //cityReturnedAnnotation.cityData = cityReturned;
        
        [self.mapView addAnnotation:cityReturnedAnnotation];
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
            
            annotationView.image = [UIImage imageNamed:@"pin_yellow"];
     
            //Left
            UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            leftButton.frame = CGRectMake(0, 0, 23, 23);
            [leftButton setBackgroundImage:[UIImage imageNamed:@"not_fav_yet"] forState:UIControlStateNormal];
            
            annotationView.leftCalloutAccessoryView = leftButton;
            annotationView.leftCalloutAccessoryView.tag =1;
            
            // Right. Button on rightCalloutAccessoryView for segue
            UIButton *weatherButton = [UIButton buttonWithType:UIButtonTypeCustom];
            weatherButton.frame = CGRectMake(0, 0, 88, 23);
            [weatherButton setBackgroundImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
            annotationView.rightCalloutAccessoryView = weatherButton;
            annotationView.rightCalloutAccessoryView.tag=2;
        

            annotationView.canShowCallout = YES;
            

            
        }
        return annotationView;
    }
    return nil;
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annView calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"calloutAccessoryControlTapped: annotation = %@", annView.annotation);
    CityAnnotation * myAnn = (CityAnnotation *) annView.annotation;
    NSLog(@"Log Debug Trace ::: cityData.idCity : %@",   myAnn.cityData.idCity);

    self.selectedCityForecast = myAnn.cityData;
    

    
    if ([control tag] == 1) {
        
        NSLog(@"tap 1");
        NSLog(@"Log Debug Trace ::: LATITUDE : %@",   myAnn.cityData.coordinate.lat);

        NSLog(@"botton clickado:: self.selectedCityForecast :: %i", [control tag]);
       
        JHMCity * newCity = [JHMCity cityWithName:self.selectedCityForecast.name
                             idCity:self.selectedCityForecast.idCity
                                    longitudeCity:self.selectedCityForecast.coordinate.lon
                                     latitudeCity:self.selectedCityForecast.coordinate.lat
                                   temperatureNow:0
                                         speedNow:self.selectedCityForecast.wind.speed
                                      pressureNow:0
                                          gustNow:0
                                    degreesNow:self.selectedCityForecast.wind.degrees
                                          context:self.model.context];
        
        
        [self.model saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error saving %s \n\n %@",__func__, error);
        }];
        
        [SVProgressHUD showSuccessWithStatus:@"New Favorite Added"];
        
    } else if ([control tag] == 2) {
        // "Right Accessory Button Tapped
        [self performSegueWithIdentifier:@"showDetailViewController" sender:self];

    }
    
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
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Allocate a reachability object
    if([reach isReachable]) {
        
        
        
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

#pragma mark - IBActions
- (IBAction)locateMe:(id)sender {
    [self zoomToLocation:self.currentLocation radius:2000];
    
}

@end
