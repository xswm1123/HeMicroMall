//
//  ScanQRCodeViewController.h
//  HeMicroMall
//
//  Created by NewDoone on 15/2/10.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SystemAPI.h"
#import "SystemHttpRequest.h"
#import "SystemHttpResponse.h"
#import "MBProgressHUD+Add.h"

@interface ScanQRCodeViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@end
