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
    self.clipsToBounds = YES;//imageView被撑大
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.backgroundColor = RGB_HEX(0xDFDFDF);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    self.imageView = imageView;
}

- (void)setData:(id<OllaBannerModelDelegate>)data{
    
    if (![data conformsToProtocol:@protocol(OllaBannerModelDelegate)]) {
        return;
    }
    
    NSString *imageURL = data.imageURL;
    NSString *title = data.title;
    
    if ([imageURL isKindOfClass:NSString.class]) {//url
        if ([imageURL hasPrefix:@"http"]) {
            [self.imageView setRemoteImageURL:imageURL];
        }
    }else if([imageURL isKindOfClass:NSURL.class]){
        [self.imageView setRemoteImageURL:[(NSURL *)imageURL absoluteString]];
    }else{
        DDLogError(@"OllaBannerCell's data not a correct type:%@",imageURL);
    }

}

@end
