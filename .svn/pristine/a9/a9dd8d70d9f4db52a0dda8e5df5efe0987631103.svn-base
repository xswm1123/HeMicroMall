//
//  GetIPAddress.h
//  HeMicroMall
//
//  Created by NewDoone on 15/4/14.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface GetIPAddress : NSObject

- (NSString *)getIPAddress:(BOOL)preferIPv4;
+(GetIPAddress*)shareInstance;
@end
