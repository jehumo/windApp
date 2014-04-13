// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMCity.h instead.

#import <CoreData/CoreData.h>
#import "JHMNamedEntity.h"

extern const struct JHMCityAttributes {
	__unsafe_unretained NSString *degrees;
	__unsafe_unretained NSString *gust;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *pressure;
	__unsafe_unretained NSString *speed;
	__unsafe_unretained NSString *temperature;
} JHMCityAttributes;

extern const struct JHMCityRelationships {
	__unsafe_unretained NSString *keepsWindAlert;
} JHMCityRelationships;

extern const struct JHMCityFetchedProperties {
} JHMCityFetchedProperties;

@class JHMAlert;









@interface JHMCityID : NSManagedObjectID {}
@end

@interface _JHMCity : JHMNamedEntity {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (JHMCityID*)objectID;





@property (nonatomic, strong) NSNumber* degrees;



@property double degreesValue;
- (double)degreesValue;
- (void)setDegreesValue:(double)value_;

//- (BOOL)validateDegrees:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* gust;



@property double gustValue;
- (double)gustValue;
- (void)setGustValue:(double)value_;

//- (BOOL)validateGust:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* latitude;



@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* longitude;



@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* pressure;



@property int16_t pressureValue;
- (int16_t)pressureValue;
- (void)setPressureValue:(int16_t)value_;

//- (BOOL)validatePressure:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* speed;



@property double speedValue;
- (double)speedValue;
- (void)setSpeedValue:(double)value_;

//- (BOOL)validateSpeed:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* temperature;



@property double temperatureValue;
- (double)temperatureValue;
- (void)setTemperatureValue:(double)value_;

//- (BOOL)validateTemperature:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) JHMAlert *keepsWindAlert;

//- (BOOL)validateKeepsWindAlert:(id*)value_ error:(NSError**)error_;





@end

@interface _JHMCity (CoreDataGeneratedAccessors)

@end

@interface _JHMCity (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDegrees;
- (void)setPrimitiveDegrees:(NSNumber*)value;

- (double)primitiveDegreesValue;
- (void)setPrimitiveDegreesValue:(double)value_;




- (NSNumber*)primitiveGust;
- (void)setPrimitiveGust:(NSNumber*)value;

- (double)primitiveGustValue;
- (void)setPrimitiveGustValue:(double)value_;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSNumber*)primitivePressure;
- (void)setPrimitivePressure:(NSNumber*)value;

- (int16_t)primitivePressureValue;
- (void)setPrimitivePressureValue:(int16_t)value_;




- (NSNumber*)primitiveSpeed;
- (void)setPrimitiveSpeed:(NSNumber*)value;

- (double)primitiveSpeedValue;
- (void)setPrimitiveSpeedValue:(double)value_;




- (NSNumber*)primitiveTemperature;
- (void)setPrimitiveTemperature:(NSNumber*)value;

- (double)primitiveTemperatureValue;
- (void)setPrimitiveTemperatureValue:(double)value_;





- (JHMAlert*)primitiveKeepsWindAlert;
- (void)setPrimitiveKeepsWindAlert:(JHMAlert*)value;


@end
