#import "_IAGroup.h"

typedef NS_ENUM(NSInteger, IAGroupType) {
    IAGroupTypeFound = 1,
    IAGroupTypeNotFound
};

@interface IAGroup : _IAGroup

@property (nonatomic, readonly) NSString *displayName;

+ (NSString *)displayNameForGroupType:(IAGroupType)groupType;

+ (IAGroup *)foundDevicesGroup;
+ (IAGroup *)notFoundDevicesGroup;

@end
