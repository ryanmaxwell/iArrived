//
//  IAPopoverContentViewController.m
//  iArrived
//
//  Created by Ryan Maxwell on 1/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IAPopoverContentViewController.h"
#import "IAAppDelegate.h"
#import "IADevice.h"

@implementation IAPopoverContentViewController

// designated initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //nada
    }
    
    return self;
}

- (void)awakeFromNib {
    self.arrayController.fetchPredicate = [NSPredicate predicateWithFormat:@"%K == YES && %K == YES", 
                                           IADeviceAttributes.isFound, 
                                           IADeviceAttributes.isFollowed];
    self.arrayController.entityName = [IADevice entityName];
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:IADeviceAttributes.hostName ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:IADeviceAttributes.serviceName ascending:YES];
    
    self.arrayController.sortDescriptors = @[sortDescriptor1, sortDescriptor2];
    
    
    self.arrayController.managedObjectContext = [NSManagedObjectContext defaultContext];
    
    
    [self.arrayController addObserver:self 
                           forKeyPath:@"arrangedObjects.@count" 
                              options:NSKeyValueObservingOptionNew
                              context:NULL];
    
    [self.arrayController fetch:self];
    
    [self.headerTextField.cell setBackgroundStyle:NSBackgroundStyleRaised];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self.arrayController && [keyPath isEqualToString:@"arrangedObjects.@count"]) {
        NSInteger numberOfRows = [self.tableView numberOfRows]; 
        // TODO: should be the NSKeyValueObservingOptionNew but I can't figure that NSValue shit out
        
        NSDictionary *userInfo = @{@"numberOfRows": @(numberOfRows)};
        
        NSNotification *notification = [NSNotification notificationWithName:@"PopoverTableViewDidUpdateNumberOfRows" 
                                                                     object:self 
                                                                   userInfo:userInfo];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}

#pragma mark - IBActions

- (IBAction)preferencesButtonPressed:(id)sender {
    IAAppDelegate *appDelegate = (IAAppDelegate *) NSApplication.sharedApplication.delegate;
    [appDelegate toggleSettingsWindow];
}

@end
