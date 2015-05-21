//
//  HPHAroundViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/12.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "HPHAroundViewController.h"
#import "shareValue.h"
#define SCRENN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCRENN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HPHAroundViewController ()<UIAlertViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIWebViewDelegate,CLLocationManagerDelegate>
{
    CGRect frame;
    WKWebView* indexWeb;
    UIView * tipsView;
}
@end
static BOOL confirm=NO;
static BOOL isEnd=NO;
@implementation HPHAroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKUserContentController* userVC=[[WKUserContentController alloc]init];
        [userVC addScriptMessageHandler:self name:@"api"];
    WKWebViewConfiguration* config=[[WKWebViewConfiguration alloc]init];
    config.selectionGranularity=WKSelectionGranularityDynamic;
    config.userContentController=userVC;
     frame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
    if (IOS8_OR_LATER) {
        indexWeb=[[WKWebView alloc]initWithFrame:frame configuration:config];
        indexWeb.navigationDelegate=self;
        indexWeb.UIDelegate=self;
    }else{
//        self.uiWebView.delegate=self;
//        self.uiWebView=[[UIWebView alloc]initWithFrame:frame];
    }
    
    [self startLocation];

    
}
-(void)startLocation{
    self.locationManager=[[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // IOS8
    if (IOS8_OR_LATER)
    {
        if ([CLLocationManager authorizationStatus] < kCLAuthorizationStatusAuthorized)
        {
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"和品会身边需要您打开定位功能，以确保可以定位到身边的店铺" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            al.tag=100;
            [al show];
        }
    }
    // IOS8以前
    else
    {
        if ([CLLocationManager authorizationStatus] < kCLAuthorizationStatusAuthorized)
        {
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"和品会身边需要您前往'设置'-'定位'打开定位功能，以确保可以定位到身边的店铺" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            al.tag=101;
            [al show];
           
            return;
        }
    }
    [self.locationManager startUpdatingLocation];
}
#pragma alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
        }
    }
    if (alertView.tag==1002) {
        confirm=buttonIndex;
        isEnd=YES;
        NSLog(@"22222");
    }
    
}

#pragma CLLocation
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation * location=[locations lastObject];
    if (location.horizontalAccuracy < 200 && location.horizontalAccuracy != -1){
        
        [shareValue shareInstance].currentLocation=location.coordinate;
        NSLog(@"latiude==%f,longtiude===%f",location.coordinate.latitude,location.coordinate.longitude);
        
        NSURL* url;
        if ([[shareValue shareInstance].PIID isEqualToString:@""]) {
            url=[NSURL URLWithString:URL_HPH_AROUND_NO_PIID];
        }else{
            url=[NSURL URLWithString:URL_HPH_AROUND];
            NSLog(@"URL===%@",url);
        }
        NSURLRequest* request=[NSURLRequest requestWithURL:url  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        if (indexWeb) {
            [indexWeb loadRequest:request];
            [self.view addSubview:indexWeb];
        }
        if (self.uiWebView) {
            [self.uiWebView loadRequest:request];
            [self.view addSubview:self.uiWebView];
        }

    } else {
        [self.locationManager stopUpdatingLocation];	 //停止获取
        [NSThread sleepForTimeInterval:0.5]; //阻塞10秒
        [self.locationManager startUpdatingLocation];	//重新获取
    }

    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{

    NSLog(@"failure！~");
     NSURL* url;
    if ([[shareValue shareInstance].PIID isEqualToString:@""]) {
        url=[NSURL URLWithString:URL_HPH_AROUND_NO_PIID_NO_COORDINATE];
    }else{
        url=[NSURL URLWithString:URL_HPH_AROUND_NO_COORDINATE];
    }
    NSURLRequest* request=[NSURLRequest requestWithURL:url  cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        NSLog(@"URSL===%@",url);
    if (indexWeb) {
        [indexWeb loadRequest:request];
        [self.view addSubview:indexWeb];
    }
    if (self.uiWebView) {
        [self.uiWebView loadRequest:request];
        [self.view addSubview:self.uiWebView];
    }

}
#pragma WKWeb Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.locationManager stopUpdatingLocation];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"11111");
    [tipsView removeFromSuperview];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.locationManager stopUpdatingLocation];
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      NSLog(@"22222");
    [tipsView removeFromSuperview];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"LoadWebFailure");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self createTipsView];
}
-(void)reloadWebView{
    [self startLocation];
}
-(void)createTipsView{
    tipsView=[[UIView alloc]initWithFrame:CGRectMake(SCRENN_WIDTH/4, SCRENN_HEIGHT/2, SCRENN_WIDTH/2, 100)];
    tipsView.backgroundColor=[UIColor whiteColor];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, tipsView.frame.size.width, 60)];
    label.text=@"网页加载失败了，点击刷新再试试？";
    label.textAlignment=NSTextAlignmentCenter;
    label.numberOfLines=0;
    label.textColor=[UIColor grayColor];
    [tipsView addSubview:label];
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(tipsView.frame.size.width/4, 60, tipsView.frame.size.width/2, 40)];
    btn.titleLabel.text=@"点击刷新";
    btn.titleLabel.textColor=[UIColor grayColor];
    btn.layer.cornerRadius=3;
    btn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth=1;
    [btn addTarget:self action:@selector(reloadWebView) forControlEvents:UIControlEventTouchUpInside];
    [tipsView addSubview:btn];
    [self.view addSubview:tipsView];
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message:%@",message.body);
    NSLog(@"name:%@",message.name);
    NSString* string=message.body;
    NSDictionary* arrList=[string objectFromJSONString];
    NSLog(@"dic_json:%@",arrList);
    
    NSArray* arr=[string componentsSeparatedByString:@":"];
    NSString* string_pi=[arr lastObject];
    
    NSString* actionID=[string substringWithRange:NSMakeRange(10, 1)];
    NSLog(@"actionID===%@",actionID);
    NSString* piid=[string_pi substringWithRange:NSMakeRange(0, string_pi.length-1)];
    NSLog(@"piid====%@",piid);
    
    if ([actionID isEqualToString:@"1"]) {
        //打开登录界面
        UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController* vc=[sb instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }

    if ([actionID isEqualToString:@"2"]) {
        //隐藏头部
        self.navigationController.navigationBarHidden=YES;
    }

    if ([actionID isEqualToString:@"3"]) {
        //显示alert消息
        NSString* piid=[string_pi substringWithRange:NSMakeRange(1, string_pi.length-3)];
        UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:piid delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        al.tag=1000;
        [al show];

    }

    
    if ([actionID isEqualToString:@"4"]) {
        [shareValue shareInstance].PIID=piid;
    }
    
    if ([actionID isEqualToString:@"5"]) {
        NSString* piid=[string_pi substringWithRange:NSMakeRange(1, string_pi.length-3)];
//        [MBProgressHUD showError:piid toView:self.view.window];
        [MBProgressHUD showSuccess:piid toView:self.view.window];
    }
    if ([actionID isEqualToString:@"6"]) {
        //返回上级页面
        [self.navigationController popViewControllerAnimated:YES];
    }

}
#pragma UIDelegate
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler{
//    NSLog(@"AlertMessage:%@",message);
//}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    NSLog(@"ConfirmMessage:%@",message);
    UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    al.tag=1002;
    [al show];
    if (IOS7_OR_LATER) {
        while (isEnd == NO) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
            }
        }else{
        while (isEnd == NO && al.superview != nil) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
            }
       }
       isEnd = NO;
       completionHandler(confirm);
}
#pragma UIWebView-Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.locationManager stopUpdatingLocation];
    NSLog(@"UI11111");

    NSLog(@"UI开始加载网页！");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [tipsView removeFromSuperview];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"UI网页加载成功！");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.locationManager stopUpdatingLocation];
    NSLog(@"UI22222");
    [tipsView removeFromSuperview];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"UI网页加载失败！");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self createTipsView];
}

@end
