//
//  IAAppDelegate.h
//  iArrived
//
//  Created by Ryan Maxwell on 30/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IAStatusItemView.h"
@class IASettingsWindowController;

@interface IAAppDelegate : NSObject <NSApplicationDelegate, IAStatusItemViewDelegate>

@property (nonatomic, weak) IBOutlet NSView *windowView;
@property (nonatomic, assign, getter = isActive) BOOL active;

@property (nonatomic, strong) IASettingsWindowController *settingsWindowController;

- (void)showSettingsWindow;
- (void)toggleSettingsWindow;

@end
