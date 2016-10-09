//
//  NSDate+ZCExtension.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "NSDate+ZCExtension.h"

@implementation NSDate (ZCExtension)


- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];

}


- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
    
}

- (BOOL)isToDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowComp = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
    
    NSDateComponents *selfComp = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
    
    return nowComp.year == selfComp.year && nowComp.month == selfComp.month && nowComp.day == selfComp.day;
}

- (BOOL)isYesterDay
{
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [fm dateFromString:[fm stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fm dateFromString:[fm stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return components.year == 0 && components.month ==0 && components.day == 1;
}

@end
