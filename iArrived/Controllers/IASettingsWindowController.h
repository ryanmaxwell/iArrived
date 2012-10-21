//
//  IASettingsWindowController.h
//  iArrived
//
//  Created by Ryan Maxwell on 2/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class IADevice;

@interface IASettingsWindowController : NSWindowController <NSOutlineViewDelegate, NSOutlineViewDataSource>

@property (nonatomic, weak) IBOutlet NSTreeController *treeController;

@property (nonatomic, weak) IBOutlet NSView *sourceListContainerView;
@property (nonatomic, weak) IBOutlet NSOutlineView *sourceList;

@property (nonatomic, weak) IBOutlet NSTextField *introTrackNameTextField;
@property (nonatomic, weak) IBOutlet NSTextField *introTrackArtistTextField;
@property (nonatomic, weak) IBOutlet NSTextField *outroTrackNameTextField;
@property (nonatomic, weak) IBOutlet NSTextField *outroTrackArtistTextField;

- (IBAction)playIntroTrack:(id)sender;
- (IBAction)playOutroTrack:(id)sender;
- (IBAction)toggleAdvanced:(id)sender;

- (void)selectDevice:(IADevice *)device;

@end
