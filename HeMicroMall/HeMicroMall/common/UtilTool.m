//
//  UtilTool.m
//  cplus
//
//  Created by hsyouyou on 13-4-27.
//  Copyright (c) 2013年 parsec. All rights reserved.
//

#import <objc/message.h>
#import "UtilTool.h"
#import "AppDelegate.h"

@implementation UtilTool

/**
* status:3 表示已经从缓存中读取数据；1 表示没有返回的数据 2 表示访问URL成功
*/
+(NSString *)sendUrlRequestByCache:(NSString *)urlString paramValue:(NSString *)paramValue method:(HTTPRequestMethodType) method isReload:(BOOL)reload status:(NSNumber **)status
{

    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [ar objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/fileCache.plist"];
    
    
    
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!jsonDic) {
        jsonDic = [[NSMutableDictionary alloc] init];
    }
    
    NSString *keyString = [NSString stringWithFormat:@"%@%@",urlString,paramValue];
    
    if (!reload) { //从缓存中读取
        if ([jsonDic valueForKey:keyString] && [[jsonDic valueForKey:keyString] length]>0 ) {
            *status = @3; //表示从缓存中取得数据

            return [jsonDic valueForKey:keyString];
        }
    }


    NSString* urlEncoding = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlEncoding] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;

//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
//    request.timeoutInterval = 20;

    if(method == HTTPRequestMethodPost){
        [request setHTTPMethod:@"POST"];
    }else{
        [request setHTTPMethod:@"GET"];
    }

    if (paramValue && [paramValue length]>0) {
        [request setHTTPBody:[paramValue dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    NSHTTPURLResponse *response;
    NSError* error ;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error){
        NSLog(@"====%@",[error localizedDescription]);
    }
    
    if (data==nil) {
        *status = [[NSNumber alloc] initWithInt:1];



        return nil;
    }


    
    if (response.statusCode!=200) {

        *status = [[NSNumber alloc] initWithInt:1];
        return nil;
    }
    
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];



    [jsonDic setValue:jsonString forKey:keyString];
    [jsonDic writeToFile:path atomically:YES];
    
    *status  = [[NSNumber alloc] initWithInt:2];//2表示从服务器中取得数据
    
    return jsonString;
    
}


+ (NSString *)getJSONFromCache:(NSString *)urlString paramValue:(NSString *)paramValue {

    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [ar objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/fileCache.plist"];



    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!jsonDic) {
        jsonDic = [[NSMutableDictionary alloc] init];
    }

    NSString *keyString = [NSString stringWithFormat:@"%@%@",urlString,paramValue];

    if ([jsonDic valueForKey:keyString] && [[jsonDic valueForKey:keyString] length]>0 ) {

            return [jsonDic valueForKey:keyString];
    }

    return nil;
}

+ (void)doRequestWithCallBack:(NSString *)urlString paramValue:(NSString *)paramValue method:(HTTPRequestMethodType)method target:(id)target callBack:(SEL)selector {




    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    request.timeoutInterval = 20;
    if(method == HTTPRequestMethodPost){
        [request setHTTPMethod:@"POST"];
    }else{
        [request setHTTPMethod:@"GET"];
    }

    if (paramValue && [paramValue length]>0) {
        [request setHTTPBody:[paramValue dataUsingEncoding:NSUTF8StringEncoding]];
    }


    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    //    NSLog(urlString);

    if (data==nil) {
        return;
    }


    if (response.statusCode!=200) {
        return;
    }


    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [ar objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/fileCache.plist"];



    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];

    if (!jsonDic) {
        jsonDic = [[NSMutableDictionary alloc] init];
    }

    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *keyString = [NSString stringWithFormat:@"%@%@",urlString,paramValue];

    [jsonDic setValue:jsonString forKey:keyString];
    [jsonDic writeToFile:path atomically:YES];

    //回调一下 不知道为什么iOS8 下报错，我注释掉了这行，就无法完成回调了
//    objc_msgSend(target, selector,jsonString);
    
    if([target respondsToSelector:selector]){
        @try {
            [target performSelector:selector withObject:jsonString];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.description);
        }
      
    }
    

}


+(void)saveJSONStringWithUrl:(NSString *)keyValue JSONString:(NSString *)jsonString{
    
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [ar objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/fileCache.plist"];
    
    
    
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
   
    if (!jsonDic) {
        jsonDic = [[NSMutableDictionary alloc] init];
    }

    [jsonDic setValue:jsonString forKey:keyValue];
    [jsonDic writeToFile:path atomically:YES];
 
}

+(int)getAppVersion
{
    return 20140515;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+(NSDictionary *)getUserDic{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/UserInf.plist"];
//    NSLog(@"===%@",path);
    NSDictionary *userDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!userDic) {
        return nil;
    }
    return userDic;
}

+(NSString *)getToken{
    NSDictionary *dic=[UtilTool getUserDic];
    return [dic objectForKey:@"token"];
}

+(void)removeUserDic{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/UserInf.plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if(fileManager){
        NSError *error;
        [fileManager removeItemAtPath:path error:&error];

    }
}

+(void)saveUserDic:(NSDictionary *)userInf{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/UserInf.plist"];
    
    [userInf writeToFile:path atomically:YES];

}

+(BOOL)saveDictionaryFile:(NSMutableDictionary *)fileDict filename:(NSString *)filename
{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:filename];
    
    return [fileDict writeToFile:path atomically:YES];
}

+(void)removeDictionaryFile:(NSString *)filename
{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:filename];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if(fileManager){
        NSError *error;
        [fileManager removeItemAtPath:path error:&error];
    }
}

+(NSMutableDictionary *)getDictionaryFile:(NSString *)filename
{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:filename];

    NSMutableDictionary *fileDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!fileDict) {
        return [[NSMutableDictionary alloc]init];
    }
    return fileDict;
}




+(NSString *)getHostURL{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"host" ofType:@"plist"];
    NSDictionary *hostDic = [NSDictionary dictionaryWithContentsOfFile:path];
    return [hostDic objectForKey:@"hostUrl"];
}

+(NSDictionary *)getHostDic{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"host" ofType:@"plist"];
    NSDictionary *hostDic = [NSDictionary dictionaryWithContentsOfFile:path];
//    return [hostDic objectForKey:@"postfix"];
    return hostDic;
}

+(NSString *)getRootHostURL{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"host" ofType:@"plist"];
    NSDictionary *hostDic = [NSDictionary dictionaryWithContentsOfFile:path];
    return [hostDic objectForKey:@"rootUrl"];

}



+(NSString *)replaceString:(NSString *)searchStr replaceToString:(NSString *)replaceStr originalString:(NSString *)oldString{
    NSMutableString *oldStringMutable = [NSMutableString stringWithString:oldString];

    NSRange subrange = [oldStringMutable rangeOfString:searchStr];
    while (subrange.location != NSNotFound) {
        [oldStringMutable replaceCharactersInRange:subrange withString:replaceStr];
        subrange = [oldStringMutable rangeOfString:searchStr];
    }

    return [oldStringMutable substringFromIndex:0];
}




+(BOOL)isInteger:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL)isFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+(NSString *)getStringByDate:(NSDate *)date formatString:(NSString *)fs
{
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:fs];
    return [dateformat stringFromDate:date];
}


+(CGRect)returnWindowSize
{
    AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([[UIDevice currentDevice].systemVersion intValue] >= 7) {
        return CGRectMake(0, 0, appDelegate.window.frame.size.width, appDelegate.window.frame.size.height);
    }else
        return CGRectMake(0, 0, appDelegate.window.frame.size.width, appDelegate.window.frame.size.height-20);
    
}

+(UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
//    else
//        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)changeImg:(UIImage *)image max:(float)maxSize{
    if (image.size.width>maxSize || image.size.height>maxSize) {
        CGSize newSize;
        if (image.size.width > image.size.height) {
            newSize = CGSizeMake(maxSize, maxSize * (image.size.height/image.size.width));
        }else{
            newSize = CGSizeMake(maxSize*(image.size.width/image.size.height), maxSize);
        }
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        // End the context
        UIGraphicsEndImageContext();
    }
    return image;
}

+ (void)saveDeviceToken:(NSString *)token {

    
    NSMutableDictionary *deviceDic = [[NSMutableDictionary alloc] init];
    [deviceDic setValue:token forKey:@"token"];
    
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/device.plist"];

    [deviceDic writeToFile:path atomically:YES];

}

+(NSDictionary *)getDeviceToken{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/device.plist"];
    NSDictionary *deviceDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!deviceDic) {
        return nil;
    }
    return deviceDic;
}

+(void)removeDeviceToken{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/device.plist"];
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
}




+ (void)saveMsgTime:(NSString *)time {
    
    
    NSMutableDictionary *timeDic = [[NSMutableDictionary alloc] init];
    [timeDic setValue:time forKey:@"time"];
    
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/time.plist"];
    
    [timeDic writeToFile:path atomically:YES];
    
}

+(NSDictionary *)getMsgTime{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/time.plist"];
    NSDictionary *timeDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!timeDic) {
        return nil;
    }
    return timeDic;
}

+(NSArray *)getAddr{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/addrs.plist"];
    //    NSLog(@"===%@",path);
    NSArray *addrs=[NSMutableArray arrayWithContentsOfFile:path];
    if (!addrs) {
        return nil;
    }
    return addrs;
}

+(void)savePerson:(NSDictionary *)person{
    NSMutableArray *array=(NSMutableArray *)[self getPersons];
    if(array==nil)
        array=[[NSMutableArray alloc]init];
    [array addObject:person];
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/persons.plist"];
    NSLog(@"%@",path);
    [array writeToFile:path atomically:YES];
}

+(NSArray *)getPersons{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/persons.plist"];
    NSArray *persons=[NSMutableArray arrayWithContentsOfFile:path];
    if (!persons) {
        return nil;
    }
    return persons;
}

+(NSArray *)deletePersons:(NSArray *)array{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/persons.plist"];
    NSArray *ps=[NSMutableArray arrayWithContentsOfFile:path];
    
    NSMutableArray *persons=[[NSMutableArray alloc]initWithArray:ps];
    
    for(NSDictionary *dic in array){
        [persons removeObject:dic];
    }
    
    [persons writeToFile:path atomically:YES];
    
    return persons;
}

+(NSString *)savePic:(UIImage *)image{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    
    NSDate *date=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *locationString=[dateformatter stringFromDate:date];
    
    NSString *path=[NSString stringWithFormat:@"%@/%@.png",documentPath,locationString];
    
    [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    return path;
}


+(void)ShowAlertView:(NSString *)title setMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];

}

+(BOOL)validateMobile:(NSString *)phone
{
    NSString *regex = @"^((13[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ( ![predicate evaluateWithObject:phone] ) {
        [UtilTool ShowAlertView:nil setMsg:@"请输入一个正确的电话号码"];
        return NO;
    }else
        return YES;
}

+ (UIFont *)currentSystemFont:(CGFloat)size {
    return [UIFont fontWithName:@"MicrosoftYaHei" size:size];


}

+ (UIDeviceResolution) currentResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
                return UIDevice_iPhoneStandardRes;
            return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
        } else
            return UIDevice_iPhoneStandardRes;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
}


+(NSMutableDictionary *) getMsgReadStatus{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/msgReadStatus.plist"];
    NSMutableDictionary *msgReadDic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!msgReadDic) {
        return nil;
    }
    return msgReadDic;
}


+(void)saveMsgReadStatus:(NSMutableDictionary *)msgStatusDic{
    NSArray *arr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingString:@"/msgReadStatus.plist"];

    [msgStatusDic writeToFile:path atomically:YES];
}


@end
