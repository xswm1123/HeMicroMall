//
//  HPHAroundViewController.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/12.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import "MBProgressHUD+Add.h"

@interface HPHAroundViewController : BaseViewController
@property(nonatomic,strong)CLLocationManager* locationManager;
@end
