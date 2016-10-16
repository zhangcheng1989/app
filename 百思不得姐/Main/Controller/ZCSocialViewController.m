//
//  ZCSocialViewController.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/16.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSocialViewController.h"

@interface ZCSocialViewController ()

@end

static NSString *ID = @"cell";

@implementation ZCSocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%li",self.title,indexPath.row];
    return cell;
}



@end
