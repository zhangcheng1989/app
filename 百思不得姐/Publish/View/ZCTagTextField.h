//
//  ZCTagTextField.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/25.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZCTagTextField : UITextField

@property (nonatomic, copy) void(^deleteBlock)();

@end
