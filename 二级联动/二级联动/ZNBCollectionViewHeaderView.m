//
//  ZNBCollectionViewHeaderView.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZNBCollectionViewHeaderView.h"

#define ZNBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define ZNBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation ZNBCollectionViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = ZNBColorAlpha(244, 244, 244, 0.8);
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH - 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}


@end
