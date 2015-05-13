//
//  BlindAccountViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/3/30.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "BlindAccountViewController.h"

@interface BlindAccountViewController ()

@end

@implementation BlindAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScanBtn];
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_BLIND] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }
    
}
-(void)addScanBtn{
    UIButton *rightItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightItem setImage:[UIImage imageNamed:@"scan_2dimensional_code.png"] forState:UIControlStateNormal];
    [rightItem addTarget:self action:@selector(showScanQRCodeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    self.navigationItem.rightBarButtonItem=right;

}
-(void)showScanQRCodeView{
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"scanQR" sender:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_BLIND] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        
    }
}
@end
