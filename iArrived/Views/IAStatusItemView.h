//
//  IAStatusItemView.h
//  iArrived
//
//  Created by Ryan Maxwell on 1/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol IAStatusItemViewDelegate;

@interface IAStatusItemView : NSView

@property (nonatomic, weak) id<IAStatusItemViewDelegate> delegate;
@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, strong) NSImage *blackImage;
@property (nonatomic, strong) NSImage *whiteImage;

@end

@protocol IAStatusItemViewDelegate <NSObject>
@required
- (void)statusItemViewClicked;
- (BOOL)isActive;
@end