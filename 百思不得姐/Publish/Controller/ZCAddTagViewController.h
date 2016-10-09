//
//  ZCAddTagViewController.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCBaseViewController.h"

@interface ZCAddTagViewController : ZCBaseViewController

@property (nonatomic, copy) void (^tagBlock)(NSArray *tags);

@property (nonatomic, strong) NSArray *tags;

@end
