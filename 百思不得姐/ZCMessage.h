//
//  ZCMessage.h
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/5.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeMe = 0,
    MessageTypeOther = 1
}MessageType;

@interface ZCMessage : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;

@property (nonatomic, assign) CGFloat cellHeight;


@property (nonatomic, assign,getter=isHideTime) BOOL hideTime;


+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end
