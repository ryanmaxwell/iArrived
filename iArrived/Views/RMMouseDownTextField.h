//
//  RMMouseDownTextField.h
//  iArrived
//
//  Created by Ryan Maxwell on 10/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <AppKit/AppKit.h>
@protocol RMMouseDownTextFieldDelegate;

@interface RMMouseDownTextField : NSTextField
@property (nonatomic, weak) id<RMMouseDownTextFieldDelegate> delegate;
@end

@protocol RMMouseDownTextFieldDelegate <NSTextFieldDelegate>
@required
- (void)mouseDownTextFieldClicked:(NSEvent *)event;
@end