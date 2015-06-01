//
//  ServerConfig.h
//  ffcsdemo
//
//  Created by hesh on 13-9-12.
//  Copyright (c) 2013年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef fxtx_FXRequestUrl_h
#define fxtx_FXRequestUrl_h

#define DEFINE_SUCCESSCODE @"0"
// 根路径
//测试ID  com.doone.beeTheOne
//发布ID  com.ChinaMobile.HeMircoMall

//测试环境
//#define BASE_SERVERLURL @"http://202.101.116.84/"
//生产环境
#define BASE_SERVERLURL @"http://218.205.252.26:9003/"
//业支测试环境
//#define BASE_SERVERLURL @"http://218.205.252.22/"
//业支预上线环境
//#define BASE_SERVERLURL @"http://218.205.252.26/"


//// 图片上传路径
#define UPLOAD_PIC_URL @"http://202.101.116.77:8082/xsgj_up/"

//从服务器更新APP URL
/*
 https下载
 */
#define URL_UPDATING_APP @"itms-services://?action=download-manifest&url=https://bee.doone.com.cn/client/hphwd.plist"
/*
 http下载
 */
//#define URL_UPDATING_APP @"http://202.101.116.65/api/download/hphBetaV1.0.2.ipa"
//// 图片根路径
//#define IMAGE_PREFIX_URL @"http://202.101.116.77:8082/xsgj_up/photo.shtml?corpId=%d&fileId=%@"


// gmm
#define URL_SEND_MESSAGE @"api/mobile/sms/sendRegisterRandomSms.shtml"//发送短信
#define URL_REGISTER @"api/mobile/register/register.shtml"//注册
#define URL_LOGIN @"api/mobile/login/login.shtml"//登陆
#define URL_LOGIN_SCAN_QRCODE @"api/mobile/bind/bindChannelByPiId.shtml"//登陆扫描绑定
#define URL_UPDATE_NEW_VERSION @"api/mobile/version/selectAppVersionBean.shtml"//更新
#define URL_GIVE_ADVICES @"api/mobile/feedback/feedback.shtml"//意见反馈
#define URL_USER_CENTER @"api/mobile/userCenter/queryUserCenterData.shtml"//个人中心查询
#define URL_GET_ADS @"api/mobile/feedback/getAds.shtml"//广告查询
#define URL_GET_SHARE_CONTENT @"api/mobile/activity/activity4json/getShareContent.shtml"//获取分享内容
#define URL_GET_LAUNCH_ADS @"api/mobile/ad/getAds.shtml"//获取启动页面广告
#define URL_GET_CUSTOMERCENTER_MENUS @"api/mobile/feedback/getCenterMenu.shtml"//获取个人中心菜单
#define URL_SUBMMIT_CID @"api/mobile/getui/bindGeTuiCid.shtml"//绑定推送CID
#define URL_FIND_OFFER_MALL_SALEINFO @"api/mobile/goods/findOfferMallSaleInfo.shtml"//商品详情

#define URL_uploadPhoto @"uploadPhoto.shtml" //照片上传


#define IOS8_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )

#define ShareAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#endif
