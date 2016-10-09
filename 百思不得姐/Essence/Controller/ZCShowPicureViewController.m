//
//  ZCShowPicureViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/6.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCShowPicureViewController.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "ZCProgressView.h"
@interface ZCShowPicureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet ZCProgressView *progressView;
@end

@implementation ZCShowPicureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollerView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = [UIScreen mainScreen].bounds.size.width;
    CGFloat pictureH = pictureW * self.topics.height / self.topics.width;
    if (pictureH > [UIScreen mainScreen].bounds.size.height) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollerView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = [UIScreen mainScreen].bounds.size.height * 0.5;
    }
    
    
    [self.progressView setProgress:self.topics.pictureProgess animated:YES];
    
    [imageView sd_setImageWithURL:self.topics.image1 placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize/ expectedSize;
        self.progressView.hidden = NO;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save {
    
    if (self.imageView.image == nil) {
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showWithStatus:@"保存失败"];
    }
}

@end
