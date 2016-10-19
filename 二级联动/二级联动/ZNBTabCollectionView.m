//
//  ZNBTabCollectionView.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZNBTabCollectionView.h"
#import "ZNBCollectionViewCell.h"
#import "ZNBLeftTableViewCell.h"
#import "ZNBCollectionViewFlowLayout.h"
#import "ZNBCollectionViewHeaderView.h"

#define kCellIdentifier_CollectionView @"CollectionViewCell"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define ZNBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define ZNBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]

static const CGFloat margin = 2;
@interface ZNBTabCollectionView ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZNBCollectionViewFlowLayout *flowlayout;

@end

@implementation ZNBTabCollectionView
{
    NSInteger _selectIndex;
    BOOL _isScrollUP;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    _selectIndex = 0;
    _isScrollUP = YES;
    self.backgroundColor = ZNBColorAlpha(244, 244, 244, 0.8);
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
    [self layoutIfNeeded];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)selectTCTableViewRowAtDefaultIndexPath {
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark - 外界调用
- (void)reloadData {
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

#pragma mark - 懒加载方法

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = [self tcTabViewHeight];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[ZNBLeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _tableView;
}

- (CGFloat) tcTabViewHeight {

    if ([self.TCDelegate respondsToSelector:@selector(tcTableViewHeightForRow)]) {
       return [self.TCDelegate tcTableViewHeightForRow];
    }
    return 44;
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    _minimumInteritemSpacing = minimumInteritemSpacing;
    _flowlayout.minimumInteritemSpacing = minimumInteritemSpacing;
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {

    _minimumLineSpacing = minimumLineSpacing;
    _flowlayout.minimumLineSpacing = minimumLineSpacing;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        ZNBCollectionViewFlowLayout *flowlayout = [[ZNBCollectionViewFlowLayout alloc] init];
        self.flowlayout = flowlayout;
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = margin;
        //上下间距
        flowlayout.minimumLineSpacing = margin;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:[self tcCollectionViewFrame] collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[ZNBCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        //注册分区头标题
        [_collectionView registerClass:[ZNBCollectionViewHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"CollectionViewHeaderView"];
    }
    return _collectionView;
}

- (CGRect)tcCollectionViewFrame {

    if ([self.TCDelegate respondsToSelector:@selector(frameForTCCollectionView)]) {
        return [self.TCDelegate frameForTCCollectionView];
    }
    return CGRectMake(2 + 80, 2 + 64, SCREEN_WIDTH - 80 - 4, SCREEN_HEIGHT - 64 - 4);
}

#pragma mark - UITableView DataSource Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

   return [self tcTabViewHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.TCDataSource respondsToSelector:@selector(tcTableView:numberOfRowsInSection:)]) {
        return [self.TCDataSource tcTableView:self numberOfRowsInSection:section];
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZNBLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    
    if ([self.TCDataSource respondsToSelector:@selector(tcTableView:titleForRowAtIndexPath:)]) {
        NSString *title = [self.TCDataSource tcTableView:self titleForRowAtIndexPath:indexPath];
        cell.title.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.TCDataSource respondsToSelector:@selector(numberOfSectionsInTCCollectionView:)]) {
       return [self.TCDataSource numberOfSectionsInTCCollectionView:self];
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.TCDataSource respondsToSelector:@selector(tcCollectionView:numberOfItemsInSection:)]) {
        return [self.TCDataSource tcCollectionView:self numberOfItemsInSection:section];
    }
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZNBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];

    if ([self.TCDataSource respondsToSelector:@selector(tcCollectionView:cellModelForItemAtIndexPath:)]) {
       ZNBCellModel *model = [self.TCDataSource tcCollectionView:self cellModelForItemAtIndexPath:indexPath];
        cell.model = model;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.TCDelegate respondsToSelector:@selector(tcCollectionView:didSelectItemAtIndexPath:)]) {
        [self.TCDelegate tcCollectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.TCDelegate respondsToSelector:@selector(tcCollectionView:sizeForItemAtIndexPath:)]) {
        return [self.TCDelegate tcCollectionView:self sizeForItemAtIndexPath:indexPath];
    }else {
        return CGSizeMake((SCREEN_WIDTH - 80 - 4 - 4) / 3,
                          (SCREEN_WIDTH - 80 - 4 - 4) / 3 + 30);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    { // header
        reuseIdentifier = @"CollectionViewHeaderView";
    }
    ZNBCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if ([self.TCDataSource respondsToSelector:@selector(tcCollectionView:titleForSectionAtIndexPath:)]) {
            NSString *title = [self.TCDataSource tcCollectionView:self titleForSectionAtIndexPath:indexPath.section];
            view.title.text = title;
        }
    }
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 30);
}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollUP && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollUP && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if (self.collectionView == scrollView)
    {
        _isScrollUP = lastOffsetY < scrollView.contentOffset.y;
//        NSLog(@"%d",_isScrollUP);
        lastOffsetY = scrollView.contentOffset.y;
    }
}

@end
