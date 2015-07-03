//
//  OllaCollectionViewCell.h
//  Olla
//
//  Created by null on 14-10-31.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OllaDataBindContainer.h"

IB_DESIGNABLE
@interface OllaCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) IBOutlet OllaDataBindContainer *dataBindContainer;
@property(nonatomic,strong) id dataItem;
@property(nonatomic,weak) IBOutlet id delegate;

- (IBAction)doAction:(id)sender;
- (IBAction)doAction:(id)sender event:(UIEvent *)event;


@end

@protocol OllaCollectionViewCellDelegate
@optional
- (void)collectionViewCell:(OllaCollectionViewCell *)cell doAction:(id)sender event:(UIEvent *)event;
@end


