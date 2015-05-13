//
//  ScanQRCodeViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/10.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "ScanQRCodeViewController.h"
#import "QRCodeResultPageViewController.h"
#import "shareValue.h"

@interface ScanQRCodeViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSString * QRContent;
@property(nonatomic,strong) NSString * piid;
@property(nonatomic,strong) NSString* storeID;
@property (weak, nonatomic) IBOutlet UIImageView *cameraIV;
@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCamera];
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(self.cameraIV.frame.origin.x+40, self.cameraIV.frame.origin.y+10, self.cameraIV.frame.size.width-80, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}
-(void)animation
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(self.cameraIV.frame.origin.x+40, self.cameraIV.frame.origin.y+10+2*num, self.cameraIV.frame.size.width-80, 2);
        if (2*num == self.cameraIV.frame.size.height-20) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(self.cameraIV.frame.origin.x+40, self.cameraIV.frame.origin.y+10+2*num, self.cameraIV.frame.size.width-80, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [timer invalidate];
    [_session stopRunning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    [self setupCamera];
    [_session startRunning];
    timer=[NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
//    [timer fire];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    if (![_output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        if (IOS8_OR_LATER) {
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到相机开启，请前往设置中打开此应用的相机权限!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往设置", nil];
            al.tag=500;
            [al show];
        }else{
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"未检测到相机开启，请前往'设置'-'相机'中打开此应用的相机权限!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            al.tag=500;
            [al show];
        }
    }else{
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    }
    //设置扫描区域
//    [_output setRectOfInterest:CGRectMake(self.cameraIV.frame.origin.y/self.view.frame.size.height, self.cameraIV.frame.origin.x/self.view.frame.size.width, self.cameraIV.frame.size.width/self.view.frame.size.height, self.cameraIV.frame.size.height/self.view.frame.size.width)];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.frame;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    [_session stopRunning];
   
//    [timer invalidate];
    NSString *stringValue;
    
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    self.QRContent=stringValue;
    if ([self isValidateWebSite:stringValue]) {
        NSString* saleStr=@"xwshOffermallsale/findOfferMallSaleInfo.shtml";
        NSRange range=[stringValue rangeOfString:saleStr];
        if (range.length>0) {
            self.piid=@"000";
            [self showResultPage];
        }else{
            NSArray* sts=[stringValue componentsSeparatedByString:@"="];
            self.storeID=[sts lastObject];
            NSLog(@"storeID=====%@",self.storeID);
            [self requestPiidAndIsBind:NO];
        }
        

    }else{
        UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前二维码非和品会二维码!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        al.tag=101;
        [al show];
        
    }
    
    
}
//判断是否是正确的二维码地址
-(BOOL)isValidateWebSite:(NSString *)webSite

{
    
    NSString *webSiteRegex = @"^https?://(?:([0-9a-zA-Z-]{1,10}\\.)){1,5}[0-9a-zA-Z-]{1,10}/ishop(?:(/[a-zA-Z]{4,24})){2,3}\\.shtml.{1,1024}$";
    
    NSPredicate *site = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",webSiteRegex];
    
    return [site evaluateWithObject:webSite];
    
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==101) {
            [_session startRunning];
            [timer fire];
    }
    if (alertView.tag==500) {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex==1) {
            if (IOS8_OR_LATER) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
          
        }
       
    }
}

-(void)showResultPage{
    [self performSegueWithIdentifier:@"result" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    QRCodeResultPageViewController* vc=segue.destinationViewController;
    vc.brandUrl=self.QRContent;
    vc.piid=self.piid;
}
-(void)requestPiidAndIsBind:(BOOL)isBind{
    __weak typeof(self) weakSelf=self;
    LoginAndScanQRCodeRequest* request=[[LoginAndScanQRCodeRequest alloc]init];
    if (isBind) {
         request.isBindChannel=1;
    }else{
         request.isBindChannel=0;
    }
    request.storeid=self.storeID.integerValue;
    [SystemAPI LoginAndScanQRCodeRequest:request success:^(LoginAndScanQRCodeResponse *response) {
        if (isBind) {
            [shareValue shareInstance].PIID=[NSString stringWithFormat:@"%ld",(unsigned long)response.piId];
        }
        weakSelf.piid=[NSString stringWithFormat:@"%ld",(unsigned long)response.piId];
        [timer invalidate];
        [self showResultPage];
    } fail:^(BOOL notReachable, NSString *desciption) {
//        [self showResultPage];
        [MBProgressHUD showError:desciption toView:self.view.window];
    }];

}
@end
