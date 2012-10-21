#import "_IADevice.h"

@interface IADevice : _IADevice <NSNetServiceDelegate>

@property (nonatomic, strong) NSNetService *netService;
@property (nonatomic, readonly) BOOL isIntroTrackDefined;
@property (nonatomic, readonly) BOOL isOutroTrackDefined;

+ (IADevice *)deviceOfType:(NSString *)serviceType inDomain:(NSString *)domainName withName:(NSString *)serviceName;


@end
