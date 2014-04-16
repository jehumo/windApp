#import "JHMCity.h"


@interface JHMCity ()

// Private interface goes here.

@end


@implementation JHMCity

+(instancetype) cityWithName:(NSString *) aName
                      idCity:(NSString *)idCity
               longitudeCity:(NSNumber *) aLongitude
                latitudeCity:(NSNumber *) aLatitude
              temperatureNow:(NSNumber *) currentTemperature
                    speedNow:(NSNumber *) currentSpeed
                 pressureNow:(NSNumber *) currentPressure
                     gustNow:(NSNumber *) currentGust
                  degreesNow:(NSNumber *) currentDegrees
                     context:(NSManagedObjectContext *) aContext {
    
    JHMCity * newFavoriteCity = [NSEntityDescription insertNewObjectForEntityForName:[JHMCity entityName]
                                                              inManagedObjectContext:aContext];
    
    
    newFavoriteCity.name = aName;
    newFavoriteCity.idCity = idCity;
    newFavoriteCity.latitude=aLatitude;
    newFavoriteCity.longitude=aLongitude;
    newFavoriteCity.temperature = currentTemperature;
    newFavoriteCity.speed = currentSpeed;
    newFavoriteCity.degrees = currentDegrees;
    newFavoriteCity.pressure = currentPressure;
    newFavoriteCity.gust = currentGust;
    
    newFavoriteCity.creationDate = [NSDate date];
    return newFavoriteCity;
                                 
}

+(instancetype) cityWithIdCity:( NSNumber *) idCity
                       context:(NSManagedObjectContext *) aContext {
    
    JHMCity * newFavoriteCity = [NSEntityDescription insertNewObjectForEntityForName:[JHMCity entityName]
                                                              inManagedObjectContext:aContext];
    
    
    newFavoriteCity.idCity = idCity;
    
    newFavoriteCity.creationDate = [NSDate date];
    return newFavoriteCity;
    
}


@end
