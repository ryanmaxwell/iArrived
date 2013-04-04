//
//  IAPopoverContentViewController.h
//  iArrived
//
//  Created by Ryan Maxwell on 1/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IAPopoverContentViewController : NSViewController

@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;
@property (nonatomic, weak) IBOutlet NSTextField *headerTextField;

- (IBAction)quitButtonPressed:(id)sender;
- (IBAction)preferencesButtonPressed:(id)sender;
@end