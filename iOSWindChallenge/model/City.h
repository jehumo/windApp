//
//  City.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 15/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Coordinate;
@class Weather;
@class Wind;


@interface City : NSObject
//list.main
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * idCity;
@property (nonatomic, strong) NSNumber * distance;
@property (nonatomic, strong) Coordinate * coordinate;
@property (nonatomic, strong) Weather * weather;
@property (nonatomic, strong) Wind * wind;




@end
