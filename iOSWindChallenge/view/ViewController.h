//
//  ViewController.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTSimpleCoreDataStack.h"

#import <RestKit/RestKit.h>


@interface ViewController : UIViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *theSearchBar;
- (IBAction)addCity:(id)sender;
// Property for the model, to be initialized when the app start
@property (strong, nonatomic) AGTSimpleCoreDataStack * model;

@end
