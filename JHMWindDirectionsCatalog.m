#import "JHMWindDirectionsCatalog.h"


@interface JHMWindDirectionsCatalog ()

// Private interface goes here.

@end


@implementation JHMWindDirectionsCatalog

// Custom logic goes here.
+(instancetype)  windDirectionsCatalogWithName:(NSString *)name
                                    degreesMin:(NSNumber *)degreesMin
                                    degreesMax:(NSNumber *)degreesMax
                                       context:(NSManagedObjectContext *) context {
    
    JHMWindDirectionsCatalog *windDirection =[NSEntityDescription insertNewObjectForEntityForName:[JHMWindDirectionsCatalog entityName]
                                                                        inManagedObjectContext:context];
    
    windDirection.name = name;
    windDirection.degreesMin = degreesMin;
    windDirection.degreesMax = degreesMax;
    windDirection.creationDate = [NSDate date];
    windDirection.modificationDate = [NSDate date];
    
    return windDirection;
}
@end
