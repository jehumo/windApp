//
//  AppDelegate.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack; 


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Property for the model
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;
@property (nonatomic, strong) NSArray * cities;

@end
