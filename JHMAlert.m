#import "JHMAlert.h"


@interface JHMAlert ()

// Private interface goes here.

@end


@implementation JHMAlert

+(instancetype) alertAnyDirectionWithName:(NSString *) aName
                                 withCity:(JHMCity *) cityWithAlert
                             speedTrigger:(NSNumber *)aSpeed
                                  context:(NSManagedObjectContext *) aContext {
    
    JHMAlert * alert = [NSEntityDescription insertNewObjectForEntityForName:[JHMAlert entityName]
                                                     inManagedObjectContext:aContext];

    alert.name = aName;
    
    // Set the city to watch
    alert.watchACity = cityWithAlert;
    
    alert.speedTrigger=aSpeed;
    alert.specificDirection = nil; // If no specific direction, it means that any direction will trigger the alert
    
    alert.creationDate = [NSDate date];
    
    return alert;
}

+(instancetype) alertSpecicDirectionWithName:(NSString *) aName
                                    withCity:(JHMCity *) cityWithAlert
                                speedTrigger:(NSNumber *)aSpeed
                           specificDirection:(JHMWindDirectionsCatalog *) aSpecificDirection
                                     context:(NSManagedObjectContext *) aContext{
    
    JHMAlert * alert = [NSEntityDescription insertNewObjectForEntityForName:[JHMAlert entityName]
                                                     inManagedObjectContext:aContext];
    
    alert.name = aName;
    
    // Set the city to watch
    alert.watchACity = cityWithAlert;
    
    alert.speedTrigger=aSpeed;
    alert.specificDirection = aSpecificDirection; // For this specific direction, it means that only this direction will trigger the alert to this city
    
    alert.creationDate = [NSDate date];
    
    return alert;

    
}


@end
