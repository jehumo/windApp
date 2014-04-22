//
//  AppDelegate.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTSimpleCoreDataStack.h"
#import <CoreData/CoreData.h>
#import "JHMWindDirectionsCatalog.h"
#import "JHMCity.h"
#import "JHMAlert.h"
#import "WeatherFetcher.h"

#import "City.h"
#import "Coordinate.h"
#import "Weather.h"
#import "Wind.h"
#import <Reachability/Reachability.h>
#import <RestKit/RestKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UtilRestkit.h"
#import "WeatherFetcher.h"

@interface AppDelegate ()
@property (strong, nonatomic) NSArray * alertsFetchedForCity;
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Create a custom interface with the color of piksel logo
    [self customizeAppearance];
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    // Handle launching from a notification
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
    }
    
    return YES;
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // 1. Load all the alerts and ask to the service if one city of the Entity alert, has a wind speed greater than the one that was defined by the user in his specific direction
    
    UIApplicationState state = [application applicationState];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Allocate a reachability object
    if([reach isReachable]) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Alert"
                                                  inManagedObjectContext:self.model.context];
        


        [fetchRequest setEntity:entity];
        NSError *error;
        self.alertsFetchedForCity = [self.model.context executeFetchRequest:fetchRequest error:&error];
        for (JHMAlert * entityAlert in self.alertsFetchedForCity) {

            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"City"
                                                      inManagedObjectContext:self.model.context];
            [fetchRequest setEntity:entity];
            NSArray *fetchedObjects = [self.model.context executeFetchRequest:fetchRequest error:&error];
            
            __block NSString * messsageAllTitlesAlert=@"";
            __block NSString * messsageAllMessagesAlert=@"";
            
            for (JHMCity * cityAlert in fetchedObjects) {
                NSLog(@"Name: %@", cityAlert.name);
                NSLog(@"IdCity: %@", cityAlert.idCity);
                
                [[WeatherFetcher sharedInstance] fetchWeatherForLocation:cityAlert.name
                                                                  completion:^(WeatherResult *cityReturned) {
                                                                      
                                    
                                    double currentWindSpeedForCity = cityReturned.currentWindSpeedForCity;
                                    double currentWindDegreesForCity = cityReturned.currentDegreesWindSpeedForCity;
                                    
                                    NSLog(@"Log Debug Trace ::: cityReturned : %@", cityReturned.cityName);
                                    NSLog(@"Log Debug Trace ::: currentWindSpeedForCity : %f", currentWindSpeedForCity);
                                    NSLog(@"Log Debug Trace ::: currentWindDegreesForCity : %f", currentWindDegreesForCity);
                                    NSLog(@"Log Debug Trace ::: (degrees min, degrees max) : (%f,%f)", [entityAlert.degreesMin doubleValue],[entityAlert.degreesMax doubleValue]);
                                    
                                    
                                    // Comparing the values in order to trigger the alert.
                                    // Only will be triggered when is greater to the selected speed within the range degree
                                    if  ((currentWindSpeedForCity > [entityAlert.speedTrigger doubleValue] ) &&
                                         ((currentWindDegreesForCity > [entityAlert.degreesMin doubleValue] ) && (currentWindDegreesForCity < [entityAlert.degreesMax doubleValue]))) {
                                        NSString * titleAlert =[NSString stringWithFormat:@"%@ alert!\n",cityReturned.cityName];
                                        NSString * messageBody = [NSString stringWithFormat:@"Your alert %@ has been fired, current wind speed of %.1f!\n", entityAlert.name,currentWindSpeedForCity ];
                                        

                                        
                                        messsageAllTitlesAlert = [messsageAllTitlesAlert stringByAppendingString:titleAlert];
                                        messsageAllMessagesAlert = [messsageAllMessagesAlert stringByAppendingString:messageBody];
                                        
                                        
                                        if (([cityAlert isEqual:[fetchedObjects lastObject]]) && ( state == UIApplicationStateActive)) {
                                            // For better user experience. Only will show the alert when the App is active and if there is no more objects to check
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:messsageAllTitlesAlert
                                                                                                message:messsageAllMessagesAlert
                                                                                               delegate:self
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles:nil];
                                                [alert show];
                                                application.applicationIconBadgeNumber = 0;

                                        }
                                    }
                            }];
            }
        }
    }
}
    

// This only works fine with iOS 7.
//- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    NSLog(@"perform Background Fetch...");
//
//    WeatherResult *cachedResult = [[WeatherFetcher sharedInstance] cachedResult];
//    if (cachedResult) {
//        NSLog(@"background updating weather for %@", cachedResult.location);
//        [[WeatherFetcher sharedInstance] fetchWeatherForLocation:cachedResult.location
//                                                      completion:^(WeatherResult *result) {
//                                                          [application setApplicationIconBadgeNumber:1];
//                                                          [[NSNotificationCenter defaultCenter] postNotificationName:@"WeatherUpdated"
//                                                                                                              object:result];
//                                                          completionHandler(UIBackgroundFetchResultNewData);
//                                                      }];
//    } else {
//        NSLog(@"No location saved, disabling background fetch...");
//        [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
//        completionHandler(UIBackgroundFetchResultNoData);
//    }
//
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

-(void) customizeAppearance{
    
    UIColor *darkBlue = [UIColor colorWithRed:10.0/255.0
                                        green:17.0/255.0
                                         blue:31.0/255.0
                                        alpha:1];
    UIColor *darkRed = [UIColor colorWithRed:168.0 / 255
                                       green:11.0 / 255.0
                                        blue:31.0 / 255.0
                                       alpha:0.5];
    [[UITableViewHeaderFooterView appearance] setTintColor:darkBlue];
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    [[UIButton appearance] setTintColor:[UIColor orangeColor]];
    [[UITableView appearance] setSectionIndexColor:darkRed];
    
}
@end
