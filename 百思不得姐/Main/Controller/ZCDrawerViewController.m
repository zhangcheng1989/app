//
//  ZCDrawerViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/9.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCDrawerViewController.h"
//自动提示宏
#define keyPath(objc,keyPath) (objc.keyPath)

@interface ZCDrawerViewController ()
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, weak) UIView *rightView;

@end

@implementation ZCDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpChildView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
//    keyPath(_mainView.frame, <#keyPath#>)
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    
    CGFloat offsetX = point.x;
    
  
    _mainView.frame = [self frameOffsetX:offsetX];
    
    [pan setTranslation:CGPointZero inView:self.view];
}

- (CGRect)frameOffsetX:(CGFloat)offsetX{
    CGRect frame = _mainView.frame;
    frame.origin.x += offsetX;
    return frame;
}

- (void)setUpChildView
{
    UIView *leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:leftView];
    self.leftView = leftView;
    
    
    UIView *rightView = [[UIView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:rightView];
    self.rightView = rightView;
    
    UIView *mainView = [[UIView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:mainView];
    self.mainView = mainView;
}



@end
