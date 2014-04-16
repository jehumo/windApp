// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMCity.m instead.

#import "_JHMCity.h"

const struct JHMCityAttributes JHMCityAttributes = {
	.degrees = @"degrees",
	.gust = @"gust",
	.idCity = @"idCity",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.pressure = @"pressure",
	.speed = @"speed",
	.temperature = @"temperature",
};

const struct JHMCityRelationships JHMCityRelationships = {
	.keepsWindAlert = @"keepsWindAlert",
};

const struct JHMCityFetchedProperties JHMCityFetchedProperties = {
};

@implementation JHMCityID
@end

@implementation _JHMCity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"City";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc_];
}

- (JHMCityID*)objectID {
	return (JHMCityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pressureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pressure"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"temperatureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"temperature"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic degrees;






@dynamic gust;






@dynamic idCity;






@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}





@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic pressure;



- (int16_t)pressureValue {
	NSNumber *result = [self pressure];
	return [result shortValue];
}

- (void)setPressureValue:(int16_t)value_ {
	[self setPressure:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePressureValue {
	NSNumber *result = [self primitivePressure];
	return [result shortValue];
}

- (void)setPrimitivePressureValue:(int16_t)value_ {
	[self setPrimitivePressure:[NSNumber numberWithShort:value_]];
}





@dynamic speed;






@dynamic temperature;



- (double)temperatureValue {
	NSNumber *result = [self temperature];
	return [result doubleValue];
}

- (void)setTemperatureValue:(double)value_ {
	[self setTemperature:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTemperatureValue {
	NSNumber *result = [self primitiveTemperature];
	return [result doubleValue];
}

- (void)setPrimitiveTemperatureValue:(double)value_ {
	[self setPrimitiveTemperature:[NSNumber numberWithDouble:value_]];
}





@dynamic keepsWindAlert;

	






@end
