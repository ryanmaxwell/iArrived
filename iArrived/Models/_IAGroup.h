// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IAGroup.h instead.

#import <CoreData/CoreData.h>
#import "IATreeMember.h"

extern const struct IAGroupAttributes {
	__unsafe_unretained NSString *groupType;
} IAGroupAttributes;

extern const struct IAGroupRelationships {
} IAGroupRelationships;

extern const struct IAGroupFetchedProperties {
} IAGroupFetchedProperties;




@interface IAGroupID : NSManagedObjectID {}
@end

@interface _IAGroup : IATreeMember {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (IAGroupID*)objectID;





@property (nonatomic, strong) NSNumber* groupType;



@property int32_t groupTypeValue;
- (int32_t)groupTypeValue;
- (void)setGroupTypeValue:(int32_t)value_;

//- (BOOL)validateGroupType:(id*)value_ error:(NSError**)error_;






@end

@interface _IAGroup (CoreDataGeneratedAccessors)

@end

@interface _IAGroup (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveGroupType;
- (void)setPrimitiveGroupType:(NSNumber*)value;

- (int32_t)primitiveGroupTypeValue;
- (void)setPrimitiveGroupTypeValue:(int32_t)value_;




@end
