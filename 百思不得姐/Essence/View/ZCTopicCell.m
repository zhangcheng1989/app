//
//  ZCTopicCell.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/3.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopicCell.h"
#import "UIImageView+WebCache.h"
#import "ZCTopics.h"
#import "ZCTopicpicureView.h"
#import "ZCTopicVoiceView.h"
#import "ZCTopicVideoView.h"
#import "UIImage+ZCExtension.h"
#import "ZCComment.h"
#import "ZCUser.h"
@interface ZCTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *create_timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *profile_addV_image;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *topCmpContentLabel;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (nonatomic, strong) ZCTopicpicureView *picureView;
@property (nonatomic, strong) ZCTopicVoiceView *voiceView;
@property (nonatomic, strong) ZCTopicVideoView *videoView;
@end

@implementation ZCTopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (ZCTopicpicureView *)picureView
{
    if (!_picureView) {
        _picureView = [ZCTopicpicureView picureView];
        [self.contentView addSubview:_picureView];
    }
    return _picureView;
}

- (ZCTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        _voiceView = [ZCTopicVoiceView voiceView];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}


- (ZCTopicVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [ZCTopicVideoView videoView];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    self.profile_image.layer.cornerRadius = self.profile_image.width *0.5;
//    self.profile_image.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setTopic:(ZCTopics *)topic
{
    _topic = topic;
    
    self.profile_addV_image.hidden = !topic.isSina_v;
    
    
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self.profile_image sd_setImageWithURL:topic.profile_image placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.profile_image.image = [image circleImage];
        self.profile_image.image = image?[image circleImage]:placeholderImage;
    }];
    
    self.nameLabel.text = topic.name;
    self.create_timeLabel.text = topic.create_time;
    
    self.contentLabel.text = topic.text;
    
    [self setUpButton:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton count:topic.cai placeholder:@"顶"];
    [self setUpButton:self.shareButton count:topic.repost placeholder:@"顶"];
    [self setUpButton:self.commentButton count:topic.comment placeholder:@"顶"];
    
    if (topic.type == TopicTypePicture) { //图片
        self.picureView.topic = topic;
        self.picureView.frame  = topic.pictureFrame;
        
        self.picureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (topic.type == TopicTypeVoice){ //声音
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.picureView.hidden = YES;
    }else if (topic.type == TopicTypeVideo){ //视频
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.picureView.hidden = YES;
    }else{ //段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.picureView.hidden = YES;
    }
  
    ZCComment *comment = [topic.top_cmt firstObject];
    if (comment) {
        self.topCmtView.hidden = NO;
        self.topCmpContentLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content];
    }else{
        self.topCmtView.hidden = YES;
    }
}

//- (void)testDate:(NSString *)create_time
//{
//    NSDate *noewDate = [NSDate date];
//    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
//    fm.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *createDate = [fm dateFromString:create_time];
//    NSTimeInterval dale = [noewDate timeIntervalSinceDate:createDate];
//}

- (void)setUpButton:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if (count >0){
        placeholder = [NSString stringWithFormat:@"%li",count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (IBAction)more
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    
    [sheet showInView:self.window];
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= frame.origin.x*2;
    frame.size.height = self.topic.cellHeight - 10;
    frame.origin.y+=10;
    [super setFrame:frame];
}

@end
