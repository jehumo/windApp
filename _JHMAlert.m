// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMAlert.m instead.

#import "_JHMAlert.h"

const struct JHMAlertAttributes JHMAlertAttributes = {
	.degreesMax = @"degreesMax",
	.degreesMin = @"degreesMin",
	.speedTrigger = @"speedTrigger",
};

const struct JHMAlertRelationships JHMAlertRelationships = {
	.watchACity = @"watchACity",
};

const struct JHMAlertFetchedProperties JHMAlertFetchedProperties = {
};

@implementation JHMAlertID
@end

@implementation _JHMAlert

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Alert" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Alert";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Alert" inManagedObjectContext:moc_];
}

- (JHMAlertID*)objectID {
	return (JHMAlertID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"degreesMaxValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"degreesMax"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"degreesMinValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"degreesMin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"speedTriggerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"speedTrigger"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic degreesMax;



- (int16_t)degreesMaxValue {
	NSNumber *result = [self degreesMax];
	return [result shortValue];
}

- (void)setDegreesMaxValue:(int16_t)value_ {
	[self setDegreesMax:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDegreesMaxValue {
	NSNumber *result = [self primitiveDegreesMax];
	return [result shortValue];
}

- (void)setPrimitiveDegreesMaxValue:(int16_t)value_ {
	[self setPrimitiveDegreesMax:[NSNumber numberWithShort:value_]];
}





@dynamic degreesMin;



- (int16_t)degreesMinValue {
	NSNumber *result = [self degreesMin];
	return [result shortValue];
}

- (void)setDegreesMinValue:(int16_t)value_ {
	[self setDegreesMin:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveDegreesMinValue {
	NSNumber *result = [self primitiveDegreesMin];
	return [result shortValue];
}

- (void)setPrimitiveDegreesMinValue:(int16_t)value_ {
	[self setPrimitiveDegreesMin:[NSNumber numberWithShort:value_]];
}





@dynamic speedTrigger;



- (int16_t)speedTriggerValue {
	NSNumber *result = [self speedTrigger];
	return [result shortValue];
}

- (void)setSpeedTriggerValue:(int16_t)value_ {
	[self setSpeedTrigger:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSpeedTriggerValue {
	NSNumber *result = [self primitiveSpeedTrigger];
	return [result shortValue];
}

- (void)setPrimitiveSpeedTriggerValue:(int16_t)value_ {
	[self setPrimitiveSpeedTrigger:[NSNumber numberWithShort:value_]];
}





@dynamic watchACity;

	






@end
