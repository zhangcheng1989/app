//
//  ZCMeFooterView.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/19.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCMeFooterView.h"
#import "ZCHttpApi.h"
#import "ZCSquare.h"
#import "YYModel.h"
#import "ZCSquareButton.h"
#import "ZCWebViewController.h"
@interface ZCMeFooterView()

@end

@implementation ZCMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self loadItem];
        
    }
    return self;
}

- (void)loadItem
{
    NSDictionary *param = @{@"a":@"square",@"c":@"topic"};
    [[ZCHttpApi sharedManager]getPath:@"http://api.budejie.com/api/api_open.php" param:param complection:^(NSURLSessionDataTask *task, NSDictionary *dict, NSError *error) {
        NSArray *squares = [NSArray yy_modelArrayWithClass:[ZCSquare class] json:dict[@"square_list"]];
        [self createSqiares:squares];
    }];
}

- (void)createSqiares:(NSArray *)squares
{
    NSInteger maxCols = 4;
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / maxCols;
    CGFloat buttonH = buttonW;
    
    for (NSInteger i =0; i<squares.count; i++) {
//        ZCSquare *square = squares[i];
        ZCSquareButton *button = [ZCSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        [self addSubview:button];
        
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
//        self.height = CGRectGetMaxY(button.frame);
    }
//    
//    NSInteger rows = squares.count / maxCols;
//    if (squares.count % maxCols) {
//        rows ++;
//    }
//    
    NSInteger rows = (squares.count + maxCols -1) / maxCols;
    
    self.height = rows * buttonH;
    
    [self setNeedsDisplay];
}

- (void)buttonClick:(ZCSquareButton *)btn
{
    if (![btn.square.url.absoluteString hasPrefix:@"http"]) return;
    
    ZCWebViewController *webVC = [[ZCWebViewController alloc]init];
    webVC.url = btn.square.url;
    webVC.title = btn.square.name;
    
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webVC animated:YES];
    
}

@end
