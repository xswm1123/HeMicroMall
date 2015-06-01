//
//  AppDelegate.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "AppDelegate.h"
#import "SystemAPI.h"
#import "SystemHttpRequest.h"
#import "SystemHttpResponse.h"
#import "shareValue.h"
#import "ServerConfig.h"
#import "GuideViewController.h"
#import "ViewController.h"
#import "RootNavigationController.h"
//#import "MobClick.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"

// production
#define kAppId           @"BnpPPhUpyg9DZWgGR9pqF7"
#define kAppKey          @"Ew5InGPblV8HK328hOnLY"
#define kAppSecret       @"y4uj2XjPCEAVw6b2ATL9H8"


@interface AppDelegate ()<UIAlertViewDelegate>
@property(nonatomic,strong) NSString *versionID;
@property(nonatomic,strong) NSString* lastVersionID;
@property(nonatomic,strong) NSString* updateInfo;
@property (nonatomic) BOOL isFirstRun;
@end

@implementation AppDelegate
@synthesize managerLocate;
@synthesize tabBarController;
@synthesize isFirstRun;
@synthesize geTui;
@synthesize lunchView;
@synthesize imView;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    [self getLocateAuthorization];
    self.lastVersionID=[shareValue shareInstance].VERSIONID;
    [self addThirdPart];
    [self showLoginView];
    [self checkUpdateState];
    [self registerRemoteNotification];
     [self.window makeKeyAndVisible];
    return YES;
}
-(void)loadLanuchImageFromDoc{
    lunchView = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreen" owner:nil options:nil][0];
    lunchView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIImageView *imageV = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString* docPath=[NSString stringWithFormat:@"%@/1.jpg",path];
    NSLog(@"docPath:%@",docPath);
    imageV.image=[UIImage imageWithContentsOfFile:docPath];
    [lunchView addSubview:imageV];
    [self.window addSubview:lunchView];
    [self.window bringSubviewToFront:lunchView];
     [NSThread sleepForTimeInterval:2.0];
}

-(void)loadLaunchImages{
    LaunchAdsContentRequest* request=[[LaunchAdsContentRequest alloc]init];
    [SystemAPI LaunchAdsContentRequest:request success:^(LaunchAdsContentResponse *response) {
        NSLog(@"ADS_response:%@",response.retMsg);
        if ([[shareValue shareInstance].attchId isEqualToString:[response.retObj objectForKey:@"attchId"]]) {
            
        }else{
            NSString* url=[response.retObj objectForKey:@"imgUrl"];
            NSString* str=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
            NSURLSessionConfiguration* config=[NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession * session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
            NSURLSessionDownloadTask* task=[session downloadTaskWithRequest:request];
            [task resume];
            [shareValue shareInstance].attchId=[response.retObj objectForKey:@"attchId"];
        }
      
    } fail:^(BOOL notReachable, NSString *desciption) {
        
    }];
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSFileManager* fm=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString* docPath=[NSString stringWithFormat:@"%@/1.jpg",path];
    NSLog(@"docPathFinished:%@",docPath);
    [fm moveItemAtURL:location toURL:[NSURL fileURLWithPath:docPath] error:nil];
}
-(void)addThirdPart{
    [UMSocialData setAppKey:UmengAppkey];
    //打开调试log的开关
    [UMSocialData openLog:YES];
      //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx01eb9dca4f947de1" appSecret:@"2fbeec6b66c77d9a8077e952d43cb499" url:@"http://sc.10086.cn/api/download2/fxzllxz.html"];
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://sc.10086.cn/api/download2/fxzllxz.html"];
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    geTui=[GexinSdk createSdkWithAppId:kAppId appKey:kAppKey appSecret:kAppSecret appVersion:[shareValue shareInstance].displayVersion delegate:self error:nil];
    
    // [2]:注册APNS
    [self registerRemoteNotification];
    
    // [2-EXT]: 获取启动时收到的APN
    //    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

    
}

-(void)getLocateAuthorization
{
    if (IOS8_OR_LATER && managerLocate==nil)
    {
        managerLocate=[[CLLocationManager alloc]init];
        [managerLocate requestWhenInUseAuthorization];
    }else{
    managerLocate=[[CLLocationManager alloc]init];
    [managerLocate startUpdatingLocation];
    }
}

-(void)checkUpdateState{
    UpdateNewVersionRequest* request=[[UpdateNewVersionRequest alloc]init];
    [SystemAPI UpdateNewVersionRequest:request success:^(UpdateNewVersionResponse *response) {
        NSLog(@"请求成功！");
        NSLog(@"retMsg:%@,versionID:%ld,minVersionID:%lu,updateUrl:%@,appName:%@,description:%@,lastUpdateTime:%@",response.retMsg,(unsigned long)response.versionid,(unsigned long)response.minVersionid,response.url, response.name,response.summary,response.createtime);
        self.updateInfo=response.summary;
        self.versionID=[NSString stringWithFormat:@"%lu",(unsigned long)response.versionid];
        [shareValue shareInstance].updateURL=response.url;
        NSString* message=response.summary;
        if (response.minVersionid>[[shareValue shareInstance].VERSIONID integerValue]) {
            
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"版本需要更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            al.tag=100;
            [al show];
            
        }else if ([[shareValue shareInstance].VERSIONID integerValue]<response.versionid&&response.minVersionid<[[shareValue shareInstance].VERSIONID integerValue]){
           
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"版本需要更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            al.tag=101;
            [al show];
        }

    } fail:^(BOOL notReachable, NSString *desciption) {
         NSLog(@"请求失败！");
        NSLog(@"%@",desciption);
    }];
    
    
}
-(void)downloadFromDoone
{
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nil]];
        [self exitApplication];
    
}
-(void)showLoginView{
    NSString *key = (NSString *)kCFBundleVersionKey;
    //取出上次使用的版本号
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //加载程序中的info.plist
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    [shareValue shareInstance].displayVersion=currentVersionCode;
    NSLog(@"version:%@",[shareValue shareInstance].displayVersion);
    NSLog(@"versionID:%@",[shareValue shareInstance].VERSIONID);
    if ([lastVersionCode isEqualToString:currentVersionCode])
    {
        //非第一次启动
        isFirstRun=NO;
        if ([shareValue shareInstance].TOKEN) {
            UIStoryboard * sb=[UIStoryboard storyboardWithName:@"index" bundle:nil];
            self.window.rootViewController=[sb instantiateInitialViewController];
        }else{
            UIStoryboard* storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.window.rootViewController=[storyBoard instantiateInitialViewController];
        }
        
    }
    else
    {
        //第一次启动
        //保存当前版本号
        isFirstRun=YES;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"guide" bundle:nil];
        self.window.rootViewController=[sb instantiateInitialViewController];
    }
}

-(void)showLoginViewController{
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"login" bundle:nil];
    UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"login"];
    GuideViewController* GC=[[GuideViewController alloc]init];
    [GC presentViewController:vc animated:YES completion:nil];
}

// 退出程序
- (void)exitApplication
{
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:0.5f animations:^
     {
         window.alpha = 0;
         window.frame = CGRectMake(CGRectGetWidth(window.frame)/2,CGRectGetHeight(window.frame)/2,1, 1);
     }
                     completion:^(BOOL finished)
     {
         exit(0);
     }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
    if (buttonIndex==1) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_UPDATING_APP]];
        [self exitApplication];
    }
    if (buttonIndex==0) {
        exit(0);
    }
    }
    
    if (alertView.tag==101) {
        if (buttonIndex==0) {
           
        }
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_UPDATING_APP]];
            [self exitApplication];
        }

    }

}

-(void)hiddenTabBar{
    tabBarController.tabBar.hidden=YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
     [self checkUpdateState];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    [geTui registerDeviceToken:str];
    NSLog(@"str======%@",str);
    NSMutableString *mStr = [[NSMutableString alloc]initWithString:str];
    [mStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mStr length])];
    [mStr replaceOccurrencesOfString:@"<" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mStr length])];
    [mStr replaceOccurrencesOfString:@">" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [mStr length])];
    [shareValue shareInstance].deviceToken=mStr;
}
#pragma  注册远程推送
- (void)registerRemoteNotification
{
    // IOS8
    if(IOS8_OR_LATER)
    {
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
        
    }
    // IOS7与之前版本
    else
    {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *str = [NSString stringWithFormat:@"APNS Error = %@",error];
    NSLog(@"%@",str);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"userInfo:%@",userInfo);
}
#pragma 个推代理
//注册成功后，得到CID
- (void)GexinSdkDidRegisterClient:(NSString *)clientId{
    NSLog(@"Getui clientId:%@",clientId);
    SubmmitGetuiCIDRequest* request=[[SubmmitGetuiCIDRequest alloc]init];
    request.cid=clientId;
    [SystemAPI SubmmitGetuiCIDRequest:request success:^(SubmmitGetuiCIDResponse *response) {
        NSLog(@"response.msg_code:%@",response.retCode);
    } fail:^(BOOL notReachable, NSString *desciption) {
        
    }];
}
//收到消息后
- (void)GexinSdkDidReceivePayload:(NSString *)payloadId fromApplication:(NSString *)appId{
    NSData* data=[geTui retrivePayloadById:payloadId];
    NSString* str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Getui Message:%@",str);
    
    
}
//失败后
- (void)GexinSdkDidOccurError:(NSError *)error{
    NSLog(@"GeTuiError:%@",error);
}
@end
