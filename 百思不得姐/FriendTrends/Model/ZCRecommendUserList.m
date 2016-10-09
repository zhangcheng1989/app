//
//  ZCRecommendUserList.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendUserList.h"
#import "YYModel.h"
#import "ZCRecommendUser.h"
@implementation ZCRecommendUserList


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":ZCRecommendUser.class};
}


@end
