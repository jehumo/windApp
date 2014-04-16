//
//  CityAnnotation.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 16/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "CityAnnotation.h"


@implementation CityAnnotation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id) initWithCity:(City  *) aCity  geopoint:(PFGeoPoint *) aGeopoint;{
    
    self = [super initWithUserGeoPoint:aGeopoint];
    if (self) {
        self.cityData = aCity;
    }
    return self;
}

@end
