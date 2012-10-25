//
//  IAAppDelegate.m
//  iArrived
//
//  Created by Ryan Maxwell on 30/12/11.
//  Copyright (c) 2011 Cactuslab. All rights reserved.
//

#import "IAAppDelegate.h"
#import "IAPopoverContentViewController.h"
#import "IASettingsWindowController.h"
#import "IANetServiceManager.h"
#import "IADevice.h"
#import "IAGroup.h"
#import "IAStatusItemView.h"

#import <Growl/Growl.h>

@interface IAAppDelegate () <NSPopoverDelegate, GrowlApplicationBridgeDelegate, IAStatusItemViewDelegate, NSUserNotificationCenterDelegate>
@property (nonatomic, strong) IAPopoverContentViewController *popoverContentViewController;
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSPopover *popover;
@property (nonatomic, assign) NSInteger currentNumberOfRowsInPopover;
- (void)configureStatusBar;
- (void)registerGrowl;
- (void)popoverTableViewDidUpdateNumberOfRows:(NSNotification *)notification;
@end

@implementation IAAppDelegate

+ (void)initialize {
   // set defaults for plist if not there
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"playIntroFileOption"]) {
        [defaults setObject:@1 forKey:@"playIntroFileOption"];
    }
    
    if (![defaults objectForKey:@"playOutroFileOption"]) {
        [defaults setObject:@1 forKey:@"playOutroFileOption"];
    }
    
    [defaults synchronize];
}

- (void)groupDevices {
    IAGroup *foundDevices = [IAGroup foundDevicesGroup];
    [foundDevices removeChildren:foundDevices.children];
    
    IAGroup *notFoundDevices = [IAGroup notFoundDevicesGroup];
    [notFoundDevices addChildren:[NSSet setWithArray:[IADevice findAll]]];
    
    [NSManagedObjectContext.defaultContext save];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self configureStatusBar];
    [self registerGrowl];
    [self groupDevices];
    
    [IANetServiceManager.sharedNetServiceManager startSearchingForServices];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                             selector:@selector(popoverTableViewDidUpdateNumberOfRows:) 
                                                 name:@"PopoverTableViewDidUpdateNumberOfRows" 
                                               object:nil];
    
    if (NSClassFromString(@"NSUserNotificationCenter") != nil) {
        NSUserNotificationCenter.defaultUserNotificationCenter.delegate = self;
    }
}

/**
 Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
 */
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return NSManagedObjectContext.defaultContext.undoManager;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)awakeFromNib {
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    _settingsWindowController = [[IASettingsWindowController alloc] initWithWindowNibName:@"IASettingsWindowController"];
}


//- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
//    [self.window makeKeyAndOrderFront:nil];
//    return YES;
//}

- (void)configureStatusBar {
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
    
    CGFloat statusBarHeight = [statusBar thickness];
    
    NSStatusItem *statusItem = [statusBar statusItemWithLength:statusBarHeight];
    self.statusItem = statusItem;
    [self.statusItem setHighlightMode:YES];
    
    IAStatusItemView *statusItemView = [[IAStatusItemView alloc] initWithFrame:NSMakeRect(0,0, statusBarHeight, statusBarHeight)];
    statusItemView.delegate = self;
    self.statusItem.view = statusItemView;
}

- (void)registerGrowl {
    NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
    NSString *growlPath = [[myBundle privateFrameworksPath]
                           stringByAppendingPathComponent:@"Growl.framework"];
    NSBundle *growlBundle = [NSBundle bundleWithPath:growlPath];
    if (growlBundle && [growlBundle load]) {
        // Register ourselves as a Growl delegate
        [GrowlApplicationBridge setGrowlDelegate:self];
    } else {
        NSLog(@"Could not load Growl.framework");
    }

}

- (void)growlNotificationWasClicked:(id)clickContext {
    NSDictionary *contextDictionary = (NSDictionary *) clickContext;
    
    IADevice *device = [IADevice deviceOfType:contextDictionary[@"serviceType"] 
                                 inDomain:contextDictionary[@"serviceDomain"] 
                                 withName:contextDictionary[@"serviceName"]];
    
    if (device) {
        [self showSettingsWindow];
        [self.settingsWindowController selectDevice:device];
    }
}
         
- (void)showSettingsWindow {
    if (!self.settingsWindowController.window.isKeyWindow) {
        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
        [self.settingsWindowController.window makeKeyAndOrderFront:nil];
    }
}

- (void)toggleSettingsWindow {
    if (self.settingsWindowController.window.isVisible) {
        [self.settingsWindowController.window close];
    } else {
        [self showSettingsWindow];
    }
}

#pragma mark - NSUserNotificationCenterDelegate

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification {
    return YES;
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
    NSDictionary *contextDictionary = notification.userInfo;
    
    IADevice *device = [IADevice deviceOfType:contextDictionary[@"serviceType"]
                                     inDomain:contextDictionary[@"serviceDomain"]
                                     withName:contextDictionary[@"serviceName"]];
    
    if (device) {
        [self showSettingsWindow];
        [self.settingsWindowController selectDevice:device];
    }
}

#pragma mark - StatusBarViewDelegate

- (void)statusItemViewClicked {
    if(self.popover.isShown) {
        self.active = NO;
        [self.popover performClose:self];
    } else {
        self.active = YES;
//        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
        [self.popover showRelativeToRect:self.statusItem.view.frame ofView:self.statusItem.view preferredEdge:NSMinYEdge];
    }
}

#pragma mark - Popover & Popover Resizing

- (NSPopover *)popover {
    if (!_popover) {
        _popover = [[NSPopover alloc] init];
        _popover.delegate = self;
        
        _currentNumberOfRowsInPopover = NSNotFound; // initialize to unset value
        
        _popoverContentViewController = [[IAPopoverContentViewController alloc] initWithNibName:@"IAPopoverContentViewController" 
                                                                                       bundle:nil];
        
        _popover.contentViewController = self.popoverContentViewController;
//        _popover.animates = NO;
        _popover.appearance = NSPopoverAppearanceMinimal;
    }
    return _popover;
}

- (void)setCurrentNumberOfRowsInPopover:(NSInteger)currentNumberOfRowsInPopover {
    if (_currentNumberOfRowsInPopover != currentNumberOfRowsInPopover) {
        _currentNumberOfRowsInPopover = currentNumberOfRowsInPopover;
        
        DLog(@"Resizing Popover for %ld rows", currentNumberOfRowsInPopover);
        CGFloat rowHeight = 40.0;
        CGFloat viewHeightWithOneRowVisible = 82.0;
        
        CGFloat height = (viewHeightWithOneRowVisible - rowHeight) + (currentNumberOfRowsInPopover * rowHeight);
        self.popover.contentSize = CGSizeMake(self.popover.contentSize.width, height);
    }
}

- (void)popoverTableViewDidUpdateNumberOfRows:(NSNotification *)notification {
    if ([self.popover isShown]) {
        self.currentNumberOfRowsInPopover = [[notification userInfo][@"numberOfRows"] integerValue];
    }
}

#pragma mark - NSPopoverDelegate

- (void)popoverWillShow:(NSNotification *)notification {
    self.currentNumberOfRowsInPopover = [self.popoverContentViewController.tableView numberOfRows];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    
    NSManagedObjectContext *defaultContext = [NSManagedObjectContext defaultContext];

    if (![defaultContext commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }

    if (![defaultContext hasChanges]) {
        [MagicalRecord cleanUp];
        return NSTerminateNow;
    }

    NSError *error = nil;
    if (![defaultContext save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    [MagicalRecord cleanUp];
    return NSTerminateNow;
}

@end
