//
//  OllaCollectionPageController.m
//  Olla
//
//  Created by null on 14-10-31.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaCollectionPageController.h"

@implementation OllaCollectionPageController

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{//iOS8
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{

}


@end
