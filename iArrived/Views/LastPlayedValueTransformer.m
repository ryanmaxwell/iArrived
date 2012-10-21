//
//  LastPlayedValueTransformer.m
//  iArrived
//
//  Created by Ryan Maxwell on 3/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "LastPlayedValueTransformer.h"

@implementation LastPlayedValueTransformer

- (id)init {
    self = [super init];
    
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [_dateFormatter setDoesRelativeDateFormatting:YES];
    }
    
    return self;
}

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    if (value == nil) {
        return @"Never Played";
    } else {
        return [NSString stringWithFormat:@"Last Played %@", [self.dateFormatter stringFromDate:value]];
    }
}

@end
