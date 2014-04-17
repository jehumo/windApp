//
//  UtilRestkit.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 17/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "UtilRestkit.h"
#import <RestKit/RestKit.h>
#import "City.h"
#import "Coordinate.h"
#import "Weather.h"
#import "Wind.h"
#import <Reachability/Reachability.h>


@implementation UtilRestkit

#pragma mark - Restkit Setup

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org/"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    // 1. CityMapping
    RKObjectMapping *cityMapping = [RKObjectMapping mappingForClass:[City class]];
    [cityMapping addAttributeMappingsFromArray:@[@"name"]];
    [cityMapping addAttributeMappingsFromDictionary:@{@"id":@"idCity" }];
    
    // 2. Coordinate Mapping
    RKObjectMapping *coordinateMapping = [RKObjectMapping mappingForClass:[Coordinate class]];
    [coordinateMapping addAttributeMappingsFromArray:@[@"lat", @"lon"]];
    
    // Linking abd defining relationship mapping
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord"
                                                                                toKeyPath:@"coordinate"
                                                                              withMapping:coordinateMapping]];
    
    // 3. Wind Mapping
    RKObjectMapping * windMapping = [RKObjectMapping mappingForClass:[Wind class]];
    [windMapping addAttributeMappingsFromDictionary:@{
                                                      @"speed":@"speed",
                                                      @"deg":@"degrees"
                                                      }];
    [cityMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"wind"
                                                                                toKeyPath:@"wind"
                                                                              withMapping:windMapping]];
    
    
    // 4. Weather Mapping
    RKObjectMapping * weatherMapping = [RKObjectMapping  mappingForClass:[Weather class]];
    [weatherMapping addAttributeMappingsFromDictionary:@{
                                                         //@"temp": @"temperature",
                                                         @"main":@"mainDescription",
                                                         @"icon":@"icon"
                                                         }];
    [cityMapping addPropertyMapping:[RKRelationshipMapping  relationshipMappingFromKeyPath:@"weather"
                                                                                 toKeyPath:@"weather"
                                                                               withMapping:weatherMapping]];
    
    
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:cityMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"data/2.5/find"
                                                                                           keyPath:@"list"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    
    // setup object mappings
    // 1. Wind Mapping
    RKObjectMapping * windPredictionsMapping = [RKObjectMapping mappingForClass:[Wind class]];
    [windMapping addAttributeMappingsFromDictionary:@{
                                                      @"speed":@"speed",
                                                      @"deg":@"degrees",
                                                      @"dt":@"dt"
                                                      }];
    
    // register mappings with the provider using a response descriptor
    // api.openweathermap.org/data/2.5/forecast/daily?id=524901&cnt=15
    RKResponseDescriptor *responseDescriptorForecast = [RKResponseDescriptor responseDescriptorWithMapping:windPredictionsMapping
                                                                                                    method:RKRequestMethodGET
                                                                                               pathPattern:@"data/2.5/forecast/daily"
                                                                                                   keyPath:@"list"
                                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptorForecast];
    
}



@end
