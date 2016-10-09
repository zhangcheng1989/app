//
//  ZCCommentHeaderView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/13.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCCommentHeaderView.h"


@interface ZCCommentHeaderView()
@property (nonatomic, strong) UILabel *label;
@end

static NSString *const hd = @"header";


@implementation ZCCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = ZCColor(223, 223, 223);
        self.label = [[UILabel alloc]init];
        self.label.width = 200;
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.label.x = TopicCellMargin;
        self.label.textColor = ZCColor(67, 67, 67);
        [self.contentView addSubview:self.label];
    }
    return self;
}

+ (instancetype)headerViewWith:(UITableView *)tableView
{
    ZCCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:hd];
    if (header == nil) {
        header = [[ZCCommentHeaderView alloc]initWithReuseIdentifier:hd];
    }
    return header;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.label.text = title;
}

@end
