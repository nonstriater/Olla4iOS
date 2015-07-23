//
//  OllaBannerCell.m
//  Olla4iOSDemo
//
//  Created by null on 15/7/23.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "OllaBannerCell.h"
#import "Olla4iOS.h"//for ddlogerror()

@implementation OllaBannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    self.imageView = imageView;
    
}

- (void)setData:(id)data{
    if ([data isKindOfClass:NSString.class]) {//url
        if ([data hasPrefix:@"http"]) {
            [self.imageView setRemoteImageURL:data];
        }
    }else if([data isKindOfClass:NSURL.class]){
        [self.imageView setRemoteImageURL:[(NSURL *)data absoluteString]];
    }else if([data isKindOfClass:UIImage.class]){
        [self.imageView setImage:data];
    }else{
        DDLogError(@"OllaBannerCell's data not a correct type:%@",data);
    }

}

@end
