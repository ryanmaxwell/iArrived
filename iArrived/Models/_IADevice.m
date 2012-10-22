// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IADevice.m instead.

#import "_IADevice.h"

const struct IADeviceAttributes IADeviceAttributes = {
	.growlWhenArrives = @"growlWhenArrives",
	.growlWhenLeaves = @"growlWhenLeaves",
	.hostName = @"hostName",
	.introLastPlayedDate = @"introLastPlayedDate",
	.introTrackArtist = @"introTrackArtist",
	.introTrackName = @"introTrackName",
	.ipv4Address = @"ipv4Address",
	.ipv6Address = @"ipv6Address",
	.isFollowed = @"isFollowed",
	.isFound = @"isFound",
	.isResolved = @"isResolved",
	.lastFoundDate = @"lastFoundDate",
	.macAddress = @"macAddress",
	.outroLastPlayedDate = @"outroLastPlayedDate",
	.outroTrackArtist = @"outroTrackArtist",
	.outroTrackName = @"outroTrackName",
	.serviceDomain = @"serviceDomain",
	.serviceName = @"serviceName",
	.serviceType = @"serviceType",
};

const struct IADeviceRelationships IADeviceRelationships = {
};

const struct IADeviceFetchedProperties IADeviceFetchedProperties = {
};

@implementation IADeviceID
@end

@implementation _IADevice

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"IADevice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"IADevice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"IADevice" inManagedObjectContext:moc_];
}

- (IADeviceID*)objectID {
	return (IADeviceID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"growlWhenArrivesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"growlWhenArrives"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"growlWhenLeavesValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"growlWhenLeaves"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isFollowedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFollowed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isFoundValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFound"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"isResolvedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isResolved"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic growlWhenArrives;



- (BOOL)growlWhenArrivesValue {
	NSNumber *result = [self growlWhenArrives];
	return [result boolValue];
}

- (void)setGrowlWhenArrivesValue:(BOOL)value_ {
	[self setGrowlWhenArrives:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveGrowlWhenArrivesValue {
	NSNumber *result = [self primitiveGrowlWhenArrives];
	return [result boolValue];
}

- (void)setPrimitiveGrowlWhenArrivesValue:(BOOL)value_ {
	[self setPrimitiveGrowlWhenArrives:[NSNumber numberWithBool:value_]];
}





@dynamic growlWhenLeaves;



- (BOOL)growlWhenLeavesValue {
	NSNumber *result = [self growlWhenLeaves];
	return [result boolValue];
}

- (void)setGrowlWhenLeavesValue:(BOOL)value_ {
	[self setGrowlWhenLeaves:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveGrowlWhenLeavesValue {
	NSNumber *result = [self primitiveGrowlWhenLeaves];
	return [result boolValue];
}

- (void)setPrimitiveGrowlWhenLeavesValue:(BOOL)value_ {
	[self setPrimitiveGrowlWhenLeaves:[NSNumber numberWithBool:value_]];
}





@dynamic hostName;






@dynamic introLastPlayedDate;






@dynamic introTrackArtist;






@dynamic introTrackName;






@dynamic ipv4Address;






@dynamic ipv6Address;






@dynamic isFollowed;



- (BOOL)isFollowedValue {
	NSNumber *result = [self isFollowed];
	return [result boolValue];
}

- (void)setIsFollowedValue:(BOOL)value_ {
	[self setIsFollowed:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFollowedValue {
	NSNumber *result = [self primitiveIsFollowed];
	return [result boolValue];
}

- (void)setPrimitiveIsFollowedValue:(BOOL)value_ {
	[self setPrimitiveIsFollowed:[NSNumber numberWithBool:value_]];
}





@dynamic isFound;



- (BOOL)isFoundValue {
	NSNumber *result = [self isFound];
	return [result boolValue];
}

- (void)setIsFoundValue:(BOOL)value_ {
	[self setIsFound:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsFoundValue {
	NSNumber *result = [self primitiveIsFound];
	return [result boolValue];
}

- (void)setPrimitiveIsFoundValue:(BOOL)value_ {
	[self setPrimitiveIsFound:[NSNumber numberWithBool:value_]];
}





@dynamic isResolved;



- (BOOL)isResolvedValue {
	NSNumber *result = [self isResolved];
	return [result boolValue];
}

- (void)setIsResolvedValue:(BOOL)value_ {
	[self setIsResolved:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsResolvedValue {
	NSNumber *result = [self primitiveIsResolved];
	return [result boolValue];
}

- (void)setPrimitiveIsResolvedValue:(BOOL)value_ {
	[self setPrimitiveIsResolved:[NSNumber numberWithBool:value_]];
}





@dynamic lastFoundDate;






@dynamic macAddress;






@dynamic outroLastPlayedDate;






@dynamic outroTrackArtist;






@dynamic outroTrackName;






@dynamic serviceDomain;






@dynamic serviceName;






@dynamic serviceType;











@end
