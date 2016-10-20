//
//  ZCNSOperationViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/19.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNSOperationViewController.h"

@interface ZCNSOperationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ZCNSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
     __block UIImage *image1 = nil;
    
    __block UIImage *image2 = nil;
    
    //下载图片
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@""];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:@""];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image2 = [UIImage imageWithData:data];
    }];
    //合并图片
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        UIGraphicsBeginImageContext(CGSizeMake(100, 100)); //开启图片上下文
        [image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        image1 = nil;
        [image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        image2 = nil;
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];

    }];
    
    [combine addDependency:op1];
    [combine addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:combine];
}

- (void)dependency{ //依赖
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"down1-----%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"down2-----%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"down3-----%@",[NSThread currentThread]);
    }];
    
    
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    
    op1.completionBlock = ^{
        NSLog(@"op1执行完毕---%@",[NSThread currentThread]);
    };
}


- (void)suspended{ //挂起
    NSOperation *op = [[NSOperation alloc]init];
    
    self.queue = [[NSOperationQueue alloc]init];
    if (self.queue.isSuspended) { //挂起，如果有耗时操作，要自己判断取消
        self.queue.suspended = NO;
    }else{
        self.queue.suspended = YES;
    }
    
    //    if (op.cancelled) return;
    
    [self.queue cancelAllOperations];
}

- (void)maxCountCurrentOperationCount{//最大并发数
    
    NSOperationQueue *que = [[NSOperationQueue alloc]init];
    
    que.maxConcurrentOperationCount = 3;//设置最大并发数 为1的时候就是串行队列
    
    [que addOperationWithBlock:^{
        NSLog(@"download1-------%@",[NSThread currentThread]);
    }];
    
    [que addOperationWithBlock:^{
        NSLog(@"download2-------%@",[NSThread currentThread]);
    }];
    
    [que addOperationWithBlock:^{
        NSLog(@"download3-------%@",[NSThread currentThread]);
    }];
    
    [que addOperationWithBlock:^{
        NSLog(@"download4-------%@",[NSThread currentThread]);
    }];
    
    [que addOperationWithBlock:^{
        NSLog(@"download5-------%@",[NSThread currentThread]);
    }];
    
    [que addOperationWithBlock:^{
        NSLog(@"download6-------%@",[NSThread currentThread]);
    }];
}


@end
