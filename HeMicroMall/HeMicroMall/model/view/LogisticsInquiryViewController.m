//
//  LogisticsInquiryViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/11.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "LogisticsInquiryViewController.h"
#import "shareValue.h"
@interface LogisticsInquiryViewController ()

@end

@implementation LogisticsInquiryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    CGRect frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    
//    WKWebView* indexWeb=[[WKWebView alloc]initWithFrame:frame];
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://202.101.116.65/api/mobile/store/goShop.action?piId=5844&token=82079173C263AA3A0EE7670B5584E79D22A77E8457FC1B7C&channel=1001&versionId=27"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
