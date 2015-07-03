//
//  ALAsset+additions.m
//  EverPhoto
//
//  Created by null on 15-5-19.
//  Copyright (c) 2015年 bytedance. All rights reserved.
//

#import "ALAsset+additions.h"
#import "NSData+AES.h"
#import "UIDevice+Hardware.h"

@implementation ALAsset (additions)

- (BOOL)isPhoto{
    
    return [[self valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto];
}

- (BOOL)isVideo{
    return [[self valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
}

//
- (BOOL)isEqual:(id)object{
    
    if (![object isKindOfClass:[ALAsset class]]) {
        return NO;
    }
    
    return [[self valueForProperty:ALAssetPropertyAssetURL] isEqualToString:[object valueForProperty:ALAssetPropertyAssetURL]];
}

- (NSString *)md5Encode{

    CGImageRef imageRef = [[self defaultRepresentation] fullResolutionImage];
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    return [data md5Encode];
    
}


- (BOOL)isScreenshot{
    
    CGSize sz = [self.defaultRepresentation dimensions];
    NSString *size = [NSString stringWithFormat:@"%.0fx%.0f",sz.width,sz.height];
    NSString *UTI = [self.defaultRepresentation UTI];
    if ([UTI isEqualToString:@"public.png"] && [[UIDevice screenSizes] containsObject:size]) {
        return YES;
    }
    
    return NO;
}


@end
