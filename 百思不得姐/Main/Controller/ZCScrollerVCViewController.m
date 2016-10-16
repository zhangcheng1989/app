//
//  ZCScrollerVCViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/16.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//



#import "ZCScrollerVCViewController.h"

@interface ZCScrollerVCViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIView *blueView;
@end

@implementation ZCScrollerVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollerView.contentSize = CGSizeMake(0,CGRectGetMaxY( self.blueView.frame));
    
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat imaegH = self.imageView.frame.size.height;
    
    if (offsetY >= imaegH) { //如果有导航条设置导航条的高度
        CGRect redF = self.redView.frame;
        redF.origin.y = 64;
        self.redView.frame = redF;
        [self.view addSubview:self.redView];
    }else{
        CGRect redF = self.redView.frame;
        redF.origin.y = 140;
        self.redView.frame = redF;
        [self.scrollerView addSubview:self.redView];
    }
    
    
    if (offsetY < 0) {
        CGFloat scale = 1 - ( offsetY / 50);
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

@end
