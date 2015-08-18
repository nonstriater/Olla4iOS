//
//  OllaLoadingMoreView.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-17.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaLoadingMoreView.h"
#import "UIView+additions.h"

@implementation OllaLoadingMoreView

@synthesize textLabel = _textLabel;
@synthesize indicatorView = _indicatorView;
@synthesize isLoading = _isLoading;
@synthesize hasMoreData = _hasMoreData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)startLoading{

    self.isLoading = YES;
    [self.indicatorView setHidden:NO];
    [self.indicatorView startAnimating];
}


- (void)stopLoading{
    self.isLoading = NO;
    [self.indicatorView stopAnimating];
}

- (void)setHasMoreData:(BOOL)hasMoreData{
    _hasMoreData = hasMoreData;
    if (!_hasMoreData) {// no more data
        [self.textLabel setText:@"无数据"];
        self.textLabel.center = self.center;
        [self.textLabel setHidden:NO];
        [self.indicatorView setHidden:YES];
    }else{
        
        [self.textLabel setHidden:YES];
        [self.indicatorView setHidden:NO];
        self.indicatorView.center =self.center;
    }
    
}

@end
