//
//  IACategories.m
//  iArrived
//
//  Created by Ryan Maxwell on 28/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import "IACategories.h"

#import <netinet/in.h>
#include <arpa/inet.h>

@implementation NSData (Additions)

- (BOOL)isIPv4Address {
    struct sockaddr *addr = (struct sockaddr *)[self bytes];
    return (addr->sa_family == AF_INET) ? YES : NO;
}

- (BOOL)isIPv6Address {
    struct sockaddr *addr = (struct sockaddr *)[self bytes];
    return (addr->sa_family == AF_INET6) ? YES : NO;
}

- (int)port {
    int port;
    struct sockaddr *addr = (struct sockaddr *)[self bytes];
    
    if([self isIPv4Address]) {
        uint16_t netshort = ((struct sockaddr_in *)addr)->sin_port;
        port = ntohs(netshort);
    }
    else if([self isIPv6Address]) {
        uint16_t netshort = ((struct sockaddr_in6 *)addr)->sin6_port;
        port = ntohs(netshort);
    }
    else {
        // The family is neither IPv4 nor IPv6. Can't handle.
        port = 0;
    }
    
    return port;
}


- (NSString *)address {
    struct sockaddr *addr = (struct sockaddr *)[self bytes];
    
    if([self isIPv4Address]) {
        struct sockaddr_in *addr4 = (struct sockaddr_in *)addr;
        struct in_addr in = addr4->sin_addr;
        
        char *address = (char *)inet_ntoa(in);
        if (address)
            return @(address);
    }
    else if([self isIPv6Address]) {
        struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)addr;
        
        char straddr[INET6_ADDRSTRLEN];
        inet_ntop(AF_INET6, &(addr6->sin6_addr), straddr, sizeof(straddr));
        return @(straddr);
    }

    return nil;
}

@end
