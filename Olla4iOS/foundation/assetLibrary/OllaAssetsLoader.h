//
//  OllaAssetsLoader.h
//  EverPhoto
//
//  Created by null on 15-5-19.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssetsLibrary/AssetsLibrary.h"

@interface OllaAssetsLoader : NSObject


- (id)initWithAssetsLibrary:(ALAssetsLibrary *)assetsLibrary;

- (void)fetchAssets:(void (^)(ALAssetsGroup *group, ALAsset *result, NSUInteger index,BOOL *stop))asset finishBlock:(void (^)(NSArray *assets))finishBlock failureBlock:(void (^)(NSError *error))failure;




@end
