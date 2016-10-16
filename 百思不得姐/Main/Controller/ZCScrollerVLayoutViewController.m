//
//  ZCScrollerVLayoutViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/16.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCScrollerVLayoutViewController.h"

@interface ZCScrollerVLayoutViewController ()

@end

@implementation ZCScrollerVLayoutViewController




/**
 UIScrollerView 内部子控件添加的注意点：
    1、子控件的尺寸不能通过UIScrollerView来计算，可以考虑通过以下方式计算
        *可以设置固定值(width = 100 height = 100)
        *可以通过相对于UIScollerView以外的其他控件来计算尺寸
    2、UIScrollerView的frame应该通过子控件以外的其他控件计算
    3、UIScrollerView的ContentSize通过子控件计算
        *根据子控件的尺寸以及子控件与UIScrollerView之间的间距
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
