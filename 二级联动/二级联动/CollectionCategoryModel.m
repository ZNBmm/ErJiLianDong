//
//  CollectionCategoryModel.m
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CollectionCategoryModel.h"


@implementation CollectionCategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"subcategories": @"SubCategoryModel"};
}

@end

@implementation SubCategoryModel

@end
