//
//  UserTrackingAnnotation.m
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 16/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import "UserTrackingAnnotation.h"
@interface UserTrackingAnnotation()
@property (nonatomic,strong) PFGeoPoint * geopoint;
@end
@implementation UserTrackingAnnotation

- (id) initWithUserGeoPoint:(PFGeoPoint *) geopoint {
    
    self = [super init];
    if (self) {
        self.geopoint = (PFGeoPoint *)geopoint;
        _coordinate = CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
    }
    return self;
}
@end
