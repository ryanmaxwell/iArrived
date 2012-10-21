//
//  IAStatusItemView.m
//  iArrived
//
//  Created by Ryan Maxwell on 1/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IAStatusItemView.h"

@implementation IAStatusItemView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[NSImageView alloc] initWithFrame:frame];
        [self addSubview:_imageView];
        _blackImage = [NSImage imageNamed:@"StatusItem-Black.png"];
        _whiteImage = [NSImage imageNamed:@"StatusItem-White.png"];
    }
    
    return self;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

- (void)drawRect:(NSRect)rect {
    if ([self.delegate isActive]) {
        self.imageView.image = self.whiteImage;
        [[NSColor selectedMenuItemColor] set];
        NSRectFill(rect);
    } else {
        self.imageView.image = self.blackImage;
    }
}

- (void)mouseDown:(NSEvent *)event {
    [self setNeedsDisplay:YES];
    [self.delegate statusItemViewClicked];
}


@end
