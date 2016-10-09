//
//  ZCRecommendList.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendList.h"
#import "YYModel.h"
#import "ZCRecommendCategory.h"
@implementation ZCRecommendList


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":ZCRecommendCategory.class};
}

@end
