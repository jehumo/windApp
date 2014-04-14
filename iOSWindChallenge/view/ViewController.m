//
//  ViewController.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 12/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "ViewController.h"
#import "JHMCity.h"

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
//                City * city = [[ City alloc] initWithDictionary:aDict];
                
//                NSLog(@"Log Debug Trace ::: city : %@", city);

                
                
            }
        }


    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCity:(id)sender {
    
//    JHMCity * newCity = [JHMCity cityWithName:self.cityNameTextField.text
//                                longitudeCity:[NSNumber numberWithDouble:-3.1]
//                                               latitudeCity:[NSNumber numberWithDouble:44.1]
//                                               temperatureNow:[NSNumber numberWithDouble:12.2]
//                                               speedNow:[NSNumber numberWithDouble:69.69]
//                                               pressureNow:[NSNumber numberWithDouble:1024.24]
//                                               gustNow:[NSNumber numberWithDouble:12.12]
//                                               degreesNow:45.00
//                                      context:self.model.context];
    
    
}
@end
