//
//  ZCEssenceViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCEssenceViewController.h"
#import "ZCRecommendTagsViewController.h"
#import "ZCTopicTableViewController.h"

@interface ZCEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *titlesView;
@property (nonatomic, strong) UIScrollView *contentView;
@end

@implementation ZCEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpController];
    
    [self setUpTitlesView];
    
    [self setUpContentView];
    
}

- (void)setUpNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" hightImageName:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}


- (void)setUpTitlesView
{
    self.titlesView = [[UIView alloc]init];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    self.titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    self.titlesView.width = self.view.width;
    self.titlesView.height = titleViewH;
    self.titlesView.y = titleViewY;
    [self.view addSubview:self.titlesView];
    
    self.indicatorView = [[UIView alloc]init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    self.indicatorView.height = 2;
    self.indicatorView.y = self.titlesView.height - self.indicatorView .y;
    
    CGFloat width = self.titlesView.width/self.childViewControllers.count;
    CGFloat height = self.titlesView.height;
    for (NSInteger i =0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.width = width;
        button.height = height;
        button.x = i * width;
        button.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [self.titlesView addSubview:self.indicatorView];
  
}


- (void)setUpContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentView = [[UIScrollView alloc]init];
    self.contentView.frame = self.view.bounds;
//    [self.view addSubview:contentView];
    self.contentView.delegate = self;
    self.contentView.pagingEnabled = YES;
    [self.view insertSubview:self.contentView   atIndex:0];
    
    self.contentView.contentSize = CGSizeMake(self.contentView.width * self.childViewControllers.count, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    
}

- (void)setUpController
{
    
    ZCTopicTableViewController *allVC = [[ZCTopicTableViewController alloc]init];
    allVC.title = @"全部";
    allVC.type = TopicTypeAll;
    [self addChildViewController:allVC];
    
    ZCTopicTableViewController *voiceVC = [[ZCTopicTableViewController alloc]init];
    voiceVC.title = @"视频";
    voiceVC.type = TopicTypeVideo;
    [self addChildViewController:voiceVC];

    
    ZCTopicTableViewController *videoVC = [[ZCTopicTableViewController alloc]init];
    videoVC.title = @"声音";
    videoVC.type = TopicTypeVoice;
    [self addChildViewController:videoVC];

    ZCTopicTableViewController *pictureVC = [[ZCTopicTableViewController alloc]init];
    pictureVC.title = @"图片";
    pictureVC.type = TopicTypePicture;
    [self addChildViewController:pictureVC];
    
    
    ZCTopicTableViewController *wordVC = [[ZCTopicTableViewController alloc]init];
    wordVC.title = @"段子";
    wordVC.type = TopicTypeWord;
    [self addChildViewController:wordVC];
}

- (void)titleClick:(UIButton *)button
{
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    
    CGPoint offSet =  self.contentView.contentOffset;
    offSet.x = button.tag * self.contentView.width;
    
    [self.contentView setContentOffset:offSet animated:YES];
    
    
    
}

#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
    
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.titlesView.subviews[index]];
}

- (void)tagClick
{
    ZCRecommendTagsViewController *tagsVC = [[ZCRecommendTagsViewController alloc]init];
    tagsVC.title = @"推荐标签";
    [self.navigationController pushViewController:tagsVC animated:YES];
}



@end
