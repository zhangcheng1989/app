//
//  ZCGCDTimerViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCGCDTimerViewController.h"

@interface ZCGCDTimerViewController ()
@property(nonatomic, strong) dispatch_source_t timer;
@end

@implementation ZCGCDTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

int count = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //创建定时器(dispatch_source_t 本质还是oc对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置定时器的各种属性（什么时候开始任务，每个多长事件执行一次）
    //GCD的时间参数，一般是纳秒(1秒==10的9次方纳秒)
    //开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    //每隔2秒执行
    uint64_t interval = (uint64_t)(2.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"-------------%@",[NSThread currentThread]);
        count ++;
        if (count == 4) {
            dispatch_cancel(self.timer);
            self.timer = nil;
        }
    });
    
    //启动定时器
    dispatch_resume(self.timer);
    
//    dispatch_release(self.timer);
}


@end
