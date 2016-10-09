//
//  ZCTopicVoiceView.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTopics;
@interface ZCTopicVoiceView : UIView

+ (instancetype)voiceView;
@property (nonatomic, strong) ZCTopics *topic;

@end
