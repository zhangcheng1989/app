//
//  ZCNewViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNewViewController.h"

@interface ZCNewViewController ()

@end

@implementation ZCNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" hightImageName:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

- (void)tagClick
{
    
}


@end
