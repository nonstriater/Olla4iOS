//
//  OllaTableView.m
//  Olla
//
//  Created by null on 15-1-23.
//  Copyright (c) 2015年 xiaoran. All rights reserved.
//

#import "OllaTableView.h"
#import "UIView+additions.h"

@implementation OllaTableView

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    UIImage *image = [UIImage imageNamed:backgroundImageName];
    if (!image) {
        return;
    }
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    self.backgroundView = iv;
}

- (void)setBlurRadius:(CGFloat)blurRadius{
    
    if (!self.backgroundView || ![self.backgroundView isKindOfClass:UIImageView.class]) {
        return;
    }
    
    [self.backgroundView blurWithRadius:blurRadius];
}

@end
