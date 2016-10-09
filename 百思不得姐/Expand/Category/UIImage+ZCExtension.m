//
//  UIImage+ZCExtension.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/17.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "UIImage+ZCExtension.h"

@implementation UIImage (ZCExtension)


- (UIImage *)circleImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0); //开启上下文
    CGContextRef ctc = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctc, rect);
    CGContextClip(ctc); //裁剪
    [self drawInRect:rect]; //绘制
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); //结束上下文
    return image;
}

+ (UIImage *)resizableImageWithName:(NSString *)imageName{
    
    UIImage *image = [self imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
