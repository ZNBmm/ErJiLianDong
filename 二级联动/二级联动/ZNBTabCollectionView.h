//
//  ZNBTabCollectionView.h
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNBCellModel.h"

@class ZNBTabCollectionView;

@protocol ZNBTabCollectionViewDataSource <NSObject>

@required
/** tcTableView 一组有多少行 */
- (NSInteger)tcTableView:(ZNBTabCollectionView *)tcTableView numberOfRowsInSection:(NSInteger)section;

/** tcTableView 标题 */
- (NSString *)tcTableView:(ZNBTabCollectionView *)tcTableView titleForRowAtIndexPath:(NSIndexPath *)indexPath;

/** tcCollectionView 组数 */
- (NSInteger)numberOfSectionsInTCCollectionView:(ZNBTabCollectionView *)tcCollectionView;

/** 返回tcCollectionView 一组里的Item个数 */
- (NSInteger)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView numberOfItemsInSection:(NSInteger)section;

/** 返回 tcCollectionView 的组标题 */
- (NSString *)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView titleForSectionAtIndexPath:(NSInteger)indexPath;

/** 返回tcCollectionView的模型 */
- (ZNBCellModel *)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView cellModelForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZNBTabCollectionViewDelegate <NSObject>

@optional
- (CGFloat)tcTableViewHeightForRow;
/** 设置Item的size */

- (CGSize)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** 选中 tcCollectionView */
- (void)tcCollectionView:(ZNBTabCollectionView *)tcCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGRect)frameForTCCollectionView;

@end
@interface ZNBTabCollectionView : UIView
/** 列间距 */
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;
/** 行间距 */
@property (assign, nonatomic) CGFloat minimumLineSpacing;

@property (weak, nonatomic) id <ZNBTabCollectionViewDataSource> TCDataSource;

@property (weak, nonatomic) id <ZNBTabCollectionViewDelegate> TCDelegate;

/** 刷新 ZNBTabCollectionView 的方法 */
- (void)reloadData;

/** 
 *  默认选中第一行,在viewWillAppear中调用 或者 viewDidAppear,不然不能默认选中第一行
 */
- (void)selectTCTableViewRowAtDefaultIndexPath;
@end
