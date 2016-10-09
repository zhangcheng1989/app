//
//  ZCTopics.h
//  百思不得姐
//
//  Created by zhangcheng on 16/9/3.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTopics : NSObject

@property (nonatomic, copy) NSString *bimageuri;
@property (nonatomic, assign) NSInteger bookmark;
@property (nonatomic, assign) NSInteger cache_version;
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger favourite;
@property (nonatomic, assign) NSInteger hate;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *topicId;
@property (nonatomic, assign) NSInteger love;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger original_pid;
@property (nonatomic, copy) NSString *passtime;
@property (nonatomic, copy) NSURL *profile_image;
@property (nonatomic, assign) NSInteger repost;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger t;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger theme_id;
@property (nonatomic, copy) NSString *theme_name;
@property (nonatomic, assign) NSInteger theme_type;
@property (nonatomic, strong) NSArray *themes;
//@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger voicelength;
@property (nonatomic, assign) NSInteger playfcount;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, assign) NSInteger videotime;
@property (nonatomic, copy) NSURL *videouri;
@property (nonatomic, copy) NSString *voiceuri;
@property (nonatomic, copy) NSURL *weixin_url;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) TopicType type;
@property (nonatomic, assign) BOOL is_gif;

@property (nonatomic, strong) NSArray *top_cmt;

/***小图片*/
@property (nonatomic, copy) NSURL *image0;
/***中图片*/
@property (nonatomic, copy) NSURL *image1;
/***大图片*/
@property (nonatomic, copy) NSURL *image2;
@property (nonatomic, copy) NSURL *image_small;

@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;


@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, assign, readonly) CGRect pictureFrame;
@property (nonatomic, assign,getter=isBigPicture) BOOL bigPicture;
@property (nonatomic, assign) CGFloat pictureProgess;


@property (nonatomic, assign, readonly) CGRect voiceFrame;

@property (nonatomic, assign, readonly) CGRect videoFrame;

@end
