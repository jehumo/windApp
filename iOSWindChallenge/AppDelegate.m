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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create the Instance of the Core Data stack
    
    self.model = [AGTSimpleCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [self loadData];
    
    
    return YES;
}
							
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
#pragma mark - Load Data

-(void) loadData {
    JHMCity * newCity = [JHMCity cityWithName:@"CACERES"
                                longitudeCity:[NSNumber numberWithDouble:-3.1]
                                 latitudeCity:[NSNumber numberWithDouble:44.1]
                               temperatureNow:[NSNumber numberWithDouble:12.2]
                                     speedNow:[NSNumber numberWithDouble:69.69]
                                  pressureNow:[NSNumber numberWithDouble:1024.24]
                                      gustNow:[NSNumber numberWithDouble:12.12]
                                   degreesNow:[NSNumber numberWithDouble:12.12]
                                      context:self.model.context];
    
    
    [self save];
    
}

-(void) save {
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error saving %s \n\n %@",__func__, error);
              }];
}

@end
