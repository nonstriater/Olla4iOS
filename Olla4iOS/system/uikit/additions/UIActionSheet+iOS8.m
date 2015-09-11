//
//  UIActionSheet+Blocks.m
//  CBoBo
//
//  Created by null on 15/9/10.
//  Copyright (c) 2015年 bobo. All rights reserved.
//

#import "UIActionSheet+iOS8.h"

@implementation UIActionSheet (iOS8)

+ (void)showWithTitle:(NSString *)title
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
             tapBlock:(UIActionSheetCompletionBlock)tapBlock{

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [actionSheet dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    for(NSUInteger index=0;index<otherButtonTitles.count;index++){
        NSString *title = otherButtonTitles[index];
        [actionSheet addAction:[UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(tapBlock){
                tapBlock(actionSheet,index);
            }
            [actionSheet dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
    }
    
    UIViewController *presentingVC = [self topMostController];
    [presentingVC presentViewController:actionSheet animated:YES completion:nil];
    
}

+ (UIViewController*) topMostController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow)
    {
        keyWindow = [[[UIApplication sharedApplication] delegate] window];
    }
    UIViewController *topController = keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
