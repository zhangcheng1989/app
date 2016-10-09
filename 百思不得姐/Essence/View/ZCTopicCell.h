//
//  ZCTopicCell.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/3.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTopics;
@interface ZCTopicCell : UITableViewCell

+ (instancetype)cell;

@property (nonatomic, strong) ZCTopics *topic;
@end
