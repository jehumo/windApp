// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMAlert.m instead.

#import "_JHMAlert.h"

const struct JHMAlertAttributes JHMAlertAttributes = {
	.speedTrigger = @"speedTrigger",
	.windDirection = @"windDirection",
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
	
	if ([key isEqualToString:@"windDirectionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"windDirection"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic speedTrigger;






@dynamic windDirection;



- (int16_t)windDirectionValue {
	NSNumber *result = [self windDirection];
	return [result shortValue];
}

- (void)setWindDirectionValue:(int16_t)value_ {
	[self setWindDirection:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveWindDirectionValue {
	NSNumber *result = [self primitiveWindDirection];
	return [result shortValue];
}

- (void)setPrimitiveWindDirectionValue:(int16_t)value_ {
	[self setPrimitiveWindDirection:[NSNumber numberWithShort:value_]];
}





@dynamic specificDirection;

	

@dynamic watchACity;

	






@end
