//
//  IADeviceTableCellView.m
//  iArrived
//
//  Created by Ryan Maxwell on 9/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import "IADeviceTableCellView.h"
#import "IAAppDelegate.h"
#import "IADevice.h"
#import "IASettingsWindowController.h"

enum DetailLabelState {
    DetailLabelStateIpv4Address = 0,
    DetailLabelStateIpv6Address,
    DetailLabelStateMACAddress,
    DetailLabelStateHostName,
    
    DetailLabelStateCount
}; 
typedef NSUInteger DetailLabelState;

@implementation IADeviceTableCellView {
    DetailLabelState _currentDetailLabelState;
}

- (IBAction)infoPressed:(id)sender {
    IAAppDelegate *appDelegate = (IAAppDelegate *) NSApplication.sharedApplication.delegate;
    
    [appDelegate showSettingsWindow];
    
    IADevice *device = (IADevice *) self.objectValue;
    [appDelegate.settingsWindowController selectDevice:device];
}

- (void)mouseDownTextFieldClicked:(NSEvent *)event {
    _currentDetailLabelState++;
    
    if (_currentDetailLabelState == DetailLabelStateCount) {
        _currentDetailLabelState = 0;
    }
    
    IADevice *device = (IADevice *)self.objectValue;
    
    switch (_currentDetailLabelState) {
        case DetailLabelStateIpv4Address: {
            if (device.ipv4Address) {
                [self.detailTextField setStringValue:device.ipv4Address];
            } else {
                [self.detailTextField setStringValue:@"Unresolved ipv4 address"];
            }
            break;
        }
        case DetailLabelStateIpv6Address: {
            if (device.ipv4Address) {
                [self.detailTextField setStringValue:device.ipv6Address];
            } else {
                [self.detailTextField setStringValue:@"Unresolved ipv6 address"];
            }
            break;
        }
        case DetailLabelStateMACAddress: {
            if (device.macAddress) {
                [self.detailTextField setStringValue:device.macAddress];
            }
            break;
        }
        case DetailLabelStateHostName: {
            if (device.hostName) {
                [self.detailTextField setStringValue:device.hostName];
            } else {
                [self.detailTextField setStringValue:@"Unresolved host name"];
            }
            break;
        }
        default:
            break;
    }
}

@end
