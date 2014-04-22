//
//  WeatherFetcher.m
//  iOSWindChallenge
//
//  Created by Jesús Hurtado on 21/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//
#import "WeatherFetcher.h"
#import <RestKit/RestKit.h>
#import "City.h"
#import "Coordinate.h"
#import "Weather.h"
#import "Wind.h"


@interface WeatherFetcher()
@property (nonatomic, strong) NSArray * cities;
@end

@implementation WeatherResult

- (id)initWithLocation:(NSString *)cityName
           windSpeed:(CGFloat)windSpeed
           windDegrees:(CGFloat)windDegrees
             updatedAt:(NSDate *)updatedAt {
    self = [super init];
    if (self) {
        _cityName = cityName;
        _currentWindSpeedForCity = windSpeed;
        _currentDegreesWindSpeedForCity = windDegrees;
        _updatedAt = updatedAt;
    }
    return self;
}


@end

@implementation WeatherFetcher

+ (WeatherFetcher *)sharedInstance {
    static WeatherFetcher *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [docsDir stringByAppendingPathComponent:@"weatherResult.plist"];
        _sharedInstance = [[WeatherFetcher alloc] initWithCacheFile:path];
    });
    
    return _sharedInstance;
}

- (id)initWithCacheFile:(NSString *)cacheFile {
    self = [super init];
    if (self) {
        _cacheFile = cacheFile;
    }
    return self;
}



- (void)fetchWeatherForLocation:(NSString *)cityName completion:(WeatherResultCompletionBlock)completion {

        //__block WeatherResult *result;
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

        NSDictionary *queryParams = @{ @"q" : cityName,
                                       @"mode" : @"json" };
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/data/2.5/find"
                                               parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
            {
                                                    
                self.cities = mappingResult.array;

                if (self.cities.count >0 ) {
                    
                    City * cityReturned = (City *) [self.cities objectAtIndex:0];
                    
                    double currentWindSpeedForCity = [cityReturned.wind.speed doubleValue];
                    double currentWindDegreesForCity = [cityReturned.wind.degrees doubleValue];
                    NSLog(@"Log Debug Trace ::: cityReturned : %@", cityReturned.name);
                    NSLog(@"Log Debug Trace ::: currentWindSpeedForCity : %f", currentWindSpeedForCity);
                    NSLog(@"Log Debug Trace ::: currentWindDegreesForCity : %f", currentWindDegreesForCity);

                    
                    NSDate *updatedAt = [NSDate date];
                    
                    WeatherResult *result = [[WeatherResult alloc] initWithLocation:cityReturned.name
                                                           windSpeed:currentWindSpeedForCity
                                                         windDegrees:currentWindDegreesForCity
                                                           updatedAt:updatedAt];
                    completion(result);
                } else {
                    NSLog(@"No city found");
                    
                }
            }
            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    NSLog(@"Log Error Trace :::Operation Failed %@", error);
            }];
       });
    
}

@end