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





@interface ViewController : UIViewController <UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate,MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;

// Property for the model, to be initialized when the app start
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;

@property (assign, nonatomic) BOOL  modeShowingBarSearch;
@property (weak, nonatomic) IBOutlet UIView *viewTableContainer;
@property (weak, nonatomic) IBOutlet UIView *viewMapContainer;

- (IBAction)locateMe:(id)sender;

@end
