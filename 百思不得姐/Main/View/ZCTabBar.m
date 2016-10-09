
//
//  ZCTabBar.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTabBar.h"
#import "ZCPublishView.h"
@interface ZCTabBar()
@property (nonatomic, strong) UIButton *publishButton;
@end

@implementation ZCTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [ super initWithFrame:frame]) {
        
        self.publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [self.publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        [self.publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.publishButton];
        
        
    }
    return self;
}

- (void)publishClick
{
//    ZCPublishViewController *publishVC = [[ZCPublishViewController alloc]init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
    
    [ZCPublishView show];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.publishButton.frame = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);

    self.publishButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height * 0.5);
    
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width/5;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        CGFloat btnX = btnW * ((index > 1)?(index+1):index);
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index++;
    }
}

@end