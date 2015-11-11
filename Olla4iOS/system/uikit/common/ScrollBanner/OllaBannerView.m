//
//  OllaBannerView.m
//  Olla4iOSDemo
//
//  Created by null on 15/7/23.
//  Copyright (c) 2015年 nonstriater. All rights reserved.
//

#import "OllaBannerView.h"
#import "OllaBannerCell.h"

@interface OllaBannerView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,copy) OllaItemSelectBlock selectedBlock;

@end

@implementation OllaBannerView;

#pragma mark - UI
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.collectionView registerClass:[OllaBannerCell class] forCellWithReuseIdentifier:NSStringFromClass([OllaBannerCell class])];
    [self addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20.f, self.bounds.size.width, 20.f)];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pageControl];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark - public api
- (void)itemSelectedThen:(OllaItemSelectBlock)block{
    self.selectedBlock = block;
}

- (void)setItems:(NSArray *)items{
    if (_items != items) {
        _items = items;
        [self reloadData];
    }
}

- (void)reloadData{
    [self.collectionView reloadData];
}


#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.items.count;
    
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.bounds.size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OllaBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OllaBannerCell class]) forIndexPath:indexPath];
    id data = self.items[indexPath.item];
    if ([data conformsToProtocol:@protocol(OllaBannerModelDelegate)]) {
        cell.data = data;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlock) {
        self.selectedBlock(self,indexPath.row);
    }
}

@end
