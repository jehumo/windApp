#import "_JHMCity.h"

@interface JHMCity : _JHMCity {}
// Custom logic goes here.
+(instancetype) cityWithName:(NSString *) aName
                      idCity:(NSString *)idCity
                   longitudeCity:(NSNumber *) aLongitude
                    latitudeCity:(NSNumber *) aLatitude
                 temperatureNow:(NSNumber *) currentTemperature
                    speedNow:(NSNumber *) currentSpeed
                 pressureNow:(NSNumber *) currentPressure
                        gustNow:(NSNumber *) currentGust
                     degreesNow:(NSNumber *) currentDegrees
                     context:(NSManagedObjectContext *) aContext;
+(instancetype) cityWithIdCity:( NSNumber *) idCity
                       context:(NSManagedObjectContext *) aContext ;
@end
