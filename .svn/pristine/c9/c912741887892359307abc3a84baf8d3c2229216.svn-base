//
//  LK_API.h
//  ffcsdemo
//
//  Created by hesh on 13-9-12.
//  Copyright (c) 2013年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LK_HttpRequest.h"
#import "LK_HttpResponse.h"


@interface LK_APIUtil : NSObject

+(void)postHttpRequest:(LK_HttpBaseRequest *)request apiPath:(NSString *)path Success:(void (^)(LK_HttpBaseResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail class:(Class)responseClass;


+(void)getHttpRequest:(LK_HttpBaseRequest *)request apiPath:(NSString *)path Success:(void (^)(LK_HttpBaseResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *))fail class:(Class)responseClass;

//+(void)getHttpRequest:(LK_HttpBaseRequest *)request basePath:(NSString *)basePath apiPath:(NSString *)path Success:(void (^)(LK_HttpBaseResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail class:(Class)responseClass;
//
//+(void)cancelAllHttpRequestByApiPath:(NSString *)path;
//
//+(void)uploadFile:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType ProgressBlock:(void(^)(NSInteger bytesWritten, long long totalBytesWritten))progressblock successBlock:(void(^)(NSString *filepath))success errorBlock:(void(^)(BOOL NotReachable))errorBlock;
//
//+(void)getHttpRequestVersion:(LK_HttpBaseRequest *)request apiPath:(NSString *)path Success:(void (^)(LK_HttpVersionResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *))fail class:(Class)responseClass;
//
//// 加密接口
//+(void)getHttpRequest:(LK_HttpBaseRequest *)request
//              apiPath:(NSString *)path
//         encryptedKey:(NSString *)encryptedKey
//              Success:(void (^)(LK_HttpBaseResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail class:(Class)responseClass;
//// 空数据接口
//+(void)getHttpRequestNoData:(LK_HttpBaseRequest *)request apiPath:(NSString *)path Success:(void (^)(LK_HttpBaseResponse *))sucess fail:(void (^)(BOOL NotReachable,NSString *descript))fail class:(Class)responseClass;
@end
