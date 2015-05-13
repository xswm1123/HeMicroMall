//
//  UtilTool.h
//  通用工具类
//
//  Created by hsyouyou on 13-4-27.
//  Copyright (c) 2013年 parsec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UtilTool : NSObject

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone4Height 460
#define iphone5Height 568
#define TimeOut 15
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define kAppKey @"563281527"

#define weixinAppKey @"wxd930ea5d5a258f4f"
#define weixinkAppSecret @"ee2789c8c3ff28161c221a0066f1810d"
#define weixinkAppReddirectURI @"http://www.doone.com.cn"

#define tencentAppKey @"801213517"
#define tencentkAppSecret @"9819935c0ad171df934d0ffb340a3c2d"
#define tencentkAppReddirectURI @"http://www.doone.com.cn"

#define downloadURL @"http://221.182.47.63:8004/sales-assistant-management/appDownLoad/loadPage"

//
//#define kAppKey @"2446357503"  这是一刻的，用来测试一下
//#define kAppSecret @"adba3dbb9dc16ca6c329d70ab2eeb70c"
//#define kAppReddirectURI @"http://www.parsec.com.cn/io/callback.jsp"

typedef NS_ENUM(NSInteger , HTTPRequestMethodType){
    HTTPRequestMethodPost=0,
    HTTPRequestMethodGet=1
};

enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;

+(UIDeviceResolution) currentResolution;

+(UIColor *)colorWithHexString: (NSString *) hexString;

/**
* 带缓存的http请求，如果reload为NO，则从缓存中取数据
*/
+(NSString *)sendUrlRequestByCache:(NSString *)urlString paramValue:(NSString *)paramValue method:(HTTPRequestMethodType) method isReload:(BOOL)reload status:(NSNumber **)status;

/**
* 从缓存中获得数据
*/
+(NSString *)getJSONFromCache:(NSString *)urlString paramValue:(NSString *)paramValue;

/**
* 执行一个请求，在成功后回调一个方法
* 此函数多用于多线程网络请求
*/
+(void)doRequestWithCallBack:(NSString *)urlString paramValue:(NSString *)paramValue method:(HTTPRequestMethodType)method target:(id)target callBack:(SEL)selector;

/*
 * 手动将json数据放到缓存中去。此缓存系统与网络缓存系统为同一缓存
 */
+(void)saveJSONStringWithUrl:(NSString *)keyValue JSONString:(NSString *)jsonString;

/**
* 获得保存的用户Dictionary
*/
+(NSDictionary *)getUserDic;

/**
 * 获取用户token信息
 */
+(NSString *)getToken;

/**
* 获得当前App版本
*/
+(int)getAppVersion;

/**
* 保存用户Dictionary
*/
+(void)saveUserDic:(NSDictionary *)picInf;

/**
* 删除用户Dictionary
*/
+(void)removeUserDic;


+(NSString *)getHostURL;

+(NSString *)getRootHostURL;

+(NSDictionary *)getHostDic;

/**
 * 保存字典文件，用于少量的数据持久化
 **/
+(BOOL)saveDictionaryFile:(NSMutableDictionary *)fileDict filename:(NSString *)filename;

/**
 * 删除字典文件
 **/
+(void)removeDictionaryFile:(NSString *)filename;

/**
 * 根据文件名获取字典文件
 **/
+(NSMutableDictionary *)getDictionaryFile:(NSString *)filename;

/**
 * 替换字符串的方法，searchStr 要被替换的字符 
 * replaceString 替换为的字符
 * originalString 原来的字符串
 * 例如 searchText = [UtilTool replaceString:@"'" replaceToString:@"" originalString:searchText];  将searchText中所有的单引号替换为空字符串
 **/
+(NSString *)replaceString:(NSString *)searchStr replaceToString:(NSString *)replaceStr originalString:(NSString *)oldString;




/**
 * 判断字符字面量是否是整数
 **/
+(BOOL)isInteger:(NSString *)string;


/**
 * 判断字符字面量是否是FLOAT
 **/
+(BOOL)isFloat:(NSString *)string;


/**
 *将日期格式化成对应的字符串
 */
+(NSString *)getStringByDate:(NSDate *)date formatString:(NSString *)fs;


/**
* 返回手机屏幕大小
*/
+(CGRect)returnWindowSize;

/**
* 截屏代码
*/
+(UIImage*)screenshot;

/**
* 压缩图片
*/

+(UIImage*)changeImg:(UIImage *)image max:(float)maxSize;

/**
*
*/
+(void)saveDeviceToken:(NSString *)token;

+(NSDictionary *)getDeviceToken;

+(void)saveMsgTime:(NSString *)time;

+(NSDictionary *)getMsgTime;

+(void)removeDeviceToken;


+(NSArray *)getAddr;

+(void)savePerson:(NSDictionary *)person;

+(NSArray *)getPersons;

+(NSArray *)deletePersons:(NSArray *)array;

+(NSString *)savePic:(UIImage *)image;

/**
 *弹出警告对话框
 */
+(void)ShowAlertView:(NSString *)title setMsg:(NSString *)msg;

/**
 *判断手机号是否有效
 */
+(BOOL)validateMobile:(NSString *)phone;

//返回当前系统字体
+(UIFont *)currentSystemFont:(CGFloat)size;

+(NSMutableDictionary *) getMsgReadStatus;


+(void)saveMsgReadStatus:(NSMutableDictionary *)msgStatusDic;


@end
