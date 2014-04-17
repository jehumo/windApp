//
//  DetailWeatherCityViewController.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "ViewController.h"
#import "City.h"

@interface DetailWeatherCityViewController : ViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *configureAlertsButton;

@property (nonatomic, strong) City * selectedCity;

@property (weak, nonatomic) IBOutlet UIView *viewTableContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

