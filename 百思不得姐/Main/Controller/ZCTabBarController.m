//
//  ZCTabBarController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCEssenceViewController.h"
#import "ZCNewViewController.h"
#import "ZCFriendTrendsViewController.h"
#import "ZCMeViewController.h"
#import "ZCNavigationController.h"
#import "ZCTabBar.h"

@interface ZCTabBarController ()

@end

@implementation ZCTabBarController

+ (void)initialize
{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12.0];
    attr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpChildVC:[[ZCEssenceViewController alloc]init] imageName:@"tabBar_essence_icon" selImageName:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self setUpChildVC:[[ZCNewViewController alloc]init] imageName:@"tabBar_new_icon" selImageName:@"tabBar_new_click_icon" title:@"新帖"];
    
    [self setUpChildVC:[[ZCFriendTrendsViewController alloc]init] imageName:@"tabBar_friendTrends_icon" selImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    [self setUpChildVC:[[ZCMeViewController alloc]init] imageName:@"tabBar_me_icon" selImageName:@"tabBar_me_click_icon" title:@"我"];
    
    
    [self setValue:[[ZCTabBar alloc]init] forKeyPath:@"tabBar"];
    
}


- (void)setUpChildVC:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selImageName];
    ZCNavigationController *rootVC = [[ZCNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:rootVC];
}


@end
