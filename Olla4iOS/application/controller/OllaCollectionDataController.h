//
//  OllaCollectionDataController.h
//  Olla
//
//  Created by null on 14-10-30.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionController.h"
#import "OllaCollectionViewCell.h"
#import "IOllaAction.h"

//完成collectionview controller的基本设置，包括 datasource/delegate
@interface OllaCollectionDataController : OllaCollectionController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,OllaCollectionViewCellDelegate,OllaDataSourceDelegate>

@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) IBOutlet UICollectionViewLayout *collectionViewLayout;


@property(nonatomic,strong) NSString *headerViewNib;
@property(nonatomic,copy) NSString *headerReuseIdentifier;//storyboard

@property(nonatomic,strong) NSString *footerViewNib;
@property(nonatomic,copy) NSString *footerReuseIdentifier;//storyboard


@end



@protocol OllaCollectionDataController
@optional

// cell上button事件处理
- (void)collectionController:(OllaController *)controller cell:(OllaCollectionViewCell *)cell doAction:(id<IOllaAction>)action event:(UIEvent *)event;
// cell 选中事件处理
- (void)collectionController:(OllaController *)controller didSelectAtIndexPath:(NSIndexPath *)indexPath;


@end




