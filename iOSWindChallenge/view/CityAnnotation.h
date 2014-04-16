//
//  CityAnnotation.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 16/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "UserTrackingAnnotation.h"
#import "City.h"

@interface CityAnnotation : UserTrackingAnnotation
- (id) initWithCity:(City  *) aCity  geopoint:(PFGeoPoint *) aGeopoint;
@property (nonatomic, strong) City * cityData;
@property (copy,nonatomic) NSString * idCity;
@end
