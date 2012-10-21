// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IAGroup.m instead.

#import "_IAGroup.h"

const struct IAGroupAttributes IAGroupAttributes = {
	.groupType = @"groupType",
};

const struct IAGroupRelationships IAGroupRelationships = {
};

const struct IAGroupFetchedProperties IAGroupFetchedProperties = {
};

@implementation IAGroupID
@end

@implementation _IAGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Group";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Group" inManagedObjectContext:moc_];
}

- (IAGroupID*)objectID {
	return (IAGroupID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"groupTypeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"groupType"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic groupType;



- (int32_t)groupTypeValue {
	NSNumber *result = [self groupType];
	return [result intValue];
}

- (void)setGroupTypeValue:(int32_t)value_ {
	[self setGroupType:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveGroupTypeValue {
	NSNumber *result = [self primitiveGroupType];
	return [result intValue];
}

- (void)setPrimitiveGroupTypeValue:(int32_t)value_ {
	[self setPrimitiveGroupType:[NSNumber numberWithInt:value_]];
}










@end
