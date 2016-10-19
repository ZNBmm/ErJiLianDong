//
//  ZNBLeftTableViewCell.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZNBLeftTableViewCell.h"

#define ZNBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define ZNBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define defaultColor ZNBColorAlpha(253, 30, 30, 1)

CGFloat const indicatorViewH = 44;
CGFloat const indicatorViewW = 3;
CGFloat const indicatorViewX = 0;
CGFloat const indicatorViewY = 1;
@interface ZNBLeftTableViewCell ()
/** 指示器view */
@property (nonatomic, strong) UIView *indicatorView;

@end


@implementation ZNBLeftTableViewCell

- (void)awakeFromNib {

    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
    self.title.numberOfLines = 0;
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textColor = ZNBColorAlpha(130, 130, 130, 1);
    self.title.highlightedTextColor = defaultColor;
    [self.contentView addSubview:self.title];
    
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(indicatorViewX, indicatorViewY, indicatorViewW, indicatorViewH)];
    
    self.indicatorView.backgroundColor = defaultColor;
    [self.contentView addSubview:self.indicatorView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.indicatorView.frame = CGRectMake(0, 1, 2, self.bounds.size.height - 2);

    self.title.center = CGPointMake((self.frame.size.width - 2) * 0.5, self.frame.size.height * 0.5);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    NSLog(@"%d",selected);
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.title.highlighted = selected;
    self.indicatorView.hidden = !selected;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
