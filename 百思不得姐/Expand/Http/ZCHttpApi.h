//
//  ZCHttpApi.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^ApiCompletion)(NSURLSessionDataTask *task,NSDictionary *dict,NSError *error);

@interface ZCHttpApi : AFHTTPSessionManager


+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)postPath:(NSString *)url param:(NSDictionary *)param complection:(ApiCompletion)complection;


- (NSURLSessionDataTask *)getPath:(NSString *)url param:(NSDictionary *)param complection:(ApiCompletion)complection;


- (void)cancelManager;


- (void)cancelTask;

@end
