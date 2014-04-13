#import "_JHMWindDirectionsCatalog.h"

@interface JHMWindDirectionsCatalog : _JHMWindDirectionsCatalog {}
// Custom logic goes here.

+(instancetype)  windDirectionsCatalogWithName:(NSString *)name
                                       degreesMin:(NSNumber *)degreesMin
                                       degreesMax:(NSNumber *)degreesMax
                                       context:(NSManagedObjectContext *) context;
@end
