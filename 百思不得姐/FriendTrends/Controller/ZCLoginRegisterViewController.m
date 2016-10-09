//
//  ZCLoginRegisterViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/28.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCLoginRegisterViewController.h"

@interface ZCLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation ZCLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor grayColor];
//    NSAttributedString *placeholder = [[NSAttributedString alloc]initWithString:@"手机号" attributes:dict];
//    self.phoneField.attributedPlaceholder = placeholder;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (IBAction)diss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        sender.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;

    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
