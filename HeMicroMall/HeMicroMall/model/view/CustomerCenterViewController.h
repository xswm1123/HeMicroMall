//
//  CustomerCenterViewController.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BaseViewController.h"
#import "UMSocial.h"
#define UmengAppkey @"55272ee8fd98c5f4db000fab"
@interface CustomerCenterViewController :BaseViewController
@property (weak, nonatomic) IBOutlet UIView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *goods;
@property (weak, nonatomic) IBOutlet UILabel *stores;
@property (weak, nonatomic) IBOutlet UILabel *footPrints;

@end
