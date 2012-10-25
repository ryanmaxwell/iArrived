#import "IADevice.h"
#import "PlayFileValueTransformer.h"
#import "IAGroup.h"
#import <Growl/Growl.h>

#define kAddressResolutionTimeout       5.0

@implementation IADevice
@synthesize netService = _netService;

+ (IADevice *)deviceOfType:(NSString *)serviceType inDomain:(NSString *)domainName withName:(NSString *)serviceName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@ AND %K == %@", 
     IADeviceAttributes.serviceType, serviceType, 
     IADeviceAttributes.serviceDomain, domainName, 
     IADeviceAttributes.serviceName, serviceName];
    
    return [IADevice findFirstWithPredicate:predicate];
}

- (void)awakeFromInsert {
    // always initialize these to false - not through setters as this plays intro/outro
    [self willChangeValueForKey:IADeviceAttributes.isFound];
    [self setPrimitiveIsFoundValue:NO];
    [self didChangeValueForKey:IADeviceAttributes.isFound];
    
    [self willChangeValueForKey:IADeviceAttributes.isResolved];
    [self setPrimitiveIsResolvedValue:NO];
    [self didChangeValueForKey:IADeviceAttributes.isResolved];
    
    [self willChangeValueForKey:IATreeMemberAttributes.isLeaf];
    [self setPrimitiveIsLeafValue:YES];
    [self didChangeValueForKey:IATreeMemberAttributes.isLeaf];
}

#pragma mark - Getters

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@)", self.serviceName, self.displayName];
}

- (BOOL)isIntroTrackDefined {
    return (self.introTrackName != nil && ![self.introTrackName isEqualToString:@""]) ? YES : NO;
}

- (BOOL)isOutroTrackDefined {
    return (self.outroTrackName != nil && ![self.outroTrackName isEqualToString:@""]) ? YES : NO;
}

- (NSString *)displayName {
    [self willAccessValueForKey:IATreeMemberAttributes.displayName];
    NSString *name = [self primitiveDisplayName];
    [self didAccessValueForKey:IATreeMemberAttributes.displayName];
    
    if (name)
        return name;
    
    if (self.hostName)
        return self.hostName;
    
    return self.serviceName;
}

#pragma mark - Setters

- (void)setNetService:(NSNetService *)netService {
    if (_netService != netService) {
        _netService.delegate = nil;
        _netService = netService;
        
        netService.delegate = self;
        [netService resolveWithTimeout:kAddressResolutionTimeout];
    }
}

- (void)setHostName:(NSString *)hostName {
    // need to fire change notifications for display name so bound UI values update to hostname if no display name set
    [self willChangeValueForKey:IADeviceAttributes.hostName];
    [self willChangeValueForKey:IATreeMemberAttributes.displayName];
    [self setPrimitiveHostName:hostName];
    [self didChangeValueForKey:IADeviceAttributes.hostName];
    [self didChangeValueForKey:IATreeMemberAttributes.displayName];
}

- (void)setIsFoundValue:(BOOL)isFound {
    [self willChangeValueForKey:IADeviceAttributes.isFound];
    [self setPrimitiveIsFoundValue:isFound];
    [self didChangeValueForKey:IADeviceAttributes.isFound];
    
    NSDictionary *contextDictionary = @{@"serviceName": self.serviceName,
                                       @"serviceType": self.serviceType,
                                       @"serviceDomain": self.serviceDomain};
    
    if (isFound) {
        [[IAGroup foundDevicesGroup] addChildrenObject:self];
        [[IAGroup notFoundDevicesGroup] removeChildrenObject:self];
        NSNotification *moveNotification = [NSNotification notificationWithName:@"DeviceDidMoveGroup" 
                                                                         object:self 
                                                                       userInfo:@{@"NewGroupKey": @"FOUND", 
                                                                                 @"OldGroupKey": @"NOT FOUND"}];
        [[NSNotificationCenter defaultCenter] postNotification:moveNotification];
        
        self.lastFoundDate = [NSDate date];
        
        if (self.isFollowed) {
            if (self.growlWhenArrives) {
                NSString *deviceName = self.displayName ? self.displayName : self.serviceName;
                
                [GrowlApplicationBridge notifyWithTitle:@"Device Arrived"
                                            description:[NSString stringWithFormat:@"%@ was found on the network", deviceName]
                                       notificationName:@"deviceWasFound" 
                                               iconData:nil 
                                               priority:0 
                                               isSticky:NO 
                                           clickContext:contextDictionary];
            }
            
            if (self.isIntroTrackDefined) {
                PlayFileOption playIntroFileOption = [[NSUserDefaults standardUserDefaults] integerForKey:@"playIntroFileOption"];
                
                BOOL shouldPlayIntro = [PlayFileValueTransformer shouldPlayFileWithLastPlayedDate:self.introLastPlayedDate playFileOption:playIntroFileOption];
                
                if (shouldPlayIntro) {
                    DLog(@"PLAYING INTRO");
                    self.introLastPlayedDate = [NSDate date];
                    [IAUtilities playTrackWithName:self.introTrackName artist:self.introTrackArtist];
                } else {
                    DLog(@"NOT PLAYING INTRO");
                }
            }
        }
        
    } else {
        // "unfound"
        [[IAGroup foundDevicesGroup] removeChildrenObject:self];
        [[IAGroup notFoundDevicesGroup] addChildrenObject:self];
        NSNotification *moveNotification = [NSNotification notificationWithName:@"DeviceDidMoveGroup" 
                                                                         object:self 
                                                                       userInfo:@{@"NewGroupKey": @"NOT FOUND", 
                                                                                 @"OldGroupKey": @"FOUND"}];
        [[NSNotificationCenter defaultCenter] postNotification:moveNotification];
        
        if (self.isFollowed) {
            if (self.growlWhenLeaves) {
                NSString *deviceName = self.displayName ? self.displayName : self.serviceName;
                
                [GrowlApplicationBridge notifyWithTitle:@"Device Left"
                                            description:[NSString stringWithFormat:@"%@ left the network", deviceName]
                                       notificationName:@"deviceWasUnfound" 
                                               iconData:nil 
                                               priority:0 
                                               isSticky:NO 
                                           clickContext:contextDictionary];
            }
            
            if (self.isOutroTrackDefined) {
                PlayFileOption playOutroFileOption = [[NSUserDefaults standardUserDefaults] integerForKey:@"playOutroFileOption"];
                
                BOOL shouldPlayOutro = [PlayFileValueTransformer shouldPlayFileWithLastPlayedDate:self.outroLastPlayedDate playFileOption:playOutroFileOption];
                
                if (shouldPlayOutro) {
                    DLog(@"PLAYING OUTRO");
                    self.outroLastPlayedDate = [NSDate date];
                    [IAUtilities playTrackWithName:self.outroTrackName artist:self.outroTrackArtist];
                } else {
                    DLog(@"NOT PLAYING OUTRO");
                }
            }
        }
    }
}

#pragma mark - NSNetServiceDelegate

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    DLog(@"DID RESOLVE %@", sender);
    
    self.isResolvedValue = YES;
    
    for (NSData *socketData in [sender addresses]) {
        if (socketData.isIPv4Address) {
            self.ipv4Address = [socketData address];
        } else if (socketData.isIPv6Address) {
            self.ipv6Address = [socketData address];        
        }
    }
    
    self.hostName = sender.hostName;
    
    //    self.netService.delegate = nil;
    //    self.netService = nil;
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
    DLog(@"DID NOT RESOLVE %@ - error code: %@ domain: %@", 
         sender, 
         errorDict[NSNetServicesErrorCode], 
         errorDict[NSNetServicesErrorDomain]);
    
    self.isResolvedValue = NO;
    
    //    self.netService.delegate = nil;
    //    self.netService = nil;
}

// called after timeout - even if resolved
- (void)netServiceDidStop:(NSNetService *)sender {
    DLog(@"DID STOP - Timeout Reached %@", sender);
}

@end
