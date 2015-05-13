//
//  DiscountActivityViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/12.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "DiscountActivityViewController.h"
#import "shareValue.h"

@interface DiscountActivityViewController ()

@end

@implementation DiscountActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_DISCOUNT_ACTIVITY] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }


    // Do any additional setup after loading the view.
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
