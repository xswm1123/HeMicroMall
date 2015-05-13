//
//  LK_Response.h
//  ffcsdemo
//
//  Created by hesh on 13-9-12.
//  Copyright (c) 2013年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNMessage.h"

@interface LK_HttpBaseResponse : NSObject
@property(nonatomic,strong) BNMessage *MESSAGE;
@property(nonatomic,strong) NSString* retCode;
@property(nonatomic,strong) NSString * retMsg;
@property(nonatomic,strong) NSString * retShowMsg;

@end

@interface LK_HttpVersionResponse : LK_HttpBaseResponse



@end

@interface LK_HttpBasePageResponse : LK_HttpBaseResponse



@end

@interface LK_HttpNewVersionResponse : LK_HttpBaseResponse

@end



