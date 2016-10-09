//
//  ZCCommentHeaderView.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/13.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCCommentHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWith:(UITableView *)tableView;

@property (nonatomic, copy) NSString *title;



@end
