//
//  OllaTableSection.h
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OllaTableSection : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) IBOutlet UIView *headerView;
@property(nonatomic,strong) IBOutlet UIView *footerView;
@property(nonatomic,strong) IBOutletCollection(UITableViewCell) NSArray *cells;

@end
