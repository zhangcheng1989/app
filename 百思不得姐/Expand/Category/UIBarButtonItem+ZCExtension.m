
//
//  UIBarButtonItem+ZCExtension.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "UIBarButtonItem+ZCExtension.h"

@implementation UIBarButtonItem (ZCExtension)

+ (instancetype)itemWithImageName:(NSString *)imageName hightImageName:(NSString *)hidhtImageName target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hidhtImageName] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:button];
    
}

@end
