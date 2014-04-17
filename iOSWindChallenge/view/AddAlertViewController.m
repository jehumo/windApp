//
//  AddAlertViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#import "AddAlertViewController.h"

@interface AddAlertViewController ()

@end

@implementation AddAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setTitle:[NSString stringWithFormat:@"Aert for %@", self.selectedCity.name]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)minSliderChanged:(id)sender {
    
    NSInteger val = lround(self.minSelector.value);
    self.minLabel.text = [NSString stringWithFormat:@"%d",val];


    
    self.minWindImageView.center = CGPointMake(100.0, 100.0);
    //rotate rect
    self.minWindImageView.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(val)); //rotation in radians
   
}

- (IBAction)maxSliderChanged:(id)sender {
    NSInteger val = lround(self.minSelector.value);
    self.maxLabel.text = [NSString stringWithFormat:@"%d",val];
  
    self.maxWindImageView.center = CGPointMake(100.0, 100.0);
    //rotate rect
    self.maxWindImageView.transform = CGAffineTransformMakeRotation( DEGREES_TO_RADIANS(val)); //rotation in radians

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.speedAlertTextField resignFirstResponder];
}


- (IBAction)saveAlert:(id)sender {
    
    // Validations and save
    
    
    

}


@end
