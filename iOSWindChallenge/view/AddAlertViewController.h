//
//  AddAlertViewController.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "AGTSimpleCoreDataStack.h"

@interface AddAlertViewController : UIViewController
@property (nonatomic, strong) City * selectedCity;
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;
@property (weak, nonatomic) IBOutlet UISlider *minSelector;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UIImageView *minWindImageView;

@property (weak, nonatomic) IBOutlet UISlider *maxSelector;
@property (weak, nonatomic) IBOutlet UIImageView *maxWindImageView;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UITextField *speedAlertTextField;

@end
