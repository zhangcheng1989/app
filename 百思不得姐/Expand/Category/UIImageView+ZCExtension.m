//
//  UIImageView+ZCExtension.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/17.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "UIImageView+ZCExtension.h"
#import "UIImage+ZCExtension.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (ZCExtension)

- (void)setHeaderImage:(NSURL *)url
{
    
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image?[image circleImage]:placeholderImage;
    }];
    
}

@end
