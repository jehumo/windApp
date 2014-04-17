//
//  AlertsViewController.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "AGTSimpleCoreDataStack.h"

@interface AlertsViewController : UITableViewController


@property (nonatomic, strong) City * selectedCity;
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;

@end
