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
@property (nonatomic, strong) NSString * alertName;
@property (nonatomic, strong) JHMAlert * alert;
@end

@implementation AddAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.minLabel.text=@"0";
    self.maxLabel.text=@"359";
    
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
    if ([self.speedAlertTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Wind speed must be introduced"];
        [self.speedAlertTextField becomeFirstResponder];

    }
    else {
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
            
            
            JHMCity * city = (JHMCity *) [fetchedObjects objectAtIndex:0];
            self.alertName = [NSString stringWithFormat:@"Wind speed of %@ greater than %@",city.name,self.speedAlertTextField.text];
            self.alert = [JHMAlert alertAnyDirectionWithName:self.alertName
                                                    withCity:city
                                                speedTrigger:[f numberFromString:self.speedAlertTextField.text]
                                                  minDegrees:[f numberFromString:self.minLabel.text]
                                                  maxDegrees:[f numberFromString:self.maxLabel.text]
                                                     context:self.model.context];
            [self.model saveWithErrorBlock:^(NSError *error) {
                NSLog(@"Error saving %s \n\n %@",__func__, error);
            }];
            
            [self startNotificationsCron];
            
            [SVProgressHUD showSuccessWithStatus:@"New Alert Added"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }

    }
}
#pragma mark - Handle notifications

- (void)clearNotifications {
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}


- (void) startNotificationsCron {
	
    
    // Just for avoid multiple crons, clean previous notification cron and schedule a new one
    [self clearNotifications];
    
    // Schedule a periodic cron
    // TODO set 1 houeralert
	Class cls = NSClassFromString(@"UILocalNotification");
	if (cls != nil) {
		
		UILocalNotification *notif = [[cls alloc] init];
		notif.fireDate = [[NSDate date]dateByAddingTimeInterval:30.0]; // The first one will be in 30 seconds
		notif.timeZone = [NSTimeZone defaultTimeZone];
        notif.soundName = UILocalNotificationDefaultSoundName;
		notif.applicationIconBadgeNumber = 1;
		
        // The local notification will be launched every minute
        notif.repeatInterval = NSMinuteCalendarUnit;
		
		NSDictionary *userDict = [NSDictionary dictionaryWithObject:self.alertName
                                                             forKey:@"PERIODIC_ALERT"];
		notif.userInfo = userDict;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:notif];

	}
}


@end
