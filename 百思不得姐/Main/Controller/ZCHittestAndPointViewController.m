//
//  ZCHittestAndPointViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/9.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCHittestAndPointViewController.h"
#import "ZCPopBtn.h"
@interface ZCHittestAndPointViewController ()
@property (weak, nonatomic) IBOutlet UIButton *popBtn;

@end

@implementation ZCHittestAndPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)popBtn:(ZCPopBtn *)sender {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 200, 200);
    btn.center = CGPointMake(100, -100);
    [btn setBackgroundImage:[UIImage imageNamed:@"mainCellCommentClick"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateHighlighted];
    sender.popBtn = btn;
    [sender addSubview:btn];
    
    
}


@end
