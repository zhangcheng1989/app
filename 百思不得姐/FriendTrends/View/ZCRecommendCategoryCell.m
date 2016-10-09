//
//  ZCRecommendCategoryCell.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCRecommendCategoryCell.h"
#import "ZCRecommendCategory.h"

@interface ZCRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *selectedIndictor;

@end

@implementation ZCRecommendCategoryCell


- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = ZCColor(244, 244, 244);
    self.textLabel.textColor = ZCColor(78, 78, 78);
    self.textLabel.highlightedTextColor = ZCColor(219, 21, 26);
}

- (void)setCategory:(ZCRecommendCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.selectedIndictor.hidden = !selected;
    
    if (selected) {
        self.textLabel.textColor = ZCColor(219, 21, 26);
    }else{
        self.textLabel.textColor = ZCColor(78, 78, 78);
    }
}

@end
