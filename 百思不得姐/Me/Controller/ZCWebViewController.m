//
//  ZCWebViewController.m
//  百思不得姐
//
//  Created by zhangcheng on 16/9/19.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "ZCWebViewController.h"
#import "NJKWebViewProgress.h"
@interface ZCWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwadrdItem;
@property (nonatomic, strong) NJKWebViewProgress *webViewProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webViewProgress = [[NJKWebViewProgress alloc]init];
    self.webView.delegate = self.webViewProgress;
    
    __weak typeof(self) weakSlef = self;
    self.webViewProgress.progressBlock = ^(float progress){
        weakSlef.progressView.progress= progress;
        weakSlef.progressView.hidden = (progress == 1.0);
    };
    
    self.webViewProgress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}


- (IBAction)goForward:(id)sender {
    
    [self.webView goForward];
}

#pragma mark --UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwadrdItem.enabled = webView.canGoForward;
}


@end
