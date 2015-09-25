//
//  OllaTableDataController.m
//  OllaFramework
//
//  Created by nonstriater on 14-6-19.
//  Copyright (c) 2014年 xiaoran. All rights reserved.
//

#import "OllaTableDataController.h"
#import "OllaTableViewCell.h"
#import "OllaPageDataSource.h"
#import "Olla4iOS.h"

@interface OllaTableDataController (){
}
@end

@implementation OllaTableDataController

- (instancetype)init{
    if (self=[super init]) {
        self.refreshViewEnable = YES;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if (self.headerView) {
        self.tableView.tableHeaderView = self.headerView;
    }
    if (self.footerView) {
        self.tableView.tableFooterView = self.footerView;
    }
}

- (void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

#pragma mark - refreshing 

- (void)startLoading{
    [super startLoading];
    [self.topRefreshView beginRefreshing];
}

- (void)stopLoading{
    [super stopLoading];
    
    [self.topRefreshView endRefreshing];
    if (self.dataLoadingError) {
        if (self.dataNotFoundView && self.dataNotFoundView.superview==nil) {
            self.dataNotFoundView.frame = _tableView.bounds;
            [_tableView addSubview:self.dataNotFoundView];
            return;
        }
    }else{
        [self.dataNotFoundView removeFromSuperview];
    }
    
    if ([self.dataSource isEmpty]) {
        if (self.dataEmptyView && self.dataEmptyView.superview==nil) {
            self.dataEmptyView.frame = _tableView.bounds;
            [_tableView addSubview:self.dataEmptyView];
        }
    }else{
        [self.dataEmptyView removeFromSuperview];
    }
}


- (Class)refreshViewClass{
    return [OllaRefreshView class];
}

-(UIControl<IOllaRefreshView> *)topRefreshView{
    
    if (!self.refreshViewEnable) {
        return nil;
    }
    
    if (!_topRefreshView) {
        _topRefreshView = [[[self refreshViewClass] alloc] initInScrollView:self.tableView];
        [_topRefreshView addTarget:self action:@selector(tableViewRefreshTrigger:) forControlEvents:UIControlEventValueChanged];
    }
    return _topRefreshView;
}

// 空
- (void)tableViewRefreshTrigger:(UIControl<IOllaRefreshView> *)refreshView{
    NSLog(@"refresh trigger");
    [self refreshData];
}


- (void)setHeaderCells:(NSArray *)headerCells{
    if (_headerCells != headerCells) {
        _headerCells = [NSMutableArray arrayWithArray:headerCells];
    }
}


#pragma mark - tableview datasource / delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataSource numberOfSection];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSUInteger dataSourceCount = [self.dataSource numberOfCellsAtSection:section];
    if (section==0) {
        return [_headerCells count] + [_footerCells count] + dataSourceCount ;
    }
    return  dataSourceCount ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [self heightForRowAtIndexPath:indexPath];
    if (height>0.00001f) {
        return height;
    }
    
    if (indexPath.section==0 && indexPath.row<[_headerCells count]) {
        return [[_headerCells objectAtIndex:indexPath.row] frame].size.height;
    }
    
    if (indexPath.section==0 && indexPath.row>=([_headerCells count]+[self.dataSource numberOfCellsAtSection:0])) {
        return [[_footerCells objectAtIndex:indexPath.row] frame].size.height;
    }
    
    if (!tableView.autoHeight && !self.autoHeight) {//静态高度
        return tableView.rowHeight;
    }else{//动态高度
        NSString *reusableCellIdentifier = [self nibNameAtIndexPath:indexPath];
        if ([reusableCellIdentifier length]==0) {
            reusableCellIdentifier = self.itemViewNib;
        }
        height = [tableView fd_heightForCellWithIdentifier:reusableCellIdentifier cacheByIndexPath:indexPath configuration:^(OllaTableViewCell *cell){
            [self configCell:cell atIndexPath:indexPath];
        }];
        if (height<0.00001f) {
            height = tableView.rowHeight;
        }
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row<[_headerCells count]) {
        UITableViewCell *cell = [_headerCells objectAtIndex:indexPath.row];
        if ([cell isKindOfClass:OllaTableViewCell.class]) {
            [self configCell:(OllaTableViewCell *)cell atIndexPath:indexPath];
        }
        return cell;
    }
    
    if (indexPath.section==0 && indexPath.row>=([_headerCells count]+[self.dataSource numberOfCellsAtSection:0])) {
        UITableViewCell *cell = [_footerCells objectAtIndex:(indexPath.row-[_headerCells count]-self.dataSource.count)];
        if ([cell isKindOfClass:OllaTableViewCell.class]) {
            [self configCell:(OllaTableViewCell *)cell atIndexPath:indexPath];
        }
        return cell;
    }
    
    // xib和SB的区别
    /*
     1. 使用registerNib后，不需要if(!cell){}这样的判断
     2. storyboard/xib中，cell可以设置reuse identifier
     3. sb中没有必要再使用： initWithStyle：Nib：
     */
    
    NSString *nibName = [self nibNameAtIndexPath:indexPath];
    if(!nibName){
        nibName = self.itemViewNib;
    }
    if(!nibName){
        DDLogWarn(@"没有nib name");
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName];
    //只有xib能用，sb不能用
    if (!cell) {
        //意义在于可以在自定义的cell的initWithStyle:..nib..方法中初始化参数
        Class clazz = NSClassFromString(self.itemViewNib);
        if ( !clazz ) {
            clazz = [OllaTableViewCell class];
        }
        
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nibName nibName:nibName];
    }
    
    
    if ([cell isKindOfClass:[OllaTableViewCell class]]) {
        [(OllaTableViewCell *)cell setDelegate:self];// 代理cell上的button event
        
        [self configCell:(OllaTableViewCell *)cell atIndexPath:indexPath];
    }
    
    return cell;
}

// to be override
- (NSString *)nibNameAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.f;
}

// to be override
- (void)configCell:(OllaTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    id data = [self dataAtIndexPath:indexPath];
    [(OllaTableViewCell *)cell setDataItem:data];
}

// middle insert/ search table 就可以重写这个方法，这样写，主要是方便子类重写
- (id)dataAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return [self.dataSource dataObjectAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row-[_headerCells count]) inSection:0]];
    }
    
    return [self.dataSource dataObjectAtIndexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(tableDataController:didSelectRowAtIndexPath:)]) {
        [self.delegate tableDataController:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableViewCell:(OllaTableViewCell *)cell doAction:(id)sender event:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(tableDataController:cell:doAction: event:)]) {
        [self.delegate tableDataController:self cell:cell doAction:sender event:event];
    }
}


// index  /////////////////////////////////////////////////
-(NSArray *)sectionIndexTitlesForTableView{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}


// cell edit ///////////////////////////////////////////////////////
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row<[self.headerCells count] || indexPath.row == [self.headerCells count]+[self.dataSource count]) {
        return NO;
    }
    
    return _canCellDelete;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _canCellDelete?UITableViewCellEditingStyleDelete:UITableViewCellEditingStyleNone;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"删除", @"");
}


#pragma datasource delegate

- (void)dataSourceDidLoaded:(OllaDataSource *)dataSource{
    [super dataSourceDidLoaded:dataSource];
    [_tableView reloadData];
}


-(void)dataSourceDidLoadedFromCache:(OllaDataSource *)dataSource timestamp:(NSDate *)timestamp{
    [super dataSourceDidLoadedFromCache:dataSource timestamp:timestamp];
    [_tableView reloadData];
    
}

@end
