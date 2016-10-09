//
//  ZCRecommendUserList.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendUserList : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger next_page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger total_page;
@property (nonatomic, strong) NSArray *list;

@end
