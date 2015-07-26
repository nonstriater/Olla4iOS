//
//  OllaSearchTableController.m
//  OllaFramework
//
//  Created by nonstriater on 14-7-2.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaSearchTableController.h"
#import "OllaTableViewCell.h"
#import "Olla4iOS.h"

@implementation OllaSearchTableController

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.sectionIndexHidden = YES;
    
    return self;
}

-(void)dealloc{
    self.searchDisplayController.delegate = nil;
    self.searchDisplayController.searchResultsDelegate=nil;
    self.searchDisplayController.searchResultsDataSource=nil;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.groupData = [NSMutableArray array];
    if (IS_IOS7) {
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    self.tableView.tableHeaderView = _searchBar;
    //bug fix(become black when select)
    [self.searchBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    if (_searchBarHidden) {
        [self hiddenSearchBarAnimated:NO];
    }
}


- (void)sortAndGroupDataWithKeyPath:(NSString *)keyPath{
    
    [self sortWithDataKeyPath:keyPath];
    [self setupSectionTitlesWithDataKeyPath:keyPath];
    
}

// 对数据排序
- (void)sortWithDataKeyPath:(NSString *)keyPath{
    
    NSArray *sortArray = [[self.dataSource dataObjects] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        
        NSString *value1 = [obj1 valueForKeyPath:keyPath];
        NSString *value2 = [obj2 valueForKeyPath:keyPath];
        if (([value1 isString]&&[value1 length]) && ([value2 isString]&&[value2 length])) {
            // A~Z以外的一律丢到最后(包括 数字开头，汉字，蝌蚪文)
            const char *v1 = [[[value1 firstLetter] lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
            const char *v2 = [[[value2 firstLetter] lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
            if ( (*v1 >= 'a' && *v1 <= 'z') && (*v2 < 'a' || *v2 > 'z') ) {
                return NSOrderedAscending;
            }
            if ( (*v1 < 'a' || *v1 > 'z') && (*v2 >= 'a' && *v2 <= 'z')) {
                return NSOrderedDescending;
            }
            
            NSComparisonResult result = [[value1 lowercaseString] compare:[value2 lowercaseString]];// 不区分大小写
            return NSOrderedDescending == result;//升序
        }
        return NSOrderedSame;//
    }];
    
    [self.dataSource setDataObjects:[NSMutableArray arrayWithArray:sortArray]];
}

// 数组分组, dataObjects 分组
- (void)setupSectionTitlesWithDataKeyPath:(NSString *)keyPath{
    
    NSMutableArray *sectionTitles = [NSMutableArray array];
    __block NSString *lastLetter = nil;
    __block NSMutableArray *oneGroup = nil;
    if ([self.groupData count]) {//要清掉老数据
        [self.groupData removeAllObjects];
    }
    [[self.dataSource dataObjects] enumerateObjectsUsingBlock:^(id obj,NSUInteger index,BOOL *stop){
        
        NSString *value = [obj valueForKeyPath:keyPath];
        if ([value isString] && [value length]) {
            NSString *firstLetter = [[value firstLetter] uppercaseString];
            const char *f = [firstLetter cStringUsingEncoding:NSUTF8StringEncoding];
            if (*f<='Z' && *f>='A') {
                
                if (![firstLetter isEqualToString:lastLetter]) {
                    oneGroup = [NSMutableArray array];
                    [self.groupData addObject:[NSDictionary dictionaryWithObject:oneGroup forKey:firstLetter]];
                    lastLetter = firstLetter;
                    [sectionTitles addObject:firstLetter];
                }
                
            }else{// 非字母
                
                const char *l = [lastLetter cStringUsingEncoding:NSUTF8StringEncoding];
                
                if ((l==NULL) ||  (*l<='Z' && *l>='A')) {
                    oneGroup = [NSMutableArray array];
                    [self.groupData addObject:[NSDictionary dictionaryWithObject:oneGroup forKey:@"#"]];
                    lastLetter = firstLetter;
                    [sectionTitles addObject:@"#"];
                }
            }
            
            [oneGroup addObject:obj];
        }
    }];

    //self.sectionIndexTitles = sectionTitles;
    self.sectionHeaderTitles = sectionTitles;
    
}


// sectionIndex ///////////////////////////////////////////////////////////////
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sectionIndexHidden?nil:_sectionIndexTitles;
}

// section header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionHeaderTitles objectAtIndex:section];
}

// search display controller////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return 1;
    }
    if (!_sectionIndexHidden) {
        return [self.groupData count];
    }
    
    
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return [_searchResultObjects count];
    }
    if (!_sectionIndexHidden) {// 显示section index titles
        NSArray *items = [[self.groupData objectAtIndex:section] allValues][0];
        if ([items isArray]) {
            return [items count];
        }
        
        return 0;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return tableView.rowHeight;
    }
    //默认跟底部的tableview高度一致
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _searchDisplayController.searchResultsTableView) {
        
        NSString *reuseIdentifier = _resultCellReuseIdentifier;
        if (!reuseIdentifier) {
            reuseIdentifier = _searchCellNib;
        }
        if (!reuseIdentifier) {
            reuseIdentifier = @"resultCell";
        }
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[OllaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier nibName:_searchCellNib];
        }
        
        if (indexPath.row<[self.searchResultObjects count]) {
            id data =  self.searchResultObjects[indexPath.row];
            if ([cell isKindOfClass:[OllaTableViewCell class]]) {
                [(OllaTableViewCell *)cell setDataItem:data];
            }
            
        }
        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

// 重写
- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.sectionIndexHidden) {
        NSArray *items = [[self.groupData objectAtIndex:indexPath.section] allValues][0];
        if ([items isArray]) {
            return [items objectAtIndex:indexPath.row];
        }
        return nil;
    }
    
    return [super dataAtIndexPath:indexPath];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.delegate respondsToSelector:@selector(tableDataController:tableView:didSelectAtIndexPath:)]){
        
        [self.delegate tableDataController:self tableView:tableView didSelectAtIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }else{
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _searchDisplayController.searchResultsTableView) {
        return NO;
    }
    return [super tableView:tableView canEditRowAtIndexPath:indexPath];
}

// UISearchDisplayDelegate ///////////////////////////////////////
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
    if (IS_IOS7) {
        tableView.frame = self.tableView.frame;
        tableView.tableFooterView = [UIView new];
    }
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

//UISearchDisplayControllerContainerView
- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
   
//    UIView *view = controller.searchContentsController.view;
//    UIView *searchContainerView = nil;
//    for (UIView *subView in view.subviews) {
//        if ([NSStringFromClass([subView class]) isEqualToString:@"UISearchDisplayControllerContainerView"]) {
//            searchContainerView = subView;
//            break;
//        }
//    }
//    if (searchContainerView && IS_IOS7) {
//        CGRect statusBarFrame =  [[UIApplication sharedApplication] statusBarFrame];
//        CGRect oldRect = searchContainerView.frame;
//        CGRect newRect = CGRectMake(oldRect.origin.x,statusBarFrame.size.height,oldRect.size.width , oldRect.size.height-statusBarFrame.size.height);
//        searchContainerView.frame = newRect;
//    }
    
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
}

// 在搜索范围改变时调用
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    return NO;
}

//在搜索内容改变时调用
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    return YES;
}

// UISearchBarDelegate ///////////////////////////////////////////////////////////////

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}


- (void)hiddenSearchBarAnimated:(BOOL)animated{
    
    // 会触发scroll delegage的 scrollDidScroll（会触发loadMoreData，引发bug）
    [self.tableView setContentOffset:CGPointMake(0, CGRectGetHeight(_searchBar.bounds)) animated:animated];
    
}



@end
