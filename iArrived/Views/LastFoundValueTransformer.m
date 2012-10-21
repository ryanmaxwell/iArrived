//
//  LastFoundValueTransformer.m
//  iArrived
//
//  Created by Ryan Maxwell on 9/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "LastFoundValueTransformer.h"

@implementation LastFoundValueTransformer

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
        return @"Never Seen";
    } else {
        return [NSString stringWithFormat:@"Last Found %@", [self.dateFormatter stringFromDate:value]];
    }
}
@end
