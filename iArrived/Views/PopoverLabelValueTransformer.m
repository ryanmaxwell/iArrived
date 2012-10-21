//
//  PopoverLabelValueTransformer.m
//  iArrived
//
//  Created by Ryan Maxwell on 3/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "PopoverLabelValueTransformer.h"

@implementation PopoverLabelValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    if (value == nil) return @"";
    
    NSInteger deviceCount = [value integerValue];
    
    //NSLog(@"VT %ld", deviceCount);
    
    NSString *label = @"";
    
    if (deviceCount == 0) {
        label = @"No followed devices found";
    } else if (deviceCount == 1) {
        label = @"1 followed device found";
    } else if (deviceCount > 1) {
        label = [NSString stringWithFormat:@"%ld followed devices found", deviceCount];
    }
    
    return [label uppercaseString];
}

@end
