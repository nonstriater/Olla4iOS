//
//  OllaCollectionDataController.m
//  Olla
//
//  Created by null on 14-10-30.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionDataController.h"
#import "Olla4iOS.h"

@implementation OllaCollectionDataController

#pragma mark - collectionview datasource

-(void)viewLoaded{

    [super viewLoaded];
    if ([self.itemViewNib length]) {
        [self.collectionView registerNib:[UINib nibWithNibName:self.itemViewNib bundle:nil] forCellWithReuseIdentifier:self.itemViewNib];
    }else{
        DDLogWarn(@"使用xib布局时，itemViewNib空会崩溃");
    }
    
    // 页眉
    if ([self.headerViewNib length]){
        [self.collectionView registerNib:[UINib nibWithNibName:self.headerViewNib bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.headerViewNib];
    }
    
    // 页脚
    if ([self.footerViewNib length]) {
        [self.collectionView registerNib:[UINib nibWithNibName:self.footerViewNib bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.footerViewNib];
    }
    
    //配置collection的layout为nil时会导致崩溃:reason: 'UICollectionView must be initialized with a non-nil layout parameter'
    self.collectionView.collectionViewLayout = self.collectionViewLayout?:[[UICollectionViewFlowLayout alloc] init];
}

// collectionview  datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.dataSource numberOfSection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource numberOfCellsAtSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier= nil;
    if (reuseIdentifier==nil) {
        reuseIdentifier = self.itemViewNib;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    
    if ([cell isKindOfClass:[OllaCollectionViewCell class]]) {
        [(OllaCollectionViewCell *)cell setDelegate:self];
        id data = [self dataAtIndexPath:indexPath];
        [(OllaCollectionViewCell *)cell setDataItem:data];
    }

    return cell;
}


// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseIdentifier = self.headerReuseIdentifier;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reuseIdentifier = self.footerReuseIdentifier;
    }
    
    UICollectionReusableView *reusableView = nil;
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return reusableView;
}


#pragma mark - collectionview delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(collectionController:didSelectAtIndexPath:)]) {
        [self.delegate collectionController:self didSelectAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

// cell上按钮点击
- (void)collectionViewCell:(OllaCollectionViewCell *)cell doAction:(id)sender event:(UIEvent *)event{

    if([self.delegate respondsToSelector:@selector(collectionController:cell:doAction:event:)]){
        [self.delegate collectionController:self cell:cell doAction:sender event:event];
    }
}


#pragma mark - collectionview layout


#pragma datasource delegate

- (void)dataSourceDidLoaded:(OllaDataSource *)dataSource{
    [super dataSourceDidLoaded:dataSource];
    [_collectionView reloadData];
}



@end

