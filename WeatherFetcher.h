//
//  WeatherFetcher.h
//  iOSWindChallenge
//
//  Created by Jesús Hurtado on 21/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherResult : NSObject

@property (nonatomic, readonly) NSString * cityName;
@property (nonatomic, readonly) CGFloat currentWindSpeedForCity;
@property (nonatomic, readonly) CGFloat currentDegreesWindSpeedForCity;
@property (nonatomic, readonly) NSDate *updatedAt;

@end

typedef void (^WeatherResultCompletionBlock)(WeatherResult *result);

@interface WeatherFetcher : NSObject

@property (nonatomic, readonly) NSString *cacheFile;

+ (WeatherFetcher *)sharedInstance;
- (WeatherResult *)cachedResult;
- (void)fetchWeatherForLocation:(NSString *)location completion:(WeatherResultCompletionBlock)completion;

@end
