//
//  IAMouseDownTextField.m
//  iArrived
//
//  Created by Ryan Maxwell on 10/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IAMouseDownTextField.h"

@implementation IAMouseDownTextField

- (void)setDelegate:(id<NSTextFieldDelegate>)anObject {
    [super setDelegate:anObject];
}

- (id)delegate {
    return [super delegate];
}

- (void)mouseDown:(NSEvent *)theEvent {
    [self.delegate mouseDownTextFieldClicked:theEvent];
}

@end
