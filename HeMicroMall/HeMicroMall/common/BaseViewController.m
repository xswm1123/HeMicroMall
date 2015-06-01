//
//  BaseViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/16.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()
{
    NSString * tempUrl;
    WKWebViewConfiguration* config;
}
@property WebViewJavascriptBridge* bridge;
@end
static BOOL confirm=NO;
static BOOL isEnd=NO;
static BaseViewController* _bvc;
@implementation BaseViewController
@synthesize m_reloading;
+(BaseViewController *)shareInstance{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        _bvc=[[BaseViewController alloc]init];
    });
    return _bvc;
}
-(void)createNewTempWebViewWithURLRequest:(NSURLRequest *)request{
    TempWebViewViewController* vc=[[TempWebViewViewController alloc]init];
    vc.request=request;
    self.tabBarController.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    
    WKUserContentController* userVC=[[WKUserContentController alloc]init];
    [userVC addScriptMessageHandler:self name:@"api"];
    config=[[WKWebViewConfiguration alloc]init];
    config.selectionGranularity=WKSelectionGranularityDynamic;
    config.userContentController=userVC;
    CGRect frame;
    if (self.tabBarController.tabBar.isHidden) {
        frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+44);
    }else{
        frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    if (IOS8_OR_LATER) {
        self.webView=[[WKWebView alloc]initWithFrame:frame configuration:config];
        self.webView.navigationDelegate=self;
        self.webView.UIDelegate=self;
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }else{
        CGRect uiFrame;
        if (self.tabBarController.tabBar.isHidden) {
            uiFrame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
        }else{
            uiFrame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-108);
        }
            self.uiWebView=[[UIWebView alloc]initWithFrame:uiFrame];
            self.uiWebView.delegate=self;
//        self.uiWebView.delegate=self.bridge;
        [self.uiWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }

}
#pragma 注册JS与OC的交互
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.uiWebView) {
         if (_bridge) { return; }
        [WebViewJavascriptBridge enableLogging];
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.uiWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
            NSString* string=(NSString*)data;
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
                [shareValue shareInstance].TOKEN=@"";
                [self presentViewController:vc animated:YES completion:nil];
            }
            
            if ([actionID isEqualToString:@"2"]) {
                //隐藏头部
                self.navigationController.navigationBarHidden=YES;
                CGRect frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44);
                self.uiWebView.frame=frame;
                if ([self.navigationItem.title isEqualToString:@"收藏的商品"]||[self.navigationItem.title isEqualToString:@"收藏的店铺"]) {
                    self.navigationController.navigationBarHidden=NO;
                    CGRect frame=CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
                    self.uiWebView.frame=frame;
                }
//                if ([self.navigationItem.title isEqualToString:@"购物车"]) {
//                    self.navigationController.navigationBarHidden=NO;
//                    CGRect frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
//                    self.uiWebView.frame=frame;
//                }

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
                [MBProgressHUD showError:piid toView:self.view.window];
            }
            if ([actionID isEqualToString:@"6"]) {
                //返回上级页面
                [self.navigationController popViewControllerAnimated:YES];
            }
            responseCallback(@"");
        }];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"title"]) {
        if ([self.tabBarController.tabBar isHidden]) {
//              self.navigationItem.title=self.webView.title;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma wkwebview_delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"WK网页加载成功！");
    if(self.webView) {
        self.navigationItem.title = self.webView.title;
    }
    else if(self.uiWebView) {
        self.navigationItem.title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
    NSLog(@"WK开始加载网页！");
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];

}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"WK网页加载失败！");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
#pragma alertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (alertView.tag==1002) {
        confirm=buttonIndex;
        isEnd=YES;
    }
    if (alertView.tag==1005) {

    }
    
}
#pragma JS与OC的交互
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message:%@",message.body);
    NSLog(@"name:%@",message.name);
    NSString* string=message.body;
//    NSDictionary* dic=[string objectFromJSONString];
//    NSLog(@"dic_json:%@",dic);
    
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
        [shareValue shareInstance].TOKEN=@"";
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if ([actionID isEqualToString:@"2"]) {
        //隐藏头部
        self.navigationController.navigationBarHidden=YES;
         CGRect frame=CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20);
        self.webView.frame=frame;
        if ([self.navigationItem.title isEqualToString:@"收藏的商品"]||[self.navigationItem.title isEqualToString:@"收藏的店铺"]) {
             self.navigationController.navigationBarHidden=NO;
            CGRect frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+44);
            self.webView.frame=frame;
        }
    }
    
    if ([actionID isEqualToString:@"3"]) {
        //显示alert消息
         NSString* piid=[string_pi substringWithRange:NSMakeRange(1, string_pi.length-3)];
        UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:piid delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        al.tag=1000;
        [al show];
    }
    if ([actionID isEqualToString:@"4"]) {
        NSLog(@"piId_4:%@",piid);
        //"6458"
        NSRange range=[piid rangeOfString:@"\""];
        if (range.length>0) {
            piid=[piid substringWithRange:NSMakeRange(1, piid.length-2)];
        }
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
    if ([actionID isEqualToString:@"7"]) {
        //分享
        [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            ShareContentRequest* request=[[ShareContentRequest alloc]init];
            [SystemAPI ShareContentRequest:request uccess:^(ShareContentResponse *response) {
                NSLog(@"data:%@",response.shareContent);
                
                        [UMSocialSnsService presentSnsIconSheetView:self appKey:UmengAppkey shareText:response.shareContent shareImage:nil
                                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToQzone,UMShareToSina,UMShareToSms,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,nil] delegate:nil];
               
            } fail:^(BOOL notReachable, NSString *desciption) {
                 [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
                [MBProgressHUD showMessag:desciption toView:self.view.window];
            }];
    }
    
}
#pragma UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler{
    NSLog(@"AlertMessage:%@",message);
    UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    al.tag=1005;
    [al show];
    completionHandler(YES);
}
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
#pragma WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"执行了decidePolicyForNavigationAction");
    NSLog(@"actionType====%ld",(long)navigationAction.navigationType);
    if (navigationAction.navigationType==WKNavigationTypeLinkActivated) {
        NSLog(@"click!");
//        NSLog(@"Request===%@",navigationAction.request.URL.absoluteString);
        if (![self.navigationItem.title isEqualToString:@"购物车"]) {
            TempWebViewViewController* vc=[[TempWebViewViewController alloc]init];
            vc.URLString=[NSString stringWithFormat:@"%@&token=%@",navigationAction.request.URL.absoluteString,[shareValue shareInstance].TOKEN];
            self.tabBarController.hidesBottomBarWhenPushed=YES;
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    NSLog(@"didReceiveAuthenticationChallenge");
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);
}
#pragma UIWebView--Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"UI开始加载网页！");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"UI网页加载成功！");
    if(self.webView) {
        self.navigationItem.title = self.webView.title;
    }
    else if(self.uiWebView) {
        self.navigationItem.title = [self.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"UI网页加载失败！");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"navigationType:%ld",(long)navigationType);
    if (navigationType==UIWebViewNavigationTypeLinkClicked) {
        if (![self.navigationItem.title isEqualToString:@"购物车"]) {
            TempWebViewViewController* vc=[[TempWebViewViewController alloc]init];
            vc.URLString=[NSString stringWithFormat:@"%@&token=%@",request.URL.absoluteString,[shareValue shareInstance].TOKEN];
            self.tabBarController.hidesBottomBarWhenPushed=YES;
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
@end
