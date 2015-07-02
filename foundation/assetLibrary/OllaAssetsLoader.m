//
//  OllaAssetsLoader.m
//  EverPhoto
//
//  Created by null on 15-5-19.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "OllaAssetsLoader.h"
#import "ALAsset+additions.h"
#import "Olla4iOS.h"

@interface OllaAssetsLoader ()

@property(nonatomic,strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation OllaAssetsLoader

- (instancetype)init{

    ALAssetsLibrary *__assetsLibrary = [[ALAssetsLibrary alloc] init];
    return [self initWithAssetsLibrary:__assetsLibrary];
}

- (id)initWithAssetsLibrary:(ALAssetsLibrary *)assetsLibrary{
    if (self=[super init]) {
        _assetsLibrary = assetsLibrary;
    }
    return self;
}

- (void)fetchAssets:(void (^)(ALAssetsGroup *group, ALAsset *result, NSUInteger index,BOOL *stop))assetBlock finishBlock:(void (^)(NSArray *assets))finishBlock failureBlock:(void (^)(NSError *error))failure{
    
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *assetGroups = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        //groups process
        void (^ assetGroupEnumerator)(ALAssetsGroup *group, BOOL *stop) = ^(ALAssetsGroup *group, BOOL *stop){

            if (group) {
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop){
                
                    if (result && [result isPhoto]) {
                        
                        [assets addObject:result];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            assetBlock(group,result,index,stop);
                        });
                    }
   
                }];
                [assetGroups addObject:group];
            }
        };
        
        // start ALAssetsGroupSavedPhotos
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop){
            
            assetGroupEnumerator(group,stop);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(assets);
            });
        
            
        } failureBlock:^(NSError *error) {
            if (error) {
                DDLogError(@"遍历系统相册失败：%@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(error);
                });
            }
        }];
        
        
    });
}


@end
