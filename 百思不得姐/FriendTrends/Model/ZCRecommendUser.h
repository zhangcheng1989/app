//
//  ZCRecommendUser.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendUser : NSObject
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSURL *header;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, assign) NSInteger is_follow;
@property (nonatomic, assign) NSInteger is_vip;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger tiezi_count;
@property (nonatomic, assign) NSInteger uid;

@end
