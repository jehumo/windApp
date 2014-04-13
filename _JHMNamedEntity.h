// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to JHMNamedEntity.h instead.

#import <CoreData/CoreData.h>


extern const struct JHMNamedEntityAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *name;
} JHMNamedEntityAttributes;

extern const struct JHMNamedEntityRelationships {
} JHMNamedEntityRelationships;

extern const struct JHMNamedEntityFetchedProperties {
} JHMNamedEntityFetchedProperties;






@interface JHMNamedEntityID : NSManagedObjectID {}
@end

@interface _JHMNamedEntity : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (JHMNamedEntityID*)objectID;





@property (nonatomic, strong) NSDate* creationDate;



//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* modificationDate;



//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _JHMNamedEntity (CoreDataGeneratedAccessors)

@end

@interface _JHMNamedEntity (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;




- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
