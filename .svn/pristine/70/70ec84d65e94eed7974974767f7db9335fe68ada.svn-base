//
//  SystemHttpRequest.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "SystemHttpRequest.h"
#import "shareValue.h"
#import "GetIPAddress.h"

@implementation GetCheckMessageRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        
    }
    return self;
}

@end
@implementation RegisterRequest

@end
@implementation LoginRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _loginType=[[shareValue shareInstance].LOGIN_TYPE integerValue];
        _clientIP=[[GetIPAddress shareInstance] getIPAddress:YES];
        _productNum=[shareValue shareInstance].productNum;
    }
    return self;
}

@end
@implementation LoginAndScanQRCodeRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _token=[shareValue shareInstance].TOKEN;
    }
    return self;
}


@end
@implementation UpdateNewVersionRequest
-(id)init{
    if (self=[super init]) {
        _downloadChannel=1002;
    }
    return self;
}
@end
@implementation GiveAdvicesRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _token=[shareValue shareInstance].TOKEN;
    }
    return self;
}
@end
@implementation UserCenterRequest
-(id)init{
    if (self=[super init]) {
        _token=[shareValue shareInstance].TOKEN;
    }
    return self;
}
@end
@implementation AdvertisingContentRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
//        _piId=[shareValue shareInstance].PIID;
        _busCode=[shareValue shareInstance].CHANNEL;
    }
    return self;
}
@end
@implementation ShareContentRequest
-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
                _piId=[shareValue shareInstance].PIID;
         _token=[shareValue shareInstance].TOKEN;
        _versionid=[shareValue shareInstance].VERSIONID;
    }
    return self;
}
@end
@implementation LaunchAdsContentRequest
-(id)init{
    if (self=[super init]) {
       _spaceCode=@"AD_START_PAGE";
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _piId=[shareValue shareInstance].PIID;
        _token=[shareValue shareInstance].TOKEN;
        _versionid=[shareValue shareInstance].VERSIONID;
    }
    return self;
}

@end
@implementation GetCutomerCenterMenusRequest

-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _piId=[shareValue shareInstance].PIID;
        _token=[shareValue shareInstance].TOKEN;
        _versionid=[shareValue shareInstance].VERSIONID;
    }
    return self;
}

@end
@implementation SubmmitGetuiCIDRequest

-(id)init{
    if (self=[super init]) {
        _channel=[[shareValue shareInstance].CHANNEL integerValue];
        _piId=[shareValue shareInstance].PIID;
        _token=[shareValue shareInstance].TOKEN;
        _devicetoken=[shareValue shareInstance].deviceToken;
        _versionid=[shareValue shareInstance].VERSIONID;
        _cid_type=@"0";
    }
    return self;
}

@end
