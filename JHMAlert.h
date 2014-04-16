#import "_JHMAlert.h"

@interface JHMAlert : _JHMAlert {}
// Custom logic goes here.

+(instancetype) alertAnyDirectionWithName:(NSString *) aName
                                 withCity:(JHMCity *) cityWithAlert
                 speedTrigger:(NSNumber *)aSpeed
                      context:(NSManagedObjectContext *) aContext;



@end
