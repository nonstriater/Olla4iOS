//
//  OllaCollectionViewCell.m
//  Olla
//
//  Created by null on 14-10-31.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionViewCell.h"

@implementation OllaCollectionViewCell


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

    if([_delegate respondsToSelector:@selector(collectionViewCell:doAction:event:)]){
        [_delegate collectionViewCell:self doAction:sender event:event];
    }
}



@end
