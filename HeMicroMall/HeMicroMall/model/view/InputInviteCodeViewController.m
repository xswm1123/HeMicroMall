//
//  InputInviteCodeViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/4/9.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "InputInviteCodeViewController.h"

@interface InputInviteCodeViewController ()

@end

@implementation InputInviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIImage *maskImg = [UIImage imageNamed:@"图片填充斜纹"];
//    maskImg = [maskImg resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    
    
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_INPUT_CODE] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_INPUT_CODE] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        
    }
}
@end
