//
//  ZCTagButton.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/24.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTagButton.h"

@implementation ZCTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = ZCColor(74, 139, 209);
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self setImage:[UIImage imageNamed:@"post-tag-close-icon"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"post-tag-close-iconN"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
    self.width += 3 * tagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = tagMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+tagMargin;
}

@end
