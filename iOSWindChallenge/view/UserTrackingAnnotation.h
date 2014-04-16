//
//  UserTrackingAnnotation.h
//  iOSWindChallenge
//
//  Created by JESUS HURTADO on 16/04/14.
//  Copyright (c) 2014 Piksel. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface UserTrackingAnnotation : MKAnnotationView
- (id) initWithUserGeoPoint:(PFGeoPoint *) geopoint;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
