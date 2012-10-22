// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IATreeMember.m instead.

#import "_IATreeMember.h"

const struct IATreeMemberAttributes IATreeMemberAttributes = {
	.displayName = @"displayName",
	.isLeaf = @"isLeaf",
};

const struct IATreeMemberRelationships IATreeMemberRelationships = {
	.children = @"children",
	.parents = @"parents",
};

const struct IATreeMemberFetchedProperties IATreeMemberFetchedProperties = {
};

@implementation IATreeMemberID
@end

@implementation _IATreeMember

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IATreeMember" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IATreeMember";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IATreeMember" inManagedObjectContext:moc_];
}

- (IATreeMemberID*)objectID {
	return (IATreeMemberID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isLeafValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isLeaf"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic displayName;






@dynamic isLeaf;



- (BOOL)isLeafValue {
	NSNumber *result = [self isLeaf];
	return [result boolValue];
}

- (void)setIsLeafValue:(BOOL)value_ {
	[self setIsLeaf:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsLeafValue {
	NSNumber *result = [self primitiveIsLeaf];
	return [result boolValue];
}

- (void)setPrimitiveIsLeafValue:(BOOL)value_ {
	[self setPrimitiveIsLeaf:[NSNumber numberWithBool:value_]];
}





@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parents;

	
- (NSMutableSet*)parentsSet {
	[self willAccessValueForKey:@"parents"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"parents"];
  
	[self didAccessValueForKey:@"parents"];
	return result;
}
	






@end
