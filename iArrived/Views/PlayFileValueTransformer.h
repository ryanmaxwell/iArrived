//
//  PlayFileValueTransformer.h
//  iArrived
//
//  Created by Ryan Maxwell on 4/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PlayFileOption) {
    PlayFileOptionNever = 0,
    PlayFileOptionEveryTime,
    PlayFileOptionOncePerHour,
    PlayFileOptionOncePerDay
};

@interface PlayFileValueTransformer : NSValueTransformer

+ (NSString *)stringForPlayFileOption:(PlayFileOption)playFileOption;
+ (PlayFileOption)playFileOptionForString:(NSString *)string;

+ (BOOL)shouldPlayFileWithLastPlayedDate:(NSDate *)lastPlayedDate playFileOption:(PlayFileOption)playFileOption;

@end
