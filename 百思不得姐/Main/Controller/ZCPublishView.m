//
//  ZCPublishView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/7.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPublishView.h"
#import "ZCVerticalButton.h"
#import "POP.h"
#import "ZCPostWordViewController.h"
#import "ZCNavigationController.h"
#import "ZCCCustomViewController.h"
#import "ZCWaterViewController.h"
#import "ZCMessageViewController.h"
#import "ZCMoveViewController.h"
#import "ZCHittestAndPointViewController.h"
#import "ZCDrawerViewController.h"
#import "ZCNavViewController.h"
#import "ZCScrollerVCViewController.h"
#import "ZCScrollerVLayoutViewController.h"
#import "ZCNSOperationViewController.h"
#import "ZCDownImageViewController.h"
#import "ZCNSRunLoopViewController.h"
#import "ZCGCDTimerViewController.h"
@interface ZCPublishView ()
@end

@implementation ZCPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


static UIWindow *window_;

 + (void)show
{
    window_ = [[UIWindow alloc]init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.hidden = NO;
    window_.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    ZCPublishView *publishView = [ZCPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"视频",@"图片",@"段子",@"声音",@"审帖",@"离线下载"];
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = ([UIScreen mainScreen].bounds.size.height - 2 * buttonH)* 0.5;
    int maxCols = 3;
    CGFloat buttonStartX = 15;
    CGFloat xMargin = ([UIScreen mainScreen].bounds.size.width - 2 *buttonStartX - maxCols *buttonW)/(maxCols - 1);
    for (NSInteger i =0; i<images.count; i++) {
        ZCVerticalButton *vericalButton = [[ZCVerticalButton alloc]init];
        vericalButton.tag = i;
        [self addSubview:vericalButton];
        [vericalButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        vericalButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [vericalButton setTitle:titles[i] forState:UIControlStateNormal];
        [vericalButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [vericalButton setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY  - [UIScreen mainScreen].bounds.size.height;
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + 0.15 *i;
        [vericalButton pop_addAnimation:anim forKey:nil];
    }
    
    
    UIImageView *sloganImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganImage];
    
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width * 0.5;
    CGFloat centerEndY = [UIScreen mainScreen].bounds.size.height * 0.2;
    CGFloat centerBeginY = centerEndY - [UIScreen mainScreen].bounds.size.height;
    sloganImage.centerY = centerBeginY;
    sloganImage.centerX = centerX;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.15;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//        window_ = nil;
//        [self removeFromSuperview];
        self.userInteractionEnabled = YES;
    }];
    [sloganImage pop_addAnimation:anim forKey:nil];
}


- (void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    self.userInteractionEnabled = NO;
    
    NSInteger beginIndex = 1;
    
    for (NSInteger i = 1; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        CGFloat centerY = subView.centerY + [UIScreen mainScreen].bounds.size.height;
//        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subView pop_addAnimation:anim forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                window_ = nil;
                !completionBlock ? :completionBlock();
            }];
        }

    }


}

- (void)buttonClick:(UIButton *)btn
{
    [self cancelWithCompletionBlock:^{
        if (btn.tag == 2) {
//            ZCPostWordViewController *wordVC = [[ZCPostWordViewController alloc]init];
//            wordVC.title = @"发表文字";
            
            ZCGCDTimerViewController *wordVC = [[ZCGCDTimerViewController alloc]init];
            wordVC.title = @"GCD的定时器";
            ZCNavigationController *nav = [[ZCNavigationController alloc]initWithRootViewController:wordVC];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        }
    }];
}


- (IBAction)cancel
{
    [self cancelWithCompletionBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}

@end
