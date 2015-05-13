//
//  SystemAPI.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "SystemAPI.h"
#import "LK_API.h"
#import "ServerConfig.h"

@implementation SystemAPI
+(void)getCheckMessageRequest:(GetCheckMessageRequest *)request success:(void (^)(GetCheckMessageResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_SEND_MESSAGE Success:^(LK_HttpBaseResponse *response) {
        success((GetCheckMessageResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[GetCheckMessageResponse class]];
}
+(void)RegisterRequest:(RegisterRequest *)request success:(void (^)(RegisterResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_REGISTER Success:^(LK_HttpBaseResponse *response) {
        success((RegisterResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[RegisterResponse class]];

}
+(void)LoginRequest:(LoginRequest *)request success:(void (^)(LoginResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_LOGIN Success:^(LK_HttpBaseResponse *response) {
        success((LoginResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[LoginResponse class]];
}
+(void)LoginAndScanQRCodeRequest:(LoginAndScanQRCodeRequest *)request success:(void (^)(LoginAndScanQRCodeResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_LOGIN_SCAN_QRCODE Success:^(LK_HttpBaseResponse *response) {
        success((LoginAndScanQRCodeResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[LoginAndScanQRCodeResponse class]];
}
+(void)UpdateNewVersionRequest:(UpdateNewVersionRequest *)request success:(void (^)(UpdateNewVersionResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_UPDATE_NEW_VERSION Success:^(LK_HttpBaseResponse *response) {
        success((UpdateNewVersionResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[UpdateNewVersionResponse class]];
}
+(void)GiveAdvicesMessageRequest:(GiveAdvicesRequest *)request success:(void (^)(GiveAdvicesResponse *))success fail:(void (^)(BOOL, NSString *))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_GIVE_ADVICES Success:^(LK_HttpBaseResponse *response) {
        success((GiveAdvicesResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[GiveAdvicesResponse class]];
}
+(void)UserCenterMessageRequest:(UserCenterRequest *)request success:(void(^)(UserCenterResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_USER_CENTER Success:^(LK_HttpBaseResponse *response) {
        success((UserCenterResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[UserCenterResponse class]];

}
+(void)AdvertisingContentRequest:(AdvertisingContentRequest *)request success:(void(^)( AdvertisingContentResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_GET_ADS Success:^(LK_HttpBaseResponse *response) {
        success((AdvertisingContentResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[AdvertisingContentResponse class]];
    
}
+(void)ShareContentRequest:(ShareContentRequest*) request uccess:(void(^)(ShareContentResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_GET_SHARE_CONTENT Success:^(LK_HttpBaseResponse *response) {
        success((ShareContentResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[ShareContentResponse class]];
}
+(void)LaunchAdsContentRequest:(LaunchAdsContentRequest*) request success:(void(^)(LaunchAdsContentResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_GET_LAUNCH_ADS Success:^(LK_HttpBaseResponse *response) {
        success((LaunchAdsContentResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[LaunchAdsContentResponse class]];
}
+(void)GetCutomerCenterMenusRequest:(GetCutomerCenterMenusRequest*)request success:(void(^)(GetCutomerCenterMenusResponse* response))success fail:(void(^)(BOOL notReachable,NSString* desciption)) fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_GET_CUSTOMERCENTER_MENUS Success:^(LK_HttpBaseResponse *response) {
        success((GetCutomerCenterMenusResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[GetCutomerCenterMenusResponse class]];
}
+(void)SubmmitGetuiCIDRequest:(SubmmitGetuiCIDRequest*)request success:(void(^)(SubmmitGetuiCIDResponse* response))success fail:(void(^)(BOOL notReachable,NSString* desciption)) fail{
    [LK_APIUtil getHttpRequest:request apiPath:URL_SUBMMIT_CID Success:^(LK_HttpBaseResponse *response) {
        success((SubmmitGetuiCIDResponse *)response);
    } fail:^(BOOL NotReachable, NSString *desciption) {
        fail(NotReachable,desciption);
    } class:[SubmmitGetuiCIDResponse class]];

}
@end
