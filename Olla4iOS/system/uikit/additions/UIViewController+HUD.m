//
//  UIViewController+HUD.m
//  EverPhoto
//
//  Created by null on 15-5-11.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "Olla4iOS.h"

@implementation UIViewController (HUD)

- (void)showHUDWithText:(NSString *)text dismissAfter:(NSTimeInterval)seconds{
    [self showHUDWithText:text dismissAfter:seconds completeBlock:nil];
}


- (void)showHUDWithText:(NSString *)text dismissAfter:(NSTimeInterval)seconds completeBlock:(void (^)())block{

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(seconds);
    } completionBlock:^{
        [hud removeFromSuperview];
        block();
    }];
    
}

//进度，完成后执行block
- (void)showHUDWithProgress:(float)progress text:(NSString *)text finishedBlock:(void (^)())block{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeDeterminate;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        hud.progress = progress;
    }completionBlock:^{
        [hud removeFromSuperview];
        block();
    }];
}

- (void)showCustomHUDWithText:(NSString *)text image:(UIImage *)image dismissAfter:(NSTimeInterval)seconds{

    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    hud.customView = iv;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(seconds);
    }completionBlock:^{
        [hud removeFromSuperview];
    }];
    
}



@end
