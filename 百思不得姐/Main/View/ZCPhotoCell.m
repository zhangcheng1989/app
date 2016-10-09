//
//  ZCPhotoCell.m
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCPhotoCell.h"

@interface ZCPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ZCPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 10;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
