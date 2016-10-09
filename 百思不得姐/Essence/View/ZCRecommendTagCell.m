//
//  ZCRecommendTagCell.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/27.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendTagCell.h"
#import "UIImageView+WebCache.h"
@interface ZCRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *image_list;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;
@end

@implementation ZCRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setRecommendTag:(ZCRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.image_list sd_setImageWithURL:recommendTag.image_list placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number<10000) {
        subNumber = [NSString stringWithFormat:@"%li人订阅",recommendTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f人订阅",recommendTag.sub_number / 10000.0];
    }
    
    self.subNumberLabel.text = subNumber;
}

#warning  重写frame
- (void)setFrame:(CGRect)frame{
    
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
    
}




@end
