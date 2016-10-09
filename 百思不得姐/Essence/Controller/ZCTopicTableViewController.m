//
//  ZCWordTableViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/2.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopicTableViewController.h"
#import "ZCCommentViewController.h"
#import "ZCNewViewController.h"
#import "SVProgressHUD.h"
#import "ZCHttpApi.h"
#import "MJRefresh.h"
#import "ZCTopics.h"
#import "YYModel.h"
#import "ZCTopicCell.h"
@interface ZCTopicTableViewController ()
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end

static NSString *const identifier = @"topic";

@implementation ZCTopicTableViewController


- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpTableView];
    
    [self setUpRefresh];
}


- (void)setUpTableView
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = titleViewY + titleViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCTopicCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarClick) name:TabBarDidSelectedNotfication object:nil];
}


- (void)tabBarClick
{
    //self.tabBarController.selectedViewController == self.navigationController
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingOnWindow){
         [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
   
}

- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES; //设置透明度
    [self.tableView.mj_header beginRefreshing];
    
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (NSString *)a
{
   
    return  [self.parentViewController isKindOfClass:[ZCNewViewController class]] ? @"newlist" : @"list";
}

- (void)loadNewTopic
{
    
    [self.tableView.mj_footer endRefreshing];
    
    self.page = 0;
    
    NSDictionary *param = @{@"a":self.a,@"c":@"data",@"type":@(self.type)};
        
    self.param = param;
    
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        if (self.param !=param) return ;
        self.maxtime = dict[@"info"][@"maxtime"];
        self.topics = [NSArray yy_modelArrayWithClass:[ZCTopics class] json:dict[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;
    }];
}

- (void)loadMoreTopic
{
    
    
    [self.tableView.mj_header endRefreshing];
    
    self.page ++;
    NSDictionary *param = @{@"a":self.a,@"c":@"data",@"type":@(self.type),@"page":@(self.page),@"maxtime":self.maxtime};
    
    self.param = param;
    
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        if(self.param != param) return ;
        self.maxtime = dict[@"info"][@"maxtime"];
        NSArray *array = [NSArray yy_modelArrayWithClass:[ZCTopics class] json:dict[@"list"]];
        [self.topics addObjectsFromArray:array];
        [self.tableView reloadData];        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.topic = self.topics[indexPath.row];
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCTopics *topic = self.topics[indexPath.row];
//    CGFloat textY = 55;
//    CGFloat textH  = [topic.text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT)].height;

    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCTopics *topic = self.topics[indexPath.row];
    
    ZCCommentViewController *commentVC = [[ZCCommentViewController alloc]init];
    commentVC.title = @"评论";
    commentVC.topic = topic;
    [self.navigationController pushViewController:commentVC animated:YES];
}

@end
