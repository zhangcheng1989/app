//
//  NSObject+ZCExtension.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "NSObject+ZCExtension.h"

@implementation NSObject (ZCExtension)

//
//- (id)performSelector:(SEL)selector withObject:(NSArray *)objects
//{
//    
//    //方法签名
//    NSMethodSignature *signature = [[self class]instanceMethodSignatureForSelector:selector];
//    if (signature == nil) {
//        @throw  [NSException exceptionWithName:@"牛逼的错误" reason:@"方法找不到" userInfo:nil];
//    }
//    
//    
//    //NSInvocation 利用一个NSInvocation对象包装一次方法调用（方法调用者，方法签名，方法参数，方法返回值）
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = self;
//    invocation.selector = selector;
//    
//    //设置参数
//    NSInteger paramsCount = signature.numberOfArguments - 2;
//    paramsCount = MIN(paramsCount, objects.count);
//    for (NSInteger i = 0 ; i<paramsCount; i++) {
//        id object = objects[i];
//        if ([object isKindOfClass:[NSNull class]]) continue;
//        [invocation setArgument:&object atIndex:i+2];
//    }
//    
//    //调用方法
//    [invocation invoke];
//    
//    //获取返回值
//    id returnValue = nil;
//    if (signature.methodReturnLength) { //有返回值调用
//        [invocation getReturnValue:&returnValue];
//    }
//    
//    return returnValue;
//}

@end
