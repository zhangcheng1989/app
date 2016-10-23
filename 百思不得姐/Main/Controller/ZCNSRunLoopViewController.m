//
//  ZCNSRunLoopViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNSRunLoopViewController.h"

@interface ZCNSRunLoopViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSThread *thread;

@end

@implementation ZCNSRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    
    [self.thread start];
}

/**

什么是RunLoop
 运行循环，在这个循环内部不断的处理各种任务事件（Source，Timer，Observer）
 一个线程对应一个RunLoop，主线程的RunLoop默认已经启动，子线程的RunLoop需要手动启动
 RunLoop只能选择一个Mode启动，如果当前Mode中没有任何Source（Source0,Source1），Timer那么直接退出RunLoop
 
在开发中如何使用RunLoop,应用于什么场景
 开启一个常驻线程（让一个子线程不进入消亡状态，等待其他线程发来消息，处理其他事件）
 在子线程中开启一个定时任务
 在子线程中长期监控一些行文
 
自动释放池什么时候释放
 通过Observer监听RunLoop的状态，一旦监听到RunLoop即将进入睡眠等待状态就释放自动释放池(KCFRunLoopBeforeWating)
 
 */
- (void)run{
    NSLog(@"-----------run---------%@",[NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop]addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]run];
    
    NSLog(@"----------------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
   
}


- (void)test{
    NSLog(@"-----------test---------%@",[NSThread currentThread]);

}

- (void)imageClick{
    
    //只在NSDefaultRunLoopMode显示图片
     [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"1"] afterDelay:3.0 inModes:@[NSDefaultRunLoopMode]];
}

- (void)ovserver{
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"------------监听到RunLoop状态发生改变----%zd",activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    CFRelease(observer); //释放observer
}

- (void)timer{
    
    //    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    //定时器只会泡在NSDefaultRunLoopMode模式下,一旦runLoop 进入其他模式，就不会运行
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //定时器会跑在标记为Common Modes模式下
    //NSDefaultRunLoopMode
    //UITrackingRunLoopMode
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

//- (void)run{
//    NSLog(@"----run");
//}

@end
