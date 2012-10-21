//
//  IADeviceTableCellView.h
//  iArrived
//
//  Created by Ryan Maxwell on 9/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "IAMouseDownTextField.h"

@interface IADeviceTableCellView : NSTableCellView  <IAMouseDownTextFieldDelegate>

@property (nonatomic, weak) IBOutlet IAMouseDownTextField *detailTextField;

- (IBAction)infoPressed:(id)sender;

@end
