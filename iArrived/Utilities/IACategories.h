//
//  IACategories.h
//  iArrived
//
//  Created by Ryan Maxwell on 28/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NetworkAddressingAdditions)

@property (nonatomic, readonly) int port;
@property (nonatomic, readonly) NSString *address;
@property (nonatomic, readonly) BOOL isIPv4Address;
@property (nonatomic, readonly) BOOL isIPv6Address;

@end
