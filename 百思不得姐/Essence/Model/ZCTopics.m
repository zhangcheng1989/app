//
//  ZCTopics.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/3.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCTopics.h"
#import "YYModel.h"
#import "ZCComment.h"
#import "ZCUser.h"
@interface ZCTopics()
{
    CGFloat _cellHeight;
}

@end

@implementation ZCTopics


+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    return @{@"topicId":@"id"};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass
{
    return @{@"top_cmt":[ZCComment class]};
}

- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_create_time];
    if (createDate.isThisYear) {
        if (createDate.isToDay) {
            NSDateComponents *cmp = [[NSDate date]deltaFrom:createDate];
            if (cmp.hour >=1) {
                return [NSString stringWithFormat:@"%li小时前",cmp.minute];
            }else if (cmp.minute>=1){
                return [NSString stringWithFormat:@"%li分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if (createDate.isThisYear){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    }else{
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} context:nil].size.height;
        _cellHeight = TopicCellTextY+textH+TopicCellMargin;
        if (self.type == TopicTypePicture) { //图片帖子
//            if (self.width!=0 && self.height !=0) {
//                <#statements#>
//            }
            //图片宽度
            CGFloat pictureW = [UIScreen mainScreen].bounds.size.width-40;
            //图片高度
            CGFloat pictureH = pictureW*self.height/self.width;
            if (pictureH >= TopicCellPicureMaxH) {
                pictureH = TopicCellPicureBreakH;
                self.bigPicture = YES;
            }
            CGFloat pictureX = TopicCellMargin;
            CGFloat pictureY = TopicCellTextY + textH + TopicCellMargin;
            _pictureFrame = CGRectMake(pictureX,pictureY,pictureW, pictureH);
            _cellHeight += pictureH + TopicCellMargin;
        }else if (self.type == TopicTypeVoice){ //声音帖子
            CGFloat voiceX = TopicCellMargin;
            CGFloat voiceY = TopicCellTextY + textH + TopicCellMargin;
            CGFloat voiceW = [UIScreen mainScreen].bounds.size.width-40;
            CGFloat voiceH = voiceW*self.height/self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + TopicCellMargin;
        }else if (self.type == TopicTypeVideo){ //视频帖子
            CGFloat videoX = TopicCellMargin;
            CGFloat videoY = TopicCellTextY + textH + TopicCellMargin;
            CGFloat videoW = [UIScreen mainScreen].bounds.size.width-40;
            CGFloat videoH = videoW*self.height/self.width;
            _videoFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + TopicCellMargin;
        }
        
        ZCComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
            CGFloat contentH = [content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil].size.height;
            _cellHeight +=  TopicCellTopCmtTitleH + contentH + TopicCellMargin;
        }
        
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
        
    }
    
    return _cellHeight;
   
}

@end
