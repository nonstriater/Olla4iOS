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

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.center = self.center;
        indicatorView.autoresizingMask = UIViewAutoresizingNone;
        self.indicatorView = indicatorView;
        [self addSubview:indicatorView];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        textLabel.center = self.center;
        indicatorView.autoresizingMask = UIViewAutoresizingNone;
        textLabel.textColor = [UIColor lightGrayColor];
        textLabel.font = [UIFont systemFontOfSize:13.f];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel = textLabel;
        [self addSubview:textLabel];
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
        [self.textLabel setText:NSLocalizedString(@"no more data", @"")];
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
