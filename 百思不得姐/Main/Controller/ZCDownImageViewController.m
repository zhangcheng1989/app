//
//  ZCDownImageViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCDownImageViewController.h"

@interface ZCDownImageViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZCDownImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"image"];
    
    
}


#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
    
    return cell;
}


@end
