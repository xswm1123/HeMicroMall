//
//  FeedBackViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/3/2.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *contactType;
@property (weak, nonatomic) IBOutlet UITextView *feedContentTV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedContentTV.layer.borderColor=[UIColor colorWithRed:219/255.0 green:68/255.0 blue:83/255.0 alpha:1.0].CGColor;
    self.feedContentTV.layer.borderWidth=1.2;
    
}

- (IBAction)submmitAction:(id)sender {
    
    if ([self isNotEmptyField]) {
        self.submitBtn.enabled=NO;
        [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        GiveAdvicesRequest* request=[[GiveAdvicesRequest alloc]init];
        request.content=self.feedContentTV.text;
        request.linkphone=[self.contactType.text    stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [SystemAPI GiveAdvicesMessageRequest:request success:^(GiveAdvicesResponse *response) {
//            NSLog(@"code===%@",response.retCode);
//            NSLog(@"retMsg===%@",response.retMsg);
//            NSLog(@"retShowMsg===%@",response.retShowMsg);
            [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
            [MBProgressHUD showError:@"提交成功！" toView:self.view.window];
            self.submitBtn.enabled=YES;
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(BOOL notReachable, NSString *desciption){
            [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
//             [MBProgressHUD showError:@"提交失败！" toView:self.view.window];
            [MBProgressHUD showError:desciption toView:self.view.window];
             self.submitBtn.enabled=YES;
        }];
    }
    
}
-(BOOL)isNotEmptyField{
    NSString* message=@"内容不能为空！";
    //去空格
    if ([self.feedContentTV.text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        al.tag=1000;
        [al show];
        return NO;
    }else{
        return YES;
    }
}

@end
