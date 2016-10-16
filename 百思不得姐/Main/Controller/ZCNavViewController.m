//
//  ZCNavViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNavViewController.h"
#import "ZCSocialViewController.h"
#import "ZCNavLabel.h"
@interface ZCNavViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollerView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollerView;
@end

@implementation ZCNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets =  NO;
//    self.titleScrollerView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);

    [self setUpChildVC];
    
    [self setUpTitles];
    
    //加载第0个控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollerView];

}


- (void)setUpTitles{
    
    CGFloat labY = 0;
    CGFloat labW = 100;
    CGFloat labH = 35;
    
    NSInteger count = self.childViewControllers.count;
    
    for (NSInteger i = 0; i<count; i++) {
        ZCNavLabel *label = [[ZCNavLabel alloc]init];
        label.text = [self.childViewControllers[i] title];
        CGFloat labX = labW * i;
        label.frame = CGRectMake(labX, labY, labW, labH);
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
//        label.font = [UIFont systemFontOfSize:14.0];
        [self.titleScrollerView addSubview:label];
        
        if (i == 0) {
            label.scale = 1.0;
        }
    }
    
    self.titleScrollerView.contentSize = CGSizeMake(count*labW, 0);
    
    self.contentScrollerView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
    

}

- (void)setUpChildVC{
    ZCSocialViewController *social0 = [[ZCSocialViewController alloc]init];
    social0.title = @"国际";
    [self addChildViewController:social0];
    
    ZCSocialViewController *social1 = [[ZCSocialViewController alloc]init];
    social1.title = @"军事";
    [self addChildViewController:social1];
    
    ZCSocialViewController *social2 = [[ZCSocialViewController alloc]init];
    social2.title = @"社会";
    [self addChildViewController:social2];
    
    ZCSocialViewController *social3 = [[ZCSocialViewController alloc]init];
    social3.title = @"政治";
    [self addChildViewController:social3];
    
    ZCSocialViewController *social4 = [[ZCSocialViewController alloc]init];
    social4.title = @"体育";
    [self addChildViewController:social4];
    
    ZCSocialViewController *social5 = [[ZCSocialViewController alloc]init];
    social5.title = @"娱乐";
    [self addChildViewController:social5];
    
    ZCSocialViewController *social6 = [[ZCSocialViewController alloc]init];
    social6.title = @"经济";
    [self addChildViewController:social6];
}

- (void)labelClick:(UITapGestureRecognizer *)tap{
//    [self.titleScrollerView.subviews indexOfObject:tap.view];
    
    NSInteger index = tap.view.tag;
    
    CGPoint offset = self.contentScrollerView.contentOffset;
    
    offset.x = index  * self.contentScrollerView.width;
    
    [self.contentScrollerView setContentOffset:offset animated:YES];
    
}

#pragma mark --UIScrollViewDelegate
/**
 用户手动滚动结束后调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


/**
 scrollerview 结束滚动动画以后调用
 setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>方法执行完毕后
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    ZCNavLabel *lab = self.titleScrollerView.subviews[index];
    CGPoint titleOffset = self.titleScrollerView.contentOffset;
    titleOffset.x = lab.center.x - width * 0.5;
    //左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    //右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollerView.contentSize.width  - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollerView setContentOffset:titleOffset animated:YES];
    
    
    UIViewController *willShowVC = self.childViewControllers[index];
    
    //当前控制器被加载后，就直接返回
    if ([willShowVC isViewLoaded]) return;

    willShowVC.view.frame = CGRectMake(offsetX, 0, width, height);
    
    [scrollView addSubview:willShowVC.view];
}


/**
 只要scrollView滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //获取左边Label
    NSInteger leftIndex = scale;
    ZCNavLabel *leftLabel = self.titleScrollerView.subviews[leftIndex];
    
    //获取右边label
    NSInteger rightIndex = leftIndex + 1;
    ZCNavLabel *rightLabel = (rightIndex = self.titleScrollerView.subviews.count)? nil : self.titleScrollerView.subviews[rightIndex];
    
    //右边比例
    CGFloat rightScale = scale - leftIndex;
    //左边比例
    CGFloat leftScale  = 1 - rightScale;
    
    //设置label比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;


//    if (leftIndex == self.titleScrollerView.subviews.count - 1) return;
    

    
 
    
    
}

@end
