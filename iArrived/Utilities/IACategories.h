//
//  IACategories.h
//  iArrived
//
//  Created by Ryan Maxwell on 28/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (RMAdditions)

- (int)port;
- (NSString *)address;
- (BOOL)isIPv4Address;
- (BOOL)isIPv6Address;

@end