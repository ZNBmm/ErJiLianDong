//
//  ZNBCollectionViewCell.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZNBCollectionViewCell.h"
#import "ZNBCellModel.h"
#import "UIImageView+WebCache.h"

#define kCellIdentifier_CollectionView @"CollectionViewCell"

@interface ZNBCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *name;

@end

@implementation ZNBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width - 4, self.frame.size.width - 4)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageV];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(2, self.frame.size.width + 2, self.frame.size.width - 4, 20)];
        self.name.font = [UIFont systemFontOfSize:13];
        self.name.textAlignment = NSTextAlignmentCenter;
//        self.name.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.name];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setModel:(ZNBCellModel *)model {

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.imageName]];
    self.name.text = model.name;
}
@end
