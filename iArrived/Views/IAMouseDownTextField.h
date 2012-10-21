//
//  IAMouseDownTextField.h
//  iArrived
//
//  Created by Ryan Maxwell on 10/01/12.
//  Copyright (c) 2012 Cactuslab. All rights reserved.
//

#import <AppKit/AppKit.h>
@protocol IAMouseDownTextFieldDelegate;

@interface IAMouseDownTextField : NSTextField
@property (nonatomic, weak) id<IAMouseDownTextFieldDelegate> delegate;
@end

@protocol IAMouseDownTextFieldDelegate <NSTextFieldDelegate>
@required
- (void)mouseDownTextFieldClicked:(NSEvent *)event;
@end