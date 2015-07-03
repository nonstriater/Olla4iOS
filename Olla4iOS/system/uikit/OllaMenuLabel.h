//
//  OllaMenuLabel.h
//  OllaMenuLableDemo
//
//  Created by nonstriater on 14-7-11.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,OllaPopupMenuType){
    
    OllaPopupMenuCopy = 0,
    OllaPopupMenuTranslation,
    OllaPopupMenuStoreUp,
    OllaPopupMenuTransmit,
    OllaPopupMenuMore
    
    
};


@interface OllaMenuLabel : UILabel

@property(nonatomic,assign) BOOL enablePopupMenu;
@property(nonatomic,strong)  UILongPressGestureRecognizer  *longPressGesture;

@end
