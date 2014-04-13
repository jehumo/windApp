//
//  ViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "ViewController.h"
#import "City.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *londonWeatherUrl = @"http://api.openweathermap.org/data/2.5/weather?q=London,uk";
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:londonWeatherUrl]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,
                                                                                                            NSData *data,
                                                                                                            NSError *connectionError) { // handle response
        NSLog(@"Log Debug Trace ::: data : %@", data);
        
        
        // JSON array
        NSError * error;
        NSArray * JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:&error];
        
        // Parsing JSON Array
        if (JSONObjects != nil) {
            
            // No error
            for (NSDictionary * aDict in JSONObjects) {
                
                // Init a City object instance with the convenience initializer
                City * city = [[ City alloc] initWithDictionary:aDict];
                
                NSLog(@"Log Debug Trace ::: city : %@", city);

                
                
            }
        }


    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
