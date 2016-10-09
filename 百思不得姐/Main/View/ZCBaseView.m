//
//  ZCBaseView.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/9.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCBaseView.h"

@implementation ZCBaseView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan ----- %@",[self class]);
}

@end
