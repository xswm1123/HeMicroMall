//
//  UIWebView+JavaScriptAlert.m
//  HeMicroMall
//
//  Created by NewDoone on 15/3/9.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)
static BOOL status = NO;
static BOOL isEnd = NO;

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    al.tag=1005;
    [al show];

    
}

- (NSString *) webView:(UIWebView *)view runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)text initiatedByFrame:(id)frame {
    return @"";
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame {
    UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    al.tag=1002;
    [al show];
    if (IOS7_OR_LATER) {
        while (isEnd == NO) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        }
    }else{
        while (isEnd == NO && al.superview != nil) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
        }
    }
    isEnd = NO;
    return status;
}
                                                                                                
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1002) {
        status=buttonIndex;
        isEnd=YES;
        NSLog(@"22222");
    }
    if (alertView.tag==1005) {
//        UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController* vc=[sb instantiateInitialViewController];
//        [self presentViewController:vc animated:YES completion:nil];
    }

}

@end
