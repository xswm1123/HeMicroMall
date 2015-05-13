//
//  shareValue.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "shareValue.h"
#define SET_PIID @"SET_PIID"
#define SET_TOKEN @"SET_TOKEN"
#define SET_CHANNEL @"SET_CHANNEL"
#define SET_VERSIONID @"SET_VERSIONID"
#define SET_PHONE_NUMBER @"SET_PHONE_NUMBER"
#define SET_LASTUPDATETIME @"SET_LASTUPDATETIME"
#define SET_UPDATEURL @"SET_UPDATEURL"
#define SET_PRODUCTNUMBER @"SET_PRODUCTNUMBER"
#define SET_ATTCHID @"SET_ATTCHID"
#define SET_DEVICETOKEN @"SET_DEVICETOKEN"

static shareValue *_shareValue;

@implementation shareValue
+(shareValue *)shareInstance;{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareValue = [[shareValue alloc]init];
    });
    return _shareValue;
}
-(void)setPIID:(NSString *)PIID{
    if (!PIID) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_PIID];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:PIID forKey:SET_PIID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(NSString *)PIID{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_PIID];
}
-(void)setTOKEN:(NSString *)TOKEN{
    if (!TOKEN) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_TOKEN];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:TOKEN forKey:SET_TOKEN];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)TOKEN{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_TOKEN];
}
-(NSString *)CHANNEL{
    return @"1002";
}
-(void)setVERSIONID:(NSString *)VERSIONID{
    if (!VERSIONID) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_VERSIONID];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:VERSIONID forKey:SET_VERSIONID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)VERSIONID{
//      return [[NSUserDefaults standardUserDefaults]stringForKey:SET_VERSIONID];
    return @"20";
}
-(NSString *)LOGIN_TYPE{
    return @"52";
}
-(void)setPhoneNumber:(NSString *)phoneNumber{
    if (!phoneNumber) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_PHONE_NUMBER];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:phoneNumber forKey:SET_PHONE_NUMBER];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];

}
-(NSString *)phoneNumber{
     return [[NSUserDefaults standardUserDefaults]stringForKey:SET_PHONE_NUMBER];
}
-(void)setLastUpdateTime:(NSString *)lastUpdateTime{
    if (!lastUpdateTime) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_LASTUPDATETIME];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:lastUpdateTime forKey:SET_LASTUPDATETIME];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)lastUpdateTime{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_LASTUPDATETIME];
}
-(void)setUpdateURL:(NSString *)updateURL{
    if (!updateURL) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_UPDATEURL];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:updateURL forKey:SET_UPDATEURL];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)updateURL{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_UPDATEURL];

}
-(void)setProductNum:(NSString *)productNum{
    
}
-(NSString *)productNum{
//    NSString* uid;
//
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:SET_PRODUCTNUMBER
//                                                                       accessGroup:@"com.doone.beeTheOne"];
//    NSString* UUID=[wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)];
//    if (UUID.length==0) {
//        NSString *myUUIDStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        [wrapper setObject:myUUIDStr forKey:(id)CFBridgingRelease(kSecValueData)];
//        uid=myUUIDStr;
//    }else{
//        uid=[wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)];
//    }
//    NSLog(@"uuid====%@",uid);
//  其他的方法
//    NSString *retrieveuuid = [SSKeychain passwordForService:@"com.doone.beeTheOne"account:SET_PRODUCTNUMBER];
//    if (retrieveuuid.length==0) {
//        [SSKeychain setPassword: [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//                     forService:@"com.yourapp.yourcompany"account:SET_PRODUCTNUMBER];
//         uid=[SSKeychain passwordForService:@"com.doone.beeTheOne"account:SET_PRODUCTNUMBER];
//    }else{
//        uid=[SSKeychain passwordForService:@"com.doone.beeTheOne"account:SET_PRODUCTNUMBER];
//    }
//    
//    return uid;
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
-(void)setAttchId:(NSString *)attchId{
    if (!attchId) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_ATTCHID];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:attchId forKey:SET_ATTCHID];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)attchId{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_ATTCHID];
}
-(void)setDeviceToken:(NSString *)deviceToken{
    if (!deviceToken) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:SET_DEVICETOKEN];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:deviceToken forKey:SET_DEVICETOKEN];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)deviceToken{
    return [[NSUserDefaults standardUserDefaults]stringForKey:SET_DEVICETOKEN];
}
@end
