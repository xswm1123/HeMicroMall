//
//  ViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/4.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "ViewController.h"
#import "SystemAPI.h"
#import "SystemHttpRequest.h"
#import "SystemHttpResponse.h"
#import "shareValue.h"
#import "MBProgressHUD+Add.h"
#import "NSString+Base64.h"
#import "sys/utsname.h" 

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tf_randomNumber;
@property(nonatomic,strong) NSTimer * timer;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UIView *checkView;
@property (weak, nonatomic) IBOutlet UIImageView *numberIV;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@end

@implementation ViewController

static NSUInteger count=30;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"和品会微店测试版";
    self.checkBtn.titleLabel.text=@"获取验证码";
    self.tf_phoneNumber.delegate=self;
    self.tf_randomNumber.delegate=self;
}
//-(void)viewDidLayoutSubviews{
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//    NSLog(@"deviceString:%@",deviceString);
//    
//}

-(BOOL)isRightNumber{
    BOOL isRight = false;
    if (self.tf_phoneNumber.text.length==0) {
         [MBProgressHUD showError:@"手机号码不能为空!" toView:self.view.window];
        isRight=NO;
    }else{
    if (self.tf_phoneNumber.text.length==11) {
        isRight=YES;
    }else{
        [MBProgressHUD showError:@"请输入正确的手机号码!" toView:self.view.window];
        isRight=NO;
    }
    }
    return isRight;
}
-(BOOL)isRightCheckNumber{
    BOOL isRight = true;
    if (self.tf_randomNumber.text.length==0) {
        [MBProgressHUD showError:@"验证码不能为空!" toView:self.view.window];
        isRight=NO;
    }
    
    return isRight;
}
#pragma UITextField_Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    if (textField.text.length>=6&&textField==self.tf_randomNumber) {
        return NO;
    }

    return YES;
}
- (IBAction)getCheckMessage:(id)sender {
    count=30;
    
    BOOL isRight=[self isRightNumber];
    
    if (isRight) {
         self.checkBtn.enabled=NO;
        GetCheckMessageRequest* request=[[GetCheckMessageRequest alloc]init];
//        NSString* number=[self.tf_phoneNumber.text    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        request.phoneNum= self.tf_phoneNumber.text;
        request.channel=1002;
        [SystemAPI getCheckMessageRequest:request success:^(GetCheckMessageResponse *response) {
            NSLog(@"请求成功!!!");
            NSLog(@"MSG=====%@",response.retMsg);
            [MBProgressHUD showSuccess:response.retMsg toView:self.view.window];
            self.checkBtn.enabled=NO;
            self.checkBtn.titleLabel.text=[NSString stringWithFormat:@"获取中(%ld)",(unsigned long)count];
            
            self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTitle) userInfo:nil repeats:YES];
            
        } fail:^(BOOL notReachable, NSString *desciption) {
            NSLog(@"error=====%@",desciption);
            [MBProgressHUD showError:desciption toView:self.view.window];
            [self.timer invalidate];
            self.checkBtn.enabled=YES;
            self.checkBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
            self.checkBtn.titleLabel.text=@"获取验证码";
            NSLog(@"请求失败!!!");
        }];
        
    }
    
}
- (IBAction)loginAction:(id)sender {
    if ([self isRightNumber]&&[self isRightCheckNumber]) {
        LoginRequest* request=[[LoginRequest alloc]init];
        request.accNbr=self.tf_phoneNumber.text;
        //base64编码
        NSData *nsdata = [self.tf_randomNumber.text
                          dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
        request.password=base64Encoded;
        NSLog(@"nmuber===%@",self.tf_randomNumber.text);
        NSLog(@"password===%@",request.password);
        [SystemAPI LoginRequest:request success:^(LoginResponse *response) {
            [shareValue shareInstance].TOKEN=response.token;
            [shareValue shareInstance].PIID=[NSString stringWithFormat:@"%@",response.piId];
            NSLog(@"TOKEN==%@,PIID==%@",[shareValue shareInstance].TOKEN,[shareValue shareInstance].PIID);
            [self showIndexViewController];
            [self.timer invalidate];
        } fail:^(BOOL notReachable, NSString *desciption) {
            NSLog(@"%@",desciption);
             [MBProgressHUD showError:desciption toView:self.view.window];
            [self.timer invalidate];
            self.checkBtn.enabled=YES;
            self.checkBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
            self.checkBtn.titleLabel.text=@"获取验证码";
        }];

    }
}
-(void)showIndexViewController{
    if (![[shareValue shareInstance].PIID isEqualToString:@"0"]) {
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"index" bundle:nil];
        UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"index"];
        vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"index" bundle:nil];
        UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"index"];
        vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        vc.tabBarController.selectedIndex=2;
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}

-(void)changeTitle{
    self.checkBtn.titleLabel.text=[NSString stringWithFormat:@"获取中(%ld)",(unsigned long)count];
    count--;
    if (count==0) {
        [self.timer invalidate];
        self.checkBtn.enabled=YES;
        self.checkBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
        self.checkBtn.titleLabel.text=@"获取验证码";
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.timer invalidate];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardAppear:(NSNotification *)notification
{
    NSLog(@"%@", notification);
    //1. 通过notification的userInfo获取键盘的坐标系信息
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //2. 计算输坐标
    CGRect frame;
    CGFloat distance;
    CGFloat yLocation=0;
    if (keyboardFrame.origin.y<self.checkView.frame.origin.y+self.checkView.frame.size.height) {
        distance=self.checkView.frame.origin.y+self.checkView.frame.size.height-keyboardFrame.origin.y;
        NSLog(@"Distance===%f",distance);
        yLocation=self.view.frame.origin.y-distance;
    }
    frame=CGRectMake(0, yLocation, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //3. 动画地改变坐标
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions options = [userInfo[UIKeyboardAnimationCurveUserInfoKey]unsignedIntegerValue];
    
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        self.view.frame=frame;
    } completion:^(BOOL bl){
        
    }];
}

- (void)keyboardDisappear:(NSNotification *)notification
{
    CGRect frame = self.view.frame;
    frame.origin.y = self.view.bounds.size.height - frame.size.height - self.bottomLayoutGuide.length;
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions options = [userInfo[UIKeyboardAnimationCurveUserInfoKey]unsignedIntegerValue];
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        self.view.frame = frame;
    } completion:nil];
}

@end
