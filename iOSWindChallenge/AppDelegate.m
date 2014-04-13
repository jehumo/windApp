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
    // Create data
    
    // Retrieve the context from the model

//    WindDirectionsCatalog * windCatalog = [WindDirectionsCatalog windDirectionsCatalogWithName:@"N"
//                                           degrees:[NSNumber numberWithInt:0]
//                                           
//                                                                                       context:self.model.context];
//                                          
//    
//
//    NSLog(@"Log Debug Trace ::: windCatalog : %@", windCatalog);

    
    
    // Assign values to properties with KVC
//    [catalogWindDirection setValue:@"N" forKeyPath:@"name"];
//    [catalogWindDirection setValue:[NSDate date] forKeyPath:@"creationDate"];
//    [catalogWindDirection setValue:[NSDate date] forKeyPath:@"modificationDate"];
//    [catalogWindDirection setValue:[NSNumber numberWithInt:0]  forKeyPath:@"degrees"];


    
//    NSLog(@"Log Debug Trace ::: catalogWindDirection : %@", catalogWindDirection);

    
    
}


@end
