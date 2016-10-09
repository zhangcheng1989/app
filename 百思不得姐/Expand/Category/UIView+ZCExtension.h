//
//  UIView+ZCExtension.h
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZCExtension)

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;


- (BOOL)isShowingOnWindow;

+ (instancetype)viewFromXib;

@end
