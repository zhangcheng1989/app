//
//  ZCTopWindow.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/16.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopWindow.h"

@implementation ZCTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}


+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollerViewInView:window];
}

+ (void)searchScrollerViewInView:(UIView *)superView
{
    for (UIScrollView *subView in superView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]] && subView.isShowingOnWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y  = subView.contentInset.top;
            [subView setContentOffset:CGPointZero animated:YES];
        }
    }
    
    [self searchScrollerViewInView:superView];
}

@end
