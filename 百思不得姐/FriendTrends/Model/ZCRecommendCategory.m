//
//  ZCRecommendCategory.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendCategory.h"
#import "YYModel.h"
@implementation ZCRecommendCategory

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"id":@"categoryId"};
}


- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}


@end
