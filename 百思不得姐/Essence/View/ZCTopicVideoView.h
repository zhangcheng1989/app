//
//  ZCTopicVideoView.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTopics;
@interface ZCTopicVideoView : UIView

+ (instancetype)videoView;
@property (nonatomic, strong) ZCTopics *topic;

@end
