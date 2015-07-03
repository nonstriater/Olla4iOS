//
//  UIView+Gesture.m
//  Olla
//
//  Created by null on 14-10-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "UIView+Gesture.h"
#import "Olla4iOS.h"

static const void *UIViewGestureTapBlockKey = &UIViewGestureTapBlockKey;
static const void *UIViewGestureLongPressBlockKey = &UIViewGestureLongPressBlockKey;
static const void *UIViewGestureSwipeBlockKey = &UIViewGestureSwipeBlockKey;


@implementation UIView (Gesture)

// get & set

-(TapGestureBlock)tapBlock{
    return objc_getAssociatedObject(self, UIViewGestureTapBlockKey);
}

- (void)setTapBlock:(TapGestureBlock)tapBlock{
    
    objc_setAssociatedObject(self, UIViewGestureTapBlockKey, tapBlock, OBJC_ASSOCIATION_RETAIN);
}


- (LongPressGestureBlock)longPressBlock{
    return objc_getAssociatedObject(self, UIViewGestureLongPressBlockKey);
}

-(void)setLongPressBlock:(LongPressGestureBlock)longPressBlock{
    objc_setAssociatedObject(self, UIViewGestureLongPressBlockKey, longPressBlock, OBJC_ASSOCIATION_RETAIN);
}

- (SwipeGestureBlock)swipeBlock{
    return objc_getAssociatedObject(self, UIViewGestureSwipeBlockKey);
}

- (void)setSwipeBlock:(SwipeGestureBlock)swipeGesture{
    objc_setAssociatedObject(self, UIViewGestureSwipeBlockKey, swipeGesture, OBJC_ASSOCIATION_RETAIN);
}


- (void)tap:(TapGestureBlock)tapBlock{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturehandler:)];
    [self addGestureRecognizer:tap];
    
    self.tapBlock = tapBlock;
}

- (void)tapGesturehandler:(UITapGestureRecognizer *)tap{

    self.tapBlock(tap);
}


- (void)longPress:(LongPressGestureBlock)longPressBlock{

    UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    [self addGestureRecognizer:lpg];
    
    self.longPressBlock = longPressBlock;
}

// be careful to call twice
- (void)longPressHandler:(UILongPressGestureRecognizer *)longPressGesture{
    
    if (longPressGesture.state == UIGestureRecognizerStateEnded) {
        self.longPressBlock(longPressGesture);
    }
}


- (void)swipe:(SwipeGestureBlock)swipeGesture{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
    [self addGestureRecognizer:swipe];
    
    self.swipeBlock = swipeGesture;
}

- (void)swipeGestureHandler:(UISwipeGestureRecognizer *)swipe{

    self.swipeBlock(swipe);
}



@end
