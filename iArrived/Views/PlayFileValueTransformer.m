//
//  PlayFileValueTransformer.m
//  iArrived
//
//  Created by Ryan Maxwell on 4/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "PlayFileValueTransformer.h"

#define kPlayFileOptionNeverString          @"Never"
#define kPlayFileOptionEveryTimeString      @"Every Time"
#define kPlayFileOptionOncePerHourString    @"Maximum Once Per Hour"
#define kPlayFileOptionOncePerDayString     @"Maximum Once Per Day"

@implementation PlayFileValueTransformer

+ (NSString *)stringForPlayFileOption:(PlayFileOption)playFileOption {
    
    switch (playFileOption) {
        case PlayFileOptionNever:
            return kPlayFileOptionNeverString;
        case PlayFileOptionEveryTime:
            return kPlayFileOptionEveryTimeString;
        case PlayFileOptionOncePerDay:
            return kPlayFileOptionOncePerDayString;
        case PlayFileOptionOncePerHour:
            return kPlayFileOptionOncePerHourString;
    }
}

+ (PlayFileOption)playFileOptionForString:(NSString *)string {
    if ([string isEqualToString:kPlayFileOptionNeverString])
        return PlayFileOptionNever;
    else if ([string isEqualToString:kPlayFileOptionEveryTimeString])
        return PlayFileOptionEveryTime;
    else if ([string isEqualToString:kPlayFileOptionOncePerHourString])
        return PlayFileOptionOncePerHour;
    else if ([string isEqualToString:kPlayFileOptionOncePerDayString])
        return PlayFileOptionOncePerDay;
    else
        return NSNotFound;
}

+ (BOOL)shouldPlayFileWithLastPlayedDate:(NSDate *)lastPlayedDate playFileOption:(PlayFileOption)playFileOption {
    if (lastPlayedDate == nil && playFileOption != PlayFileOptionNever) return YES;
    
    BOOL shouldPlayFile = NO;
    
    switch (playFileOption) {
        case PlayFileOptionEveryTime:
            shouldPlayFile = YES;
            break;
        case PlayFileOptionNever:
            shouldPlayFile = NO;
            break;
        case PlayFileOptionOncePerDay: {
            // allow playing once per calendar day - e.g if plays at 11:59 tuesday it's allowed to play again 12:01 wed
            
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *lastPlayedComponents = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit 
                                                            fromDate:lastPlayedDate];
            
            NSDate *lastPlayedDay = [cal dateFromComponents:lastPlayedComponents];
            DLog(@"Last Played Day: %@", lastPlayedDay);
            
            NSDateComponents *nowComponents = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit 
                                                     fromDate:[NSDate date]];
            
            NSDate *nowDay = [cal dateFromComponents:nowComponents];
            DLog(@"Now Day: %@", nowDay);
            
            shouldPlayFile = [lastPlayedDay isEqualToDate:nowDay] ? NO : YES;
            
            break;
        }
        case PlayFileOptionOncePerHour: {
            // an hour must have passed between plays
            
            NSTimeInterval oneHour = 3600;
            
            if ([[NSDate date] timeIntervalSinceDate:lastPlayedDate] > oneHour) {
                shouldPlayFile = YES;
            }
            
            break;
        }
        default:
            break;
    }
    
    return shouldPlayFile;
}

#pragma mark - Value Transformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        // forward transformation
        return [[self class] stringForPlayFileOption:[value integerValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        // reverse transformation
        return @([[self class] playFileOptionForString:value]);
    } else {
        return nil;
    }
}

- (id)reverseTransformedValue:(id)value {
    return [self transformedValue:value];
}

@end
