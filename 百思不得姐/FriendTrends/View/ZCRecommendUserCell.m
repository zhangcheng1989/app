//
//  ZCRecommendUserCell.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendUserCell.h"
#import "ZCRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface ZCRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *header_img;
@property (weak, nonatomic) IBOutlet UILabel *screenNamelable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ZCRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setUser:(ZCRecommendUser *)user{
    _user = user;
    
    [_header_img sd_setImageWithURL:user.header placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screenNamelable.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%li人关注",user.fans_count];
}

@end
