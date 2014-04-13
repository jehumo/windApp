// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMAlert.h instead.

#import <CoreData/CoreData.h>
#import "JHMNamedEntity.h"

extern const struct JHMAlertAttributes {
	__unsafe_unretained NSString *speedTrigger;
	__unsafe_unretained NSString *windDirection;
} JHMAlertAttributes;

extern const struct JHMAlertRelationships {
	__unsafe_unretained NSString *specificDirection;
	__unsafe_unretained NSString *watchACity;
} JHMAlertRelationships;

extern const struct JHMAlertFetchedProperties {
} JHMAlertFetchedProperties;

@class JHMWindDirectionsCatalog;
@class JHMCity;




@interface JHMAlertID : NSManagedObjectID {}
@end

@interface _JHMAlert : JHMNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (JHMAlertID*)objectID;





@property (nonatomic, strong) NSDecimalNumber* speedTrigger;



//- (BOOL)validateSpeedTrigger:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* windDirection;



@property int16_t windDirectionValue;
- (int16_t)windDirectionValue;
- (void)setWindDirectionValue:(int16_t)value_;

//- (BOOL)validateWindDirection:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) JHMWindDirectionsCatalog *specificDirection;

//- (BOOL)validateSpecificDirection:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) JHMCity *watchACity;

//- (BOOL)validateWatchACity:(id*)value_ error:(NSError**)error_;





@end

@interface _JHMAlert (CoreDataGeneratedAccessors)

@end

@interface _JHMAlert (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitiveSpeedTrigger;
- (void)setPrimitiveSpeedTrigger:(NSDecimalNumber*)value;




- (NSNumber*)primitiveWindDirection;
- (void)setPrimitiveWindDirection:(NSNumber*)value;

- (int16_t)primitiveWindDirectionValue;
- (void)setPrimitiveWindDirectionValue:(int16_t)value_;





- (JHMWindDirectionsCatalog*)primitiveSpecificDirection;
- (void)setPrimitiveSpecificDirection:(JHMWindDirectionsCatalog*)value;



- (JHMCity*)primitiveWatchACity;
- (void)setPrimitiveWatchACity:(JHMCity*)value;


@end
