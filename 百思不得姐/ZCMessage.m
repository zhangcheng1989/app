//
//  ZCMessage.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMessage.h"

@implementation ZCMessage


+ (instancetype)messageWithDict:(NSDictionary *)dict{
    ZCMessage *message = [[self alloc]init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}

@end
