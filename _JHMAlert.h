// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMAlert.h instead.

#import <CoreData/CoreData.h>
#import "JHMNamedEntity.h"

extern const struct JHMAlertAttributes {
	__unsafe_unretained NSString *degreesMax;
	__unsafe_unretained NSString *degreesMin;
	__unsafe_unretained NSString *speedTrigger;
} JHMAlertAttributes;

extern const struct JHMAlertRelationships {
	__unsafe_unretained NSString *watchACity;
} JHMAlertRelationships;

extern const struct JHMAlertFetchedProperties {
} JHMAlertFetchedProperties;

@class JHMCity;





@interface JHMAlertID : NSManagedObjectID {}
@end

@interface _JHMAlert : JHMNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (JHMAlertID*)objectID;





@property (nonatomic, strong) NSNumber* degreesMax;



@property int16_t degreesMaxValue;
- (int16_t)degreesMaxValue;
- (void)setDegreesMaxValue:(int16_t)value_;

//- (BOOL)validateDegreesMax:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* degreesMin;



@property int16_t degreesMinValue;
- (int16_t)degreesMinValue;
- (void)setDegreesMinValue:(int16_t)value_;

//- (BOOL)validateDegreesMin:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* speedTrigger;



@property int16_t speedTriggerValue;
- (int16_t)speedTriggerValue;
- (void)setSpeedTriggerValue:(int16_t)value_;

//- (BOOL)validateSpeedTrigger:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) JHMCity *watchACity;

//- (BOOL)validateWatchACity:(id*)value_ error:(NSError**)error_;





@end

@interface _JHMAlert (CoreDataGeneratedAccessors)

@end

@interface _JHMAlert (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDegreesMax;
- (void)setPrimitiveDegreesMax:(NSNumber*)value;

- (int16_t)primitiveDegreesMaxValue;
- (void)setPrimitiveDegreesMaxValue:(int16_t)value_;




- (NSNumber*)primitiveDegreesMin;
- (void)setPrimitiveDegreesMin:(NSNumber*)value;

- (int16_t)primitiveDegreesMinValue;
- (void)setPrimitiveDegreesMinValue:(int16_t)value_;




- (NSNumber*)primitiveSpeedTrigger;
- (void)setPrimitiveSpeedTrigger:(NSNumber*)value;

- (int16_t)primitiveSpeedTriggerValue;
- (void)setPrimitiveSpeedTriggerValue:(int16_t)value_;





- (JHMCity*)primitiveWatchACity;
- (void)setPrimitiveWatchACity:(JHMCity*)value;


@end
