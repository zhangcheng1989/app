//
//  ZCCommentViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCCommentViewController.h"
#import "ZCTopics.h"
#import "ZCTopicCell.h"
#import "MJRefresh.h"
#import "ZCHttpApi.h"
#import "YYModel.h"
#import "ZCComment.h"
#import "ZCCommentHeaderView.h"
#import "ZCCommentCell.h"
@interface ZCCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;

@property (nonatomic, strong) NSArray *hotComments;
@property (nonatomic, strong) NSMutableArray *LatestComment;
@property (nonatomic, strong) NSArray *saved_top_cmt;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger selected;
@end

static NSString *const commentId = @"comment";

@implementation ZCCommentViewController


- (NSMutableArray *)LatestComment
{
    if (!_LatestComment) {
        _LatestComment = [NSMutableArray array];
    }
    return _LatestComment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBasic];

    [self setUpHeader];
    
    [self setUpRefresh];
    
}

- (void)setUpBasic
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"comment_nav_item_share_icon" hightImageName:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //开始设置cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCCommentCell class]) bundle:nil] forCellReuseIdentifier:commentId];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

- (void)setUpHeader
{
    if (self.topic.top_cmt.count) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }

    UIView *header = [[UIView alloc]init];
    ZCTopicCell *topicCell = [ZCTopicCell cell];
    topicCell.topic = self.topic;
    topicCell.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.topic.cellHeight);
    [header addSubview:topicCell];
    header.height = self.topic.cellHeight + 10;
    self.tableView.tableHeaderView = header;
    
//    self.tableView registerNib:<#(nullable UINib *)#> forHeaderFooterViewReuseIdentifier:<#(nonnull NSString *)#>
    
}

- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
    self.tableView.mj_footer.hidden = YES;
}


- (void)loadNewComment
{
//    [[ZCHttpApi sharedManager]cancelTask];
    
    [[ZCHttpApi sharedManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSDictionary *param = @{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.topicId,@"hot":@(1)};
     [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        
//        [dict writeToFile:@"/Users/zhangcheng/Desktop/dict.plist" atomically:YES];
        
        self.hotComments = [NSArray yy_modelArrayWithClass:[ZCComment class] json:dict[@"hot"]];
        NSArray *array = [NSArray yy_modelArrayWithClass:[ZCComment class] json:dict[@"data"]];
        [self.LatestComment addObjectsFromArray:array];
        
        self.page = 1;
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [dict[@"total"] integerValue];
        
        if (self.LatestComment.count >= total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }
    }];
}

- (void)loadMoreComment
{
    
//    [[ZCHttpApi sharedManager]cancelTask];
    [[ZCHttpApi sharedManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    ZCComment *cmt = [self.LatestComment lastObject];
    
    NSDictionary *param = @{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.topicId,@"page":@(page),@"lastcid":@(cmt.commentId)};
    
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        
        NSArray *array = [NSArray yy_modelArrayWithClass:[ZCComment class] json:dict[@"data"]];
        
        self.page = page;
        
        [self.LatestComment addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        NSInteger total = [dict[@"total"] integerValue];
        
        if (self.LatestComment.count >= total) { //全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
}

- (void)keyboardWillFrame:(NSNotification *)note
{
    
    //键盘显示\影藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //修改底部的约束
    self.bottomSapce.constant = [UIScreen mainScreen].bounds.size.height - frame.origin.y;
    //键盘弹起动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //重新布局
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.LatestComment.count;
    if(hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.LatestComment.count;
    
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount:latestCount;
    }
    return latestCount;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentId];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}


#pragma mark --UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount?@"最热评论":@"最新评论";
//    }
//    
//    return @"最新评论";
//}

//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *hdView = [[UIView alloc]init];
//    hdView.backgroundColor = ZCColor(223, 223, 223);
//    
//    UILabel *label = [[UILabel alloc]init];
//    label.width = 200;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    label.x = TopicCellMargin;
//    label.textColor = ZCColor(67, 67, 67);
//    [hdView addSubview:label];
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text =  hotCount?@"最热评论":@"最新评论";
//    }else{
//        
//        label.text = @"最新评论";
//    }
//
//    return hdView;
//}



//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *const hd = @"header";
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hd];
//    UILabel *label = nil;
//    if (header == nil) {
//        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:hd];
//        header.contentView.backgroundColor = ZCColor(223, 223, 223);
//        label = [[UILabel alloc]init];
//        label.width = 200;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.x = TopicCellMargin;
//        label.textColor = ZCColor(67, 67, 67);
//        [header.contentView addSubview:label];
//    }else{
//        label = (UILabel *)[header viewWithTag:HeaderLabelTag];
//    }
//    
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text =  hotCount?@"最热评论":@"最新评论";
//    }else{
//        label.text = @"最新评论";
//    }
//    
//    return header;
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    ZCCommentHeaderView *header = [ZCCommentHeaderView headerViewWith:tableView];

    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title =  hotCount?@"最热评论":@"最新评论";
    }else{
        header.title = @"最新评论";
    }
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    if (menuVC.isMenuVisible) {
        [menuVC setMenuVisible:NO animated:YES];
        return;
    }else{
        ZCCommentCell *cell = (ZCCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        menuVC.menuItems = @[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height *0.5);
        [menuVC setTargetRect:rect inView:cell];
        [menuVC setMenuVisible:YES animated:YES];
    }

}

- (void)ding:(UIMenuController *)menu
{
    
}

- (void)replay:(UIMenuController *)menu
{
    
}

- (void)report:(UIMenuController *)menu
{
    
}


//- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
//{
////    ZCCommentHeaderView *header = [ZCCommentHeaderView headerViewWith:tableView];
//    
//    static NSString *hd = @"header";
//    
//    ZCCommentHeaderView *header = [[ZCCommentHeaderView alloc]initWithReuseIdentifier:hd];
//    
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        header.title =  hotCount?@"最热评论":@"最新评论";
//    }else{
//        header.title = @"最新评论";
//    }
//    
//    return header;
//
//}

#pragma mark --返回第section组数据
- (NSArray *)commentInSection:(NSInteger)section
{
    if (section == 0) {
        
        if (self.hotComments.count > 0 ) {
            return self.hotComments;
        }else{
            return self.LatestComment;
        }
        
//        return self.hotComments ? self.hotComments:self.LatestComment;
    }

    return self.LatestComment;
}

- (ZCComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
   return [self commentInSection:indexPath.section][indexPath.row];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if (self.saved_top_cmt.count) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    [[ZCHttpApi sharedManager]invalidateSessionCancelingTasks:YES];
}


@end
