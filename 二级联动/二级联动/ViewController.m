//
//  ViewController.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "ZNBTabCollectionView.h"
#import "CollectionCategoryModel.h"
#import "NSObject+Property.h"
#import "UIImageView+WebCache.h"

@interface ViewController () <ZNBTabCollectionViewDataSource,ZNBTabCollectionViewDelegate>
@property (weak, nonatomic) ZNBTabCollectionView *tcView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas
{
    if (!_collectionDatas)
    {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ZNBTabCollectionView *tcView = [[ZNBTabCollectionView alloc] initWithFrame:self.view.bounds];
    self.tcView = tcView;
    tcView.TCDataSource = self;
    tcView.TCDelegate = self;
    tcView.minimumInteritemSpacing = 1;
    tcView.minimumLineSpacing = 1;
    [self.view addSubview:tcView];
    [self loadData];
}

- (void)loadData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"liwushuo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *categories = dict[@"data"][@"categories"];
    
    for (NSDictionary *dict in categories)
    {
        CollectionCategoryModel *ccmodel =
        [CollectionCategoryModel objectWithDictionary:dict];
        [self.dataSource addObject:ccmodel];
        
        NSMutableArray *datas = [NSMutableArray array];
        for (SubCategoryModel *sModel in ccmodel.subcategories)
        {
            [datas addObject:sModel];
        }
        [self.collectionDatas addObject:datas];
    }
//    [self.tcView reloadData];
    
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.tcView selectTCTableViewRowAtDefaultIndexPath];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tcView selectTCTableViewRowAtDefaultIndexPath];
}
/** tcTableView 一组有多少行 */
- (NSInteger)tcTableView:(ZNBTabCollectionView *)tcTableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

/** tcTableView 标题 */
- (NSString *)tcTableView:(ZNBTabCollectionView *)tcTableView titleForRowAtIndexPath:(NSIndexPath *)indexPath {

    CollectionCategoryModel *model = self.dataSource[indexPath.row];
    
    return model.name;
}

/** tcCollectionView 组数 */
- (NSInteger)numberOfSectionsInTCCollectionView:(ZNBTabCollectionView *)tcCollectionView {
    
    return self.collectionDatas.count;
}

/** 返回tcCollectionView 一组里的Item个数 */
- (NSInteger)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView numberOfItemsInSection:(NSInteger)section {

    CollectionCategoryModel *model = self.dataSource[section];
    return model.subcategories.count;
}

/** 返回 tcCollectionView 的组标题 */
- (NSString *)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView titleForSectionAtIndexPath:(NSInteger)indexPath {
    
    CollectionCategoryModel *model = self.dataSource[indexPath];
    
    return model.name;
}

/** 返回tcCollectionView的模型 */
- (ZNBCellModel *)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView cellModelForItemAtIndexPath:(NSIndexPath *)indexPath {

    SubCategoryModel *subModel = self.collectionDatas[indexPath.section][indexPath.row];

    ZNBCellModel *model = [[ZNBCellModel alloc] init];
    model.name = subModel.name;
    model.imageName = subModel.icon_url;
    return model;
}

- (void)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%@",indexPath);
}

@end
