//
//  ZCPushGuideView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/29.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPushGuideView.h"

@implementation ZCPushGuideView

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZCPushGuideView" owner:nil options:nil]lastObject];
}


+ (void)show
{
    
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        ZCPushGuideView *guideView = [ZCPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        [[NSUserDefaults standardUserDefaults]setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (IBAction)removeClose {
    
    [self removeFromSuperview];
}


@end
