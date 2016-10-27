

//
//  ZCTopWindowsViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopWindowsViewController.h"

@interface ZCTopWindowsViewController ()

@end



@implementation ZCTopWindowsViewController

static id instance_;

+ (instancetype)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc]init];
    });
    
    return instance_;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    
    return instance_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//默认是YES
- (BOOL)prefersStatusBarHidden{
    return NO;
}

//改变状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
//    [self setNeedsStatusBarAppearanceUpdate]; 更新状态栏
    
    return UIStatusBarStyleLightContent;
}

@end
