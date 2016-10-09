//
//  ZCRecommendCategory.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendCategory : NSObject
@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *count;
@property(nonatomic, copy)NSString *name;

@property (nonatomic ,strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger currentPage;

@end
