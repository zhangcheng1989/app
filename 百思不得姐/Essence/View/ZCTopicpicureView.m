//
//  ZCTopicureView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopicpicureView.h"
#import "ZCTopics.h"
#import "UIImageView+WebCache.h"
#import "ZCProgressView.h"
#import "ZCShowPicureViewController.h"
@interface ZCTopicpicureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet ZCProgressView *progressView;

@end

@implementation ZCTopicpicureView

+ (instancetype)picureView
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
    
    if (!topic.is_gif) {
        self.gifImage.hidden = YES;
    }
    
    [self.progressView setProgress:topic.pictureProgess animated:NO];
    
    [self.imageView sd_setImageWithURL:topic.image1 placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        topic.pictureProgess = 1.0 * receivedSize/ expectedSize;
        self.progressView.hidden = NO;
        [self.progressView setProgress:topic.pictureProgess animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        
        if (topic.image1 == NO) return ;
        
        UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
        
        CGFloat width = topic.pictureFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }];

    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

- (void)showPicure
{
    ZCShowPicureViewController *showVC = [[ZCShowPicureViewController alloc]init];
    showVC.topics = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showVC animated:YES completion:nil];
}

@end
