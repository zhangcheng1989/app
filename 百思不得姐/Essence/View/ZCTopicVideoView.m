//
//  ZCTopicVideoView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/11.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopicVideoView.h"
#import "ZCTopics.h"
#import "UIImageView+WebCache.h"
#import "ZCShowPicureViewController.h"
@interface ZCTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@property (weak, nonatomic) IBOutlet UILabel *payCountLabel;
@end

@implementation ZCTopicVideoView


+ (instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicure)]];
}

- (void)setTopic:(ZCTopics *)topic
{
    _topic = topic;

    [self.imageView sd_setImageWithURL:topic.image1];
    self.payCountLabel.text = [NSString stringWithFormat:@"%li播放",topic.playfcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",second,minute];
}

- (void)showPicure
{
    ZCShowPicureViewController *showVC = [[ZCShowPicureViewController alloc]init];
    showVC.topics = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}



@end
