//
//  CategoriesViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "CategoriesViewController.h"
#import "shareValue.h"


#define NAVIGATION_HEIGHT 64
@interface CategoriesViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backItem setImage:[UIImage imageNamed:@"scan_2dimensional_code.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(showScanQRCodeView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem=leftItem;
    
//    self.title=@"商品分类";
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
    

    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_CATEGORIE] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
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
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:URL_CATEGORIE] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    if (self.webView) {
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }

}
-(void)showScanQRCodeView{
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"scanQR" sender:nil];
}

@end
