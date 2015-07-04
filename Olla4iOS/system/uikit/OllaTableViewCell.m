//
//  OllaTableViewCell.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTableViewCell.h"
#import "UIImageView+CacheURL.h"

@implementation OllaTableViewCell

// //////////////////////////////////////////////////////////////////////////////////////////
// 使用storyboard 的dynamic cell后，dequeueReusableCellWithIdentifier: 不论如何都会返回非nil，且子类化UITableViewCell的initWithStyle方法也不会调用
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier nibName:nil];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier nibName:(NSString *)nibName{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (![nibName length]) {
            return self;
        }
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:@{}];
        for (id object in nibObjects) {
            if ([object isKindOfClass:[self class]]){
                //[self.contentView addSubview:object];
                self = object;
                break;
                
            }
        }
        
    }
    return self;
}

- (void)setDataItem:(id)dataItem{

    if (_dataItem != dataItem) {
        _dataItem = dataItem;
        
        [_dataBindContainer applyDataBinding:self];
        
        // 如果cell上又网络图片控件，还要发起网络请求；也可以这样：为UIImageView新增的src添加一个KVO,这样代码更简洁
    }
}


- (IBAction)doAction:(id)sender{
    
    [self doAction:sender event:nil];
}


- (IBAction)doAction:(id)sender event:(UIEvent *)event{
    
    if ([_delegate respondsToSelector:@selector(tableViewCell:doAction: event:)]) {
        [_delegate tableViewCell:self doAction:sender event:event];
    }
}

- (void)cancelHTTPRequestIfNeeded{
    for (UIView *subView in [self.contentView subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)subView cancelCurrentImageLoading];
        }
    }

}



@end
