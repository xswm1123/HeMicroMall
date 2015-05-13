//
//  AppDelegate.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UMSocial.h"
#import "GexinSdk.h"


#define UmengAppkey @"55272ee8fd98c5f4db000fab"

@interface AppDelegate : UIResponder <UIApplicationDelegate,GexinSdkDelegate,NSURLSessionDownloadDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CLLocationManager* managerLocate;
@property(nonatomic,strong) UITabBarController* tabBarController;
@property(nonatomic,strong) GexinSdk* geTui;
@property (strong, nonatomic) UIView *lunchView;
@property (nonatomic,strong) UIImageView* imView;
-(void)showLoginView;
-(void)showLoginViewController;
-(void)hiddenTabBar;
@end

