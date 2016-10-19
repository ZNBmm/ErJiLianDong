//
//  ZNBCollectionViewCell.h
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ZNBCellModel;
@interface ZNBCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) ZNBCellModel *model;
@end
