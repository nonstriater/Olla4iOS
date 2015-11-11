//
//  OllaBannerModelDelegate.h
//  Olla4iOSDemo
//
//  Created by null on 15/11/11.
//  Copyright © 2015年 nonstriater. All rights reserved.
//


@protocol OllaBannerModelDelegate <NSObject>
@property(nonatomic, copy) NSString *imageURL;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) id userInfo;
@end

