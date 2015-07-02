//
//  OllaMenuLabel.m
//  OllaMenuLableDemo
//
//  Created by nonstriater on 14-7-11.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaMenuLabel.h"

NSString *OllaMenuLabelBecomeFirstResponderNotification = @"OllaMenuLabelBecomeFirstResponderNotification";

@implementation OllaMenuLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInitial];
    }
    return self;
}

- (void)awakeFromNib{
    [self commonInitial];
    
}

- (void)commonInitial{
    
    self.enablePopupMenu = YES;
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    //longPress.minimumPressDuration = 1.2f;
    _longPressGesture = longPress;
    [self addGestureRecognizer:longPress];
}

- (void)longPressHandler:(UILongPressGestureRecognizer *)gesture{
    
    if (gesture == self.longPressGesture ) {
        
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            [self becomeFirstResponder];
            [[NSNotificationCenter defaultCenter] postNotificationName:OllaMenuLabelBecomeFirstResponderNotification object:nil];
            
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            
            [menuController setTargetRect:self.bounds inView:self];
            [menuController setMenuVisible:YES animated:YES];
        }
    }
    
}

- (void)setEnablePopupMenu:(BOOL)enablePopupMenu{
    
    if (_enablePopupMenu != enablePopupMenu) {
        
        [self willChangeValueForKey:@"enablePopupMenu"];
        _enablePopupMenu = enablePopupMenu;
        [self didChangeValueForKey:@"enablePopupMenu"];
        
        self.userInteractionEnabled = enablePopupMenu;
        self.longPressGesture.enabled = enablePopupMenu;
        
    }
    
}



// label default is no
- (BOOL)canBecomeFirstResponder{
    return self.enablePopupMenu;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    BOOL retValue = NO;
    if(action==@selector(copy:)){
        if (self.enablePopupMenu) {
            return YES;
        }
    }else{
        retValue = [super canPerformAction:action withSender:sender];
    }
    return retValue;
}

- (void)copy:(id)sender{
    
    if (self.enablePopupMenu) {
        
        //可以在代理方法中对复制的内容过个处理，如果需要的话
        
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        board.string = self.text;
        
        //[LLTextMessageCell _didChangeToFirstResponder:] 避免崩溃
        [self resignFirstResponder];
    }
    
}




@end
