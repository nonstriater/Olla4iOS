//
//  OllaTableSection.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTableSection.h"

@implementation OllaTableSection


//xib中的顺序不能保证内存中的顺序，这里做一个排序
- (void)setCells:(NSArray *)cells{
    
    if (_cells != cells) {
        
        NSArray *c = [cells sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2){
            NSInteger tag1 = [(UIView *)obj1 tag];
            NSInteger tag2 = [(UIView *)obj2 tag];
            
            if (tag1<tag2) {
                return NSOrderedAscending;
            }
            if (tag1>tag2) {
                return NSOrderedDescending;
            }
            
            return NSOrderedSame;
        }];
        
        _cells = c;
        
    }
    
}



@end
