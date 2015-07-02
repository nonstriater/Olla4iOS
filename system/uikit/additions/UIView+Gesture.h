//
//  UIView+Gesture.h
//  Olla
//
//  Created by null on 14-10-23.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapGestureBlock)(UITapGestureRecognizer *tapGesture) ;
typedef void (^LongPressGestureBlock)(UILongPressGestureRecognizer *longPressGesture);
typedef void (^SwipeGestureBlock)(UISwipeGestureRecognizer *swipeGesture);

@interface UIView (Gesture)

@property(nonatomic,strong) TapGestureBlock tapBlock;
@property(nonatomic,strong) LongPressGestureBlock longPressBlock;
@property(nonatomic,strong) SwipeGestureBlock swipeBlock;

- (void)tap:(TapGestureBlock)tapBlock;
- (void)longPress:(LongPressGestureBlock)longPressBlock;
- (void)swipe:(SwipeGestureBlock)swipeGesture;

@end
