//
//  ZCBaseViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCBaseViewController.h"
#import <objc/runtime.h>
@interface ZCBaseViewController ()

@end

@implementation ZCBaseViewController

+ (void)load{
    Method *method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    
    Method *method2 = class_getInstanceMethod(self, @selector(zc_dealloc));

    method_exchangeImplementations(method1, method2);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = ZCColor(223, 223, 223);
    
}


- (void)zc_dealloc{
    NSLog(@"--zc_dealloc----%@",self);
}



@end
