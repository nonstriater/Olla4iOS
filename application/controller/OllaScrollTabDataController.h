//
//  OllaScrollTabDataController.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-1.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTabDataController.h"

// 使用scrollview，左右滑动的形式,需要重写setSelectedIndex：方法
// 不能用segmentcontrol，而是用button

@interface OllaScrollTabDataController:OllaTabDataController<UIScrollViewDelegate>

@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;

@end
