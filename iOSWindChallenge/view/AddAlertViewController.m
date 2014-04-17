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
#import "JHMAlert.h"
#import "JHMCity.h"
#import "SVProgressHUD.h"

@interface AddAlertViewController ()

@end

@implementation AddAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setTitle:[NSString stringWithFormat:@"New alert for %@", self.selectedCity.name]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
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
    
    // Validations and save into Core Data
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City"
                                              inManagedObjectContext:self.model.context];
    [fetchRequest setEntity:entity];
    
    NSPredicate * predicateByIdCity = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"idCity=%@",self.selectedCity.idCity]];
    
    [fetchRequest setPredicate:predicateByIdCity];
    
    NSError *error;
    NSArray *fetchedObjects = [self.model.context executeFetchRequest:fetchRequest error:&error];
        

    if ((fetchedObjects == nil) || ([fetchedObjects count] == 0)) {
        
        
        [SVProgressHUD showErrorWithStatus:@"Not found any citys on data base"];
        
    } else {
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * speed = [f numberFromString:self.speedAlertTextField.text];
        
        
        JHMCity * city = (JHMCity *) [fetchedObjects objectAtIndex:0];
        
        JHMAlert * newAlert = [JHMAlert alertAnyDirectionWithName:nil
                                                         withCity:city
                                                     speedTrigger:speed
                                                          context:self.model.context];
        [self.model saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error saving %s \n\n %@",__func__, error);
        }];
        
        [SVProgressHUD showSuccessWithStatus:@"New Alert Added"];

    }
    
}


@end
