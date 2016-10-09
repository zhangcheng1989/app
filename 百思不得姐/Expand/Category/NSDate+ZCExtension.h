//
//  NSDate+ZCExtension.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZCExtension)


- (NSDateComponents *)deltaFrom:(NSDate *)from;

- (BOOL)isThisYear;

- (BOOL)isToDay;

- (BOOL)isYesterDay;

@end
