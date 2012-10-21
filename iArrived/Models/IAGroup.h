#import "_IAGroup.h"

typedef enum  {
    IAGroupTypeFound = 1,
    IAGroupTypeNotFound = 2
} IAGroupType;

@interface IAGroup : _IAGroup

@property (nonatomic, readonly) NSString *displayName;

+ (NSString *)displayNameForGroupType:(IAGroupType)groupType;

+ (IAGroup *)foundDevicesGroup;
+ (IAGroup *)notFoundDevicesGroup;

@end
