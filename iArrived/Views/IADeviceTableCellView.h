//
//  IADeviceTableCellView.h
//  iArrived
//
//  Created by Ryan Maxwell on 9/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "RMMouseDownTextField.h"

@interface IADeviceTableCellView : NSTableCellView  <RMMouseDownTextFieldDelegate>

@property (nonatomic, weak) IBOutlet RMMouseDownTextField *detailTextField;

- (IBAction)infoPressed:(id)sender;

@end
