//
//  ZCVerticalButton.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCVerticalButton.h"

@implementation ZCVerticalButton


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    self.imageView.x = 0;
//    self.imageView.y = 0;
//    
//    self.titleLabel.x = 0;
//    self.titleLabel.y = self.imageView.height;
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.titleLabel.y;


    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
