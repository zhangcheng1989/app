//
//  ZCRecommendTag.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendTag : NSObject
@property (nonatomic, copy) NSURL *image_list;
@property (nonatomic, assign) NSInteger is_default;
@property (nonatomic, assign) NSInteger is_sub;
@property (nonatomic, assign) NSInteger sub_number;
@property (nonatomic, assign) NSInteger theme_id;
@property (nonatomic, copy) NSString *theme_name;

@end
