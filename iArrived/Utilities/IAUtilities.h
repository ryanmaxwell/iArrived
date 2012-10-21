//
//  IAUtilities.h
//  iArrived
//
//  Created by Ryan Maxwell on 29/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAUtilities : NSObject

+ (void)playTrackWithName:(NSString *)name artist:(NSString *)optionalArtist;
+ (NSString *)macAddressFromServiceName:(NSString *)appleMobileDeviceServiceName;
+ (BOOL)executeScriptWithPath:(NSString *)path function:(NSString *)functionName arguments:(NSArray *)scriptArgumentArray;

@end
