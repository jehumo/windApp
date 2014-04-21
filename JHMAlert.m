#import "JHMAlert.h"


@interface JHMAlert ()

// Private interface goes here.

@end


@implementation JHMAlert

+(instancetype) alertAnyDirectionWithName:(NSString *) aName
                                 withCity:(JHMCity *) cityWithAlert
                             speedTrigger:(NSNumber *)aSpeed
                               minDegrees:(NSNumber *) minDegrees
                               maxDegrees:(NSNumber *) maxDegrees
                                  context:(NSManagedObjectContext *) aContext {
    
    JHMAlert * alert = [NSEntityDescription insertNewObjectForEntityForName:[JHMAlert entityName]
                                                     inManagedObjectContext:aContext];

    alert.name = aName;
    
    // Set the city to watch
    alert.watchACity = cityWithAlert;
    alert.degreesMin = minDegrees;
    alert.degreesMax = maxDegrees;
    alert.speedTrigger=aSpeed;
    alert.creationDate = [NSDate date];
    
    return alert;
}
@end
