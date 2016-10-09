//
//  ZCComment.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCUser;
@interface ZCComment : NSObject
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) ZCUser *user;
@property (nonatomic, strong) NSArray *hot;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, copy) NSURL *voiceurl;
@property (nonatomic, assign) NSInteger commentId;
@end
