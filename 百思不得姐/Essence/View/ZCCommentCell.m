//
//  ZCCommentCell.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/15.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCCommentCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZCExtension.h"
#import "ZCComment.h"
#import "ZCUser.h"
@interface ZCCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *prfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexIamge;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contntLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;
@end

@implementation ZCCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(ZCComment *)comment
{
    _comment = comment;
    
    [self.prfileImageView sd_setImageWithURL:comment.user.profile_image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.prfileImageView.image = [image circleImage];
    }];
    
    self.sexIamge.image = [comment.user.sex isEqualToString:UserMale]?[UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    
    self.contntLabel.text = comment.content;
    
    self.usernameLabel.text = comment.user.username;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
   
    if (comment.voiceurl) {
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceBtn.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = TopicCellMargin;
//    frame.size.width -= 2 * TopicCellMargin;
    [super setFrame:frame];
    
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
