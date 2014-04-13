// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMWindDirectionsCatalog.m instead.

#import "_JHMWindDirectionsCatalog.h"

const struct JHMWindDirectionsCatalogAttributes JHMWindDirectionsCatalogAttributes = {
	.degreesMin = @"degreesMin",
};

const struct JHMWindDirectionsCatalogRelationships JHMWindDirectionsCatalogRelationships = {
	.specifyWindDirectionOfAnAlert = @"specifyWindDirectionOfAnAlert",
};

const struct JHMWindDirectionsCatalogFetchedProperties JHMWindDirectionsCatalogFetchedProperties = {
};

@implementation JHMWindDirectionsCatalogID
@end

@implementation _JHMWindDirectionsCatalog

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"WindDirectionsCatalog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"WindDirectionsCatalog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"WindDirectionsCatalog" inManagedObjectContext:moc_];
}

- (JHMWindDirectionsCatalogID*)objectID {
	return (JHMWindDirectionsCatalogID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"degreesMinValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"degreesMin"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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





@dynamic specifyWindDirectionOfAnAlert;

	
- (NSMutableSet*)specifyWindDirectionOfAnAlertSet {
	[self willAccessValueForKey:@"specifyWindDirectionOfAnAlert"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"specifyWindDirectionOfAnAlert"];
  
	[self didAccessValueForKey:@"specifyWindDirectionOfAnAlert"];
	return result;
}
	






@end
