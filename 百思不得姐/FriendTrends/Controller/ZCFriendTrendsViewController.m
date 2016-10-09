//
//  ZCFriendTrendsViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCFriendTrendsViewController.h"
#import "ZCRecommendViewController.h"
#import "ZCLoginRegisterViewController.h"
@interface ZCFriendTrendsViewController ()

@end

@implementation ZCFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"friendsRecommentIcon" hightImageName:@"friendsRecommentIcon" target:self action:@selector(firendsClick)];
}

- (void)firendsClick
{
    ZCRecommendViewController *recommendVC = [[ZCRecommendViewController alloc]init];
    recommendVC.title = @"推荐关注";
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (IBAction)loginRegister:(id)sender {
    ZCLoginRegisterViewController *loginVC = [[ZCLoginRegisterViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
