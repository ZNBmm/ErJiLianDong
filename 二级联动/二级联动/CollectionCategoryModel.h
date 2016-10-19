//
//  CollectionCategoryModel.h
//  二级联动
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *subcategories;

@end

@interface SubCategoryModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end