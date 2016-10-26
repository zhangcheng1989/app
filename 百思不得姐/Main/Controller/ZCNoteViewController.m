//
//  ZCNoteViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/25.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCNoteViewController.h"

@interface ZCNoteViewController ()

@end

@implementation ZCNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (IBAction)fireLocalNote:(id)sender {
    //创建本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc]init];
    //设置通知发送时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];
    //设置通知发送内容
    localNote.alertBody = @"吃饭了吗";
    //调用通知
    [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
}


@end
