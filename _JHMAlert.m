// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMAlert.m instead.

#import "_JHMAlert.h"

const struct JHMAlertAttributes JHMAlertAttributes = {
	.speedTrigger = @"speedTrigger",
};

const struct JHMAlertRelationships JHMAlertRelationships = {
	.specificDirection = @"specificDirection",
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
	
	if ([key isEqualToString:@"speedTriggerValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"speedTrigger"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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





@dynamic specificDirection;

	

@dynamic watchACity;

	






@end
