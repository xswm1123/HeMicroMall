//
//  SystemHttpRequest.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LK_HttpRequest.h"
//短信验证
@interface GetCheckMessageRequest : LK_HttpBaseRequest
@property(nonatomic,strong) NSString* phoneNum;
@property(nonatomic,assign) NSUInteger channel;
@end
//注册
@interface RegisterRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger channel;

@end
//登陆
@interface LoginRequest : LK_HttpBaseRequest
@property(nonatomic,strong) NSString* accNbr;//用户名
@property(nonatomic,strong) NSString*  password;//密码
@property(nonatomic,assign) NSUInteger loginType;
@property(nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString *clientIP;
@property(nonatomic,strong) NSString* productNum;


@end
//登陆扫描绑定
@interface LoginAndScanQRCodeRequest : LK_HttpBaseRequest
@property(nonatomic,assign)NSUInteger storeid;
@property(nonatomic,assign)NSUInteger isBindChannel;
@property(nonatomic,strong) NSString* token;
@property(nonatomic,assign) NSUInteger channel;

@end
//版本升级
@interface UpdateNewVersionRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger downloadChannel;

@end
//意见反馈
@interface GiveAdvicesRequest : LK_HttpBaseRequest
@property(nonatomic,strong) NSString* token;
@property(nonatomic,strong) NSString * content;
@property(nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString* linkphone;//可为空

@end
//个人中心查询
@interface UserCenterRequest : LK_HttpBaseRequest
@property(nonatomic,strong) NSString* token;

@end
//广告查询
@interface AdvertisingContentRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger channel;
//@property (nonatomic,strong) NSString * piId;
@property (nonatomic,strong) NSString * busCode;
@end
//分享内容查询
@interface ShareContentRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString * piId;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * contentType;
@property (nonatomic,strong) NSString* versionid;
@end
//启动页面广告查询
@interface LaunchAdsContentRequest : LK_HttpBaseRequest
@property(nonatomic,strong) NSString* spaceCode;
@property (nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString * piId;
@property (nonatomic,strong) NSString* versionid;
@end
//获取个人中心菜单
@interface GetCutomerCenterMenusRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString * piId;
@property (nonatomic,strong) NSString* versionid;
@end
//提交个推CID
@interface SubmmitGetuiCIDRequest : LK_HttpBaseRequest
@property (nonatomic,assign) NSUInteger channel;
@property(nonatomic,strong) NSString* devicetoken;
@property (nonatomic,strong) NSString * piId;
@property (nonatomic,strong) NSString* versionid;
@property (nonatomic,strong) NSString* cid;
@property (nonatomic,strong) NSString* cid_type;
@property (nonatomic,strong) NSString* token;
@end