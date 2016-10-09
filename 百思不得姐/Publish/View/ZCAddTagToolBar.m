//
//  ZCAddTagToolBar.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/23.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCAddTagToolBar.h"
#import "ZCAddTagViewController.h"
@interface ZCAddTagToolBar()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong) NSMutableArray *tagLabels;
@property (nonatomic, weak) UIButton *addButton;
@end

@implementation ZCAddTagToolBar


- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton setImage:[UIImage imageNamed:@"tag_add_iconN"] forState:UIControlStateHighlighted];
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = tagMargin;
    
    [self.topView addSubview:addButton];
    
    self.addButton = addButton;
    
    [self createTags:@[@"吐槽",@"糗事"]];
}


- (void)addButtonClick
{
    ZCAddTagViewController *tagVC = [[ZCAddTagViewController alloc]init];
    tagVC.title = @"添加标签";
    __weak typeof(self) weakSelf = self;
    [tagVC setTagBlock:^(NSArray *tags) {
        [weakSelf createTags:tags];
    }];
    tagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:tagVC animated:YES];
}


- (void)createTags:(NSArray *)tags
{
    
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (NSInteger i= 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc]init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = ZCColor(74, 139, 209);
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14.0];
        tagLabel.textColor = [UIColor whiteColor];
        [tagLabel sizeToFit];
        tagLabel.width += 2 * tagMargin;
        tagLabel.height = 30;
        [self.topView addSubview:tagLabel];
        
        [self setNeedsLayout];
    }
   
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSInteger i= 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        if (i == 0) {// 最前面的标签按钮
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{ //其他标签按钮
            UILabel *lastTagLabel = self.tagLabels[i-1];
            CGFloat leftWith = CGRectGetMaxX(lastTagLabel.frame)+tagMargin; //计算当前行左边宽度
            CGFloat rightWith = self.topView.width - leftWith; //计算当前行右边宽度
            if (rightWith >= tagLabel.width) { //标签按钮显示在当前航
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWith;
            }else{
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame)+tagMargin;
            }
        }
    }
    
    UILabel *lastLabel = [self.tagLabels lastObject];
    CGFloat leftWith = CGRectGetMaxX(lastLabel.frame) + tagMargin;
    //更新textFieldframe
    if (self.topView.width - leftWith >= self.addButton.width) {
        self.addButton.x = leftWith;
        self.addButton.y = lastLabel.y;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame)+tagMargin;
    }
    
    
    //    self.topView.height = CGRectGetMaxY(self.addButton.frame);
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame)+45;
    self.y -=self.height - oldH;
}

@end
