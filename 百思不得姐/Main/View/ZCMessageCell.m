//
//  ZCMessageCell.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMessageCell.h"
#import "ZCMessage.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
@interface ZCMessageCell()

@property (weak, nonatomic) IBOutlet UIButton *contentButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation ZCMessageCell
//
//+ (instancetype)mesageCell{
//    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentButton.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setMessage:(ZCMessage *)message{
    _message = message;
    self.timeLabel.hidden = message.hideTime;
    self.timeLabel.text = message.time;
    [self.contentButton setTitle:message.text forState:UIControlStateNormal];

    [self layoutIfNeeded];
    
    [self.contentButton mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat buttonH = self.contentButton.titleLabel.frame.size.height;
        make.height.mas_equalTo(buttonH);
    }];

    [self layoutIfNeeded];
    
    CGFloat buttonMaxY = CGRectGetMaxY(self.contentButton.frame);
    CGFloat iconMaxY = CGRectGetMaxY(self.iconView.frame);
    
    message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;
    
}

@end
