//
//  ViewController.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <MapKit/MapKit.h>
#import "AGTSimpleCoreDataStack.h"

@interface ViewController : UIViewController <UISearchBarDelegate,MKMapViewDelegate, CLLocationManagerDelegate>

// Property for the model, to be initialized when the app start
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

@property (weak, nonatomic) IBOutlet UIView *viewMapContainer;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
- (IBAction)locateMe:(id)sender;
@end
