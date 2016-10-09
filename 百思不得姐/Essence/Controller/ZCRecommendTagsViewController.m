//
//  ZCRecommendTagsViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendTagsViewController.h"
#import "SVProgressHUD.h"
#import "ZCHttpApi.h"
#import "YYModel.h"
#import "ZCRecommendTagCell.h"
@interface ZCRecommendTagsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) UITableView *tagsTableView;
@end


static NSString *const identifier = @"tagCell";

@implementation ZCRecommendTagsViewController


- (NSMutableArray *)tags{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self loadTags];

    
}

- (void)setUpTableView
{
    self.tagsTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tagsTableView.dataSource = self;
    self.tagsTableView.delegate = self;
    [self.tagsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendTagCell class]) bundle:nil]  forCellReuseIdentifier:identifier];
    self.tagsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tagsTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tagsTableView];
}

- (void)loadTags
{
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:params complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        [SVProgressHUD dismiss];
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[ZCRecommendTag class] json:dict];
        [self.tags addObjectsFromArray:array];
        
        [self.tagsTableView reloadData];
    }];
}


#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}

#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

@end
