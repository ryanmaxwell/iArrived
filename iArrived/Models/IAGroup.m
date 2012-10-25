#import "IAGroup.h"

@implementation IAGroup

- (void)awakeFromInsert {
    [self willChangeValueForKey:IATreeMemberAttributes.isLeaf];
    [self setPrimitiveIsLeafValue:NO];
    [self didChangeValueForKey:IATreeMemberAttributes.isLeaf];
}

+ (NSString *)displayNameForGroupType:(IAGroupType)groupType {
    switch (groupType) {
        case IAGroupTypeFound:
            return @"FOUND";
        case IAGroupTypeNotFound:
            return @"NOT FOUND";
    }
}

+ (IAGroup *)foundDevicesGroup {
    static IAGroup *foundDevicesGroup;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        foundDevicesGroup = [IAGroup findFirstByAttribute:IAGroupAttributes.groupType 
                                                withValue:@(IAGroupTypeFound)];
        
        if (!foundDevicesGroup) {
            foundDevicesGroup = [IAGroup createEntity];
            foundDevicesGroup.groupTypeValue = IAGroupTypeFound;
            [[NSManagedObjectContext defaultContext] save];
        }
    });
    return foundDevicesGroup;
}

+ (IAGroup *)notFoundDevicesGroup {
    static IAGroup *notFoundDevicesGroup;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notFoundDevicesGroup = [IAGroup findFirstByAttribute:IAGroupAttributes.groupType 
                                                   withValue:@(IAGroupTypeNotFound)];
        
        if (!notFoundDevicesGroup) {
            notFoundDevicesGroup = [IAGroup createEntity];
            notFoundDevicesGroup.groupTypeValue = IAGroupTypeNotFound;
            [[NSManagedObjectContext defaultContext] save];
        }
    });
    return notFoundDevicesGroup;
}

- (NSString *)displayName {
    return [[self class] displayNameForGroupType:self.groupTypeValue];
}

- (void)setGroupType:(NSNumber *)groupType {
    [self willChangeValueForKey:IAGroupAttributes.groupType];
    [self setPrimitiveGroupType:groupType];
    [self didChangeValueForKey:IAGroupAttributes.groupType];
    
    [self willChangeValueForKey:IATreeMemberAttributes.displayName];
    [self setPrimitiveDisplayName:[[self class] displayNameForGroupType:[groupType integerValue]]];
    [self didChangeValueForKey:IATreeMemberAttributes.displayName];
}

@end
