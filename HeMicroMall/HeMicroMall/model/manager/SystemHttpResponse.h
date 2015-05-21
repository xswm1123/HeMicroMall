//
//  SystemHttpResponse.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LK_HttpResponse.h"

@interface GetCheckMessageResponse :LK_HttpBaseResponse

@end
@interface RegisterResponse: LK_HttpBaseResponse

@end

@interface  LoginResponse : LK_HttpBaseResponse
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* piId;

@end

@interface LoginAndScanQRCodeResponse : LK_HttpBaseResponse
@property(nonatomic,strong) NSString * piId;

@end

@interface UpdateNewVersionResponse : LK_HttpBaseResponse
@property(nonatomic,assign) NSUInteger versionid;
@property(nonatomic,assign) NSUInteger minVersionid;
@property(nonatomic,strong) NSString  *  url;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString* summary;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* createtime;
@end

@interface GiveAdvicesResponse : LK_HttpBaseResponse


@end

@interface UserCenterResponse : LK_HttpBaseResponse
@property(nonatomic,strong)NSString* username;
@property(nonatomic,assign)NSUInteger num1;//收藏的店铺数量
@property(nonatomic,assign)NSUInteger num2;//收藏的商品数量
@property(nonatomic,assign)NSUInteger num3;//我的足迹数量
@property(nonatomic,assign)NSUInteger num4;//待付款数量
@property(nonatomic,assign)NSUInteger num5;//待发货数量
@property(nonatomic,assign)NSUInteger num6;//待取货数量
@property(nonatomic,assign)NSUInteger num7;//待评分数量
@property(nonatomic,assign)NSUInteger num8;
@property(nonatomic,assign)NSUInteger num9;
@property(nonatomic,assign)NSUInteger num10;
@property(nonatomic,assign)NSUInteger num11;
@property(nonatomic,assign)NSUInteger num12;
@property(nonatomic,assign)NSUInteger num13;
@property(nonatomic,assign)NSUInteger num14;
@property(nonatomic,assign)NSUInteger num15;
@property(nonatomic,assign)NSUInteger num16;
@end
@interface AdvertisingContentResponse : LK_HttpBaseResponse
@property (nonatomic,strong) NSArray * list;
@end
@interface ShareContentResponse : LK_HttpBaseResponse
@property(nonatomic,strong) NSString* shareContent;
@property(nonatomic,strong) NSString * targetUrl;
@end
@interface LaunchAdsContentResponse : LK_HttpBaseResponse
@property(nonatomic,strong) NSDictionary * retObj;
@end
@interface GetCutomerCenterMenusResponse : LK_HttpBaseResponse
@property(nonatomic,strong) NSArray* menuList;

@end
@interface SubmmitGetuiCIDResponse : LK_HttpBaseResponse

@end