//
//  ZCRecommendViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/22.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendViewController.h"
#import "SVProgressHUD.h"
#import "ZCHttpApi.h"
#import "ZCRecommendCategoryCell.h"
#import "YYModel.h"
#import "ZCRecommendCategory.h"
#import "ZCRecommendList.h"
#import "ZCRecommendUserCell.h"
#import "ZCRecommendUserList.h"
#import "MJRefresh.h"

@interface ZCRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (nonatomic, strong) NSMutableArray *categorys;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSMutableDictionary *params;
@end

static NSString *const identifier = @"category";

static NSString *const user = @"user";


@implementation ZCRecommendViewController


- (NSMutableArray *)categorys{
    if (!_categorys) {
        _categorys = [NSMutableArray array];
    }
    return _categorys;
}

- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpTableView];
    
    
    [self setUpRefresh];
    
    [self loadCategorys];
    

}

- (void)loadCategorys
{
    [SVProgressHUD show];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"category";
    param[@"c"] = @"subscribe";
    
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        [SVProgressHUD dismiss];
        
        ZCRecommendList *rcommendList = [ZCRecommendList yy_modelWithDictionary:dict];
        
        [self.categorys addObjectsFromArray:rcommendList.list];
        
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self.userTableView.mj_header beginRefreshing];
        
    }];
}


- (void)setUpTableView
{
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:user];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
}


- (void)setUpRefresh
{
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;
}

- (void)checkStaus:(ZCRecommendCategory *)c
{
    
    if (c.users.count == c.total) {//全部加载完毕
        [self.userTableView.mj_footer resetNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing]; //结束刷新
        
    }
}


- (void)loadMoreUsers
{
    
    ZCRecommendCategory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = c.id;
    param[@"page"] = @(c.currentPage++);
    self.params = param;
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        if (self.params != param)  return;
        ZCRecommendUserList *userList = [ZCRecommendUserList yy_modelWithDictionary:dict];
        [self.users addObjectsFromArray:userList.list];
        [c.users addObjectsFromArray:userList.list];
        [self.userTableView reloadData]; //刷新表格
        
        [self checkStaus:c];
    }];

}

- (void)loadNewUsers
{
    
    ZCRecommendCategory *category = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    
    category.currentPage = 0;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"subscribe";
    param[@"category_id"] = category.id;
    param[@"page"] = @(category.currentPage);
    
    self.params = param;
    
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        
        
        ZCRecommendUserList *userList = [ZCRecommendUserList yy_modelWithDictionary:dict];
        
        [self.users addObjectsFromArray:userList.list];
        
        [category.users removeAllObjects];
        
        [category.users addObjectsFromArray:userList.list];
        
        category.total = [dict[@"total"]integerValue];
        
        if (self.params != param)  return;

        
        [self.userTableView reloadData];
       
        [self.userTableView.mj_header endRefreshing];
        
        [self checkStaus:category];
        
        if (error) {
            
            [self.userTableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView) {
        return self.categorys.count;
    }else{
        
        if (self.categorys.count>0) {
           ZCRecommendCategory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
            self.userTableView.mj_footer.hidden = (c.users.count == 0);
            [self checkStaus:c];
            return c.users.count;
        }else{
            return self.users.count;
        }
    
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        ZCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.category = self.categorys[indexPath.row];
        return cell;
    }else{
        ZCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:user];
        ZCRecommendCategory *c = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
  
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    if (tableView == self.categoryTableView) {
        
        [self.userTableView.mj_footer resetNoMoreData];
        ZCRecommendCategory *category = self.categorys[indexPath.row];
        
        if (category.users.count) {
            [self.userTableView reloadData];
        }else{
            
            [self.userTableView reloadData];
            
            [self.userTableView.mj_header beginRefreshing];
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

- (void)dealloc{
    [[ZCHttpApi sharedManager].operationQueue cancelAllOperations];
    
}

@end
