//
//  IANetServiceManager.m
//  iArrived
//
//  Created by Ryan Maxwell on 3/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IANetServiceManager.h"
#import "IADevice.h"

#define kAppleMobileDeviceServiceType   @"_apple-mobdev._tcp."
#define kLocalNetworkDomainName         @"local."

@interface IANetServiceManager () <NSNetServiceBrowserDelegate>
@property (nonatomic, strong) NSNetServiceBrowser *browser;
@end

@implementation IANetServiceManager

- (id)init {
    self = [super init];
    
    if (self) {
        _browser = [[NSNetServiceBrowser alloc] init];
        _browser.delegate = self;
    }
    
    return self;
}

+ (id)sharedNetServiceManager {
    static dispatch_once_t once;
    static IANetServiceManager *sharedNetServiceManager;
    dispatch_once(&once, ^ { sharedNetServiceManager = [[self alloc] init]; });
    return sharedNetServiceManager;
}

- (void)startSearchingForServices {
    [self.browser searchForServicesOfType:kAppleMobileDeviceServiceType inDomain:kLocalNetworkDomainName];
}

- (void)stopSearchingForServices {
    [self.browser stop];
}

#pragma mark - NSNetServiceBrowserDelegate

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing {  
    
    IADevice *device = [IADevice deviceOfType:netService.type 
                               inDomain:netService.domain 
                               withName:netService.name];
    if (!device) {
        device = [IADevice createEntity];
    }
    
    device.serviceName = netService.name;
    device.serviceType = netService.type;
    device.serviceDomain = netService.domain;
    device.macAddress = [IAUtilities macAddressFromServiceName:netService.name];
    device.isFound = @YES;
    
    [[NSManagedObjectContext defaultContext] save];
    
    device.netService = netService; // performs resolution on set
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didNotSearch:(NSDictionary *)errorInfo {
    DLog(@"Did Not Search - Error code: %@, domain: %@",
          errorInfo[NSNetServicesErrorCode], 
          errorInfo[NSNetServicesErrorDomain]);
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser {
    DLog(@"Did Stop Search");
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing {
    DLog(@"Removed service %@", netService);
    
    IADevice *device = [IADevice deviceOfType:netService.type 
                               inDomain:netService.domain 
                               withName:netService.name];
    if (device) {
        device.isFound = @NO;
        device.isResolved = @NO;
    }
}

@end
