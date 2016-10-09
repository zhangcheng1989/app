//
//  ZCHttpApi.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHttpApi.h"


@implementation ZCHttpApi


static ZCHttpApi *_http = nil;

+ (instancetype)sharedManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _http = [[ZCHttpApi alloc]init];
        
        _http.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _http.requestSerializer = [AFJSONRequestSerializer serializer];
        _http.responseSerializer = [AFJSONResponseSerializer serializer];
        _http.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", nil];
    });
    return _http;
    
   
}


- (NSURLSessionDataTask *)postPath:(NSString *)url param:(NSDictionary *)param complection:(ApiCompletion)complection{
    NSURLSessionDataTask *task = [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complection) {
            if (responseObject) {
                complection(task,responseObject,nil);
            }else{
                NSError *error = [[NSError alloc] initWithDomain:@"" code:-1 userInfo:responseObject];
                complection(task,nil,error);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complection) {
            complection(task,nil,error);
        }
    }];
    
    return task;
}

- (NSURLSessionDataTask *)getPath:(NSString *)url param:(NSDictionary *)param complection:(ApiCompletion)complection{
    NSURLSessionDataTask *task = [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complection) {
            complection(task,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complection) {
            complection(task,nil,error);
        }
    }];
    
    return task;
}

- (void)cancelManager
{
//    [self.operationQueue cancelAllOperations];
    
//    self.ope
}

- (void)cancelTask
{
//    [self.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

@end
