//
//  WeatherFetcher.h
//  iOSWindChallenge
//
//  Created by Jesús Hurtado on 21/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherResult : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) CGFloat temperature;
@property (nonatomic, readonly) NSDate *updatedAt;

@end

typedef void (^WeatherResultCompletionBlock)(WeatherResult *result);

@interface WeatherFetcher : NSObject

@property (nonatomic, readonly) NSString *cacheFile;

+ (WeatherFetcher *)sharedInstance;
- (WeatherResult *)cachedResult;
- (void)fetchWeatherForLocation:(NSString *)location completion:(WeatherResultCompletionBlock)completion;

@end
