//
//  UIView+additions.h
//  FuShuo
//
//  Created by nonstriater on 14-1-26.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (additions)

@property (nonatomic,assign) CGFloat originX;
@property (nonatomic,assign) CGFloat originY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;


- (UIImage *)convertToImage;

/**
 *  取UIView上的一块区域作为image
 *
 *  @param rect rect
 *
 *  @return 
 */
- (UIImage *)imageWithRect:(CGRect)rect;

- (void)blurWithRadius:(CGFloat)radius;

/**
 * 设置view.layer 的mask 属性
 * 这里的image需要是已经resing过的
 *  @param image
 */
- (void)maskWithResizableImage:(UIImage *)image;
- (void)maskWithResizableImage:(UIImage *)image padding:(UIEdgeInsets)padding;
/**
 * 设置view.layer 的mask 属性
 * 这里的image需要是没有resing过的
 *
 *  @param image    orinal image
 *  @param capInset
 *  @param padding  
 */
- (void)maskWithImage:(UIImage *)image resizableImage:(UIEdgeInsets)capInset padding:(UIEdgeInsets)padding;


/**
 *  分层遍历树结构，看view树上是否存在view
 *
 *  @param view 要查找的view
 *
 *  @return 存在则返回YES
 */
- (BOOL)hasChild:(UIView *)view;

@end
