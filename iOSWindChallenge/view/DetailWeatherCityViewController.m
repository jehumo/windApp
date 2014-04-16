//
//  DetailWeatherCityViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "DetailWeatherCityViewController.h"

@interface DetailWeatherCityViewController ()

@end

@implementation DetailWeatherCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController setTitle:[NSString stringWithFormat:@"%@ forecast",self.selectedCity.name]];
    NSLog(@"Log Debug Trace ::: self.selectedCity.name : %@", self.selectedCity.name);
    NSLog(@"Log Debug Trace :::     self.selectedCity.idCity : %@",     self.selectedCity.idCity);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
