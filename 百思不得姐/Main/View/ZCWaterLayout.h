//
//  ZCWaterLayout.h
//  百思不得姐
//
//  Created by LPPZ-User02 on 2016/10/4.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCWaterLayout;

@protocol ZCWaterLayoutDelegate <NSObject>

@required

-(CGFloat)waterLayout:(ZCWaterLayout *)waterLayout heightForItemAtIndex:(NSUInteger)index itemWith:(CGFloat)itemWith;

@optional

- (CGFloat)layoutColumnMargin:(ZCWaterLayout *)waterLayout;
- (CGFloat)layoutRowMargin:(ZCWaterLayout *)waterLayout;
- (NSInteger)layoutColumnCount:(ZCWaterLayout *)waterLayout;
- (UIEdgeInsets)layoutEdgeInset:(ZCWaterLayout *)waterLayout;
@end

@interface ZCWaterLayout : UICollectionViewLayout

@property (nonatomic, weak) id<ZCWaterLayoutDelegate> delegate;

@end
