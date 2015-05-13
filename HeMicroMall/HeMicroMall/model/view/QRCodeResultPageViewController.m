//
//  QRCodeResultPageViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/13.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "QRCodeResultPageViewController.h"
#import "shareValue.h"

@interface QRCodeResultPageViewController ()

@end

@implementation QRCodeResultPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    NSLog(@"self.piid=%@",self.piid);
}

-(void)createWebView{
    NSString* url;
    
    if ([self.piid isEqualToString:@"000"]) {
        [self setTitle:@"商品详情"];
        url=self.brandUrl;
        NSLog(@"url:%@",url);
    }else{
                url=[NSString stringWithFormat:@"%@api/mobile/store/goShop.action?piId=%@&token=%@&channel=1002&versionId=%@",BASE_SERVERLURL,self.piid,[shareValue shareInstance].TOKEN,[shareValue shareInstance].VERSIONID];
    }
    
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }

}



@end
