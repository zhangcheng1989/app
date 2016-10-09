//
//  ZCMeViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMeViewController.h"
#import "ZCMeCell.h"
#import "ZCMeFooterView.h"
#import "ZCSettingTableViewController.h"
@interface ZCMeViewController ()<UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString *const meId = @"me";

@implementation ZCMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpTabelView];
    

}

- (void)setUpNav
{
    self.navigationItem.title = @"我的";
    UIBarButtonItem *setingItem = [UIBarButtonItem itemWithImageName:@"mine-setting-icon" hightImageName:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    
    UIBarButtonItem *monnItem = [UIBarButtonItem itemWithImageName:@"mine-moon-icon" hightImageName:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[setingItem,monnItem];
}

- (void)setUpTabelView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ZCMeCell class] forCellReuseIdentifier:meId];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = TopicCellMargin;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(TopicCellMargin - 35, 0, 0, 0);
    self.tableView.tableFooterView = [[ZCMeFooterView alloc]init];
    [self.view addSubview:self.tableView];
    
    
}

- (void)settingClick
{
    [self.navigationController pushViewController:[[ZCSettingTableViewController alloc]initWithStyle:UITableViewStyleGrouped] animated:YES];
}

- (void)moonClick
{
    
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meId];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登陆/注册";
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}




@end
