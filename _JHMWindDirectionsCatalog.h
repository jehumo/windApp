// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMWindDirectionsCatalog.h instead.

#import <CoreData/CoreData.h>
#import "JHMNamedEntity.h"

extern const struct JHMWindDirectionsCatalogAttributes {
	__unsafe_unretained NSString *degreesMax;
	__unsafe_unretained NSString *degreesMin;
} JHMWindDirectionsCatalogAttributes;

extern const struct JHMWindDirectionsCatalogRelationships {
	__unsafe_unretained NSString *specifyWindDirectionOfAnAlert;
} JHMWindDirectionsCatalogRelationships;

extern const struct JHMWindDirectionsCatalogFetchedProperties {
} JHMWindDirectionsCatalogFetchedProperties;

@class JHMAlert;




@interface JHMWindDirectionsCatalogID : NSManagedObjectID {}
@end

@interface _JHMWindDirectionsCatalog : JHMNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (JHMWindDirectionsCatalogID*)objectID;





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





@property (nonatomic, strong) NSSet *specifyWindDirectionOfAnAlert;

- (NSMutableSet*)specifyWindDirectionOfAnAlertSet;





@end

@interface _JHMWindDirectionsCatalog (CoreDataGeneratedAccessors)

- (void)addSpecifyWindDirectionOfAnAlert:(NSSet*)value_;
- (void)removeSpecifyWindDirectionOfAnAlert:(NSSet*)value_;
- (void)addSpecifyWindDirectionOfAnAlertObject:(JHMAlert*)value_;
- (void)removeSpecifyWindDirectionOfAnAlertObject:(JHMAlert*)value_;

@end

@interface _JHMWindDirectionsCatalog (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDegreesMax;
- (void)setPrimitiveDegreesMax:(NSNumber*)value;

- (int16_t)primitiveDegreesMaxValue;
- (void)setPrimitiveDegreesMaxValue:(int16_t)value_;




- (NSNumber*)primitiveDegreesMin;
- (void)setPrimitiveDegreesMin:(NSNumber*)value;

- (int16_t)primitiveDegreesMinValue;
- (void)setPrimitiveDegreesMinValue:(int16_t)value_;





- (NSMutableSet*)primitiveSpecifyWindDirectionOfAnAlert;
- (void)setPrimitiveSpecifyWindDirectionOfAnAlert:(NSMutableSet*)value;


@end
