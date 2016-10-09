//
//  ZCSquareButton.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/19.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCSquareButton.h"
#import "UIButton+WebCache.h"
#import "ZCSquare.h"
@implementation ZCSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.imageView.x = 0;
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(ZCSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:square.icon forState:UIControlStateNormal placeholderImage:nil];
}

@end
