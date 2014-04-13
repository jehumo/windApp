// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMNamedEntity.m instead.

#import "_JHMNamedEntity.h"

const struct JHMNamedEntityAttributes JHMNamedEntityAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.name = @"name",
};

const struct JHMNamedEntityRelationships JHMNamedEntityRelationships = {
};

const struct JHMNamedEntityFetchedProperties JHMNamedEntityFetchedProperties = {
};

@implementation JHMNamedEntityID
@end

@implementation _JHMNamedEntity

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NamedEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NamedEntity" inManagedObjectContext:moc_];
}

- (JHMNamedEntityID*)objectID {
	return (JHMNamedEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic creationDate;






@dynamic modificationDate;






@dynamic name;











@end
