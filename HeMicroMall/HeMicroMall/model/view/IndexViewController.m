//
//  IndexViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "IndexViewController.h"
#import "shareValue.h"



#define NAVIGATION_HEIGHT 64
@interface IndexViewController ()
@property(nonatomic,strong)WKWebView* indexWeb;
@property(nonatomic,strong)UIProgressView* progressView;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self createWebView];
    //test
    
}
-(void)initView{
    
    UIButton *backItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backItem setImage:[UIImage imageNamed:@"scan_2dimensional_code.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(showScanQRCodeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem=leftItem;
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
}

-(void)createWebView{
    
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_INDEX] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    NSLog(@"URL_INDEX:%@",URL_INDEX);
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }
    if(self.webView) {
        self.navigationItem.title = self.webView.title;
    }
    else if(self.uiWebView) {
        self.navigationItem.title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }

}

-(void)viewWillAppear:(BOOL)animated{
   
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_INDEX] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
    }
    self.tabBarController.tabBar.hidden=NO;
    if ([[shareValue shareInstance].PIID isEqualToString:@""]) {
        self.tabBarController.selectedIndex=2;
    }
    if(self.webView) {
        self.navigationItem.title = self.webView.title;
    }
    else if(self.uiWebView) {
        self.navigationItem.title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }

}
-(void)showScanQRCodeView{
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"scanQR" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
