//
//  SettingTableViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/10.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "SettingTableViewController.h"
#import "MBProgressHUD+Add.h"
#import "shareValue.h"

@interface SettingTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (nonatomic,assign) CGFloat cacheSize;
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionStateLabel;
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoutBtn.backgroundColor=[UIColor colorWithRed:219/255.0 green:68/255.0 blue:83/255.0 alpha:1.0];
    self.logoutBtn.tintColor=[UIColor colorWithRed:219/255.0 green:68/255.0 blue:83/255.0 alpha:1.0];
    
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.bounces=NO;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    self.cacheSize=[self folderSizeAtPath:cachPath]/1024.0/1024.0;
    self.cacheSizeLabel.text=[NSString stringWithFormat:@"%.2fMB",self.cacheSize];
//    [self autoCheckVersionState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender {
    [shareValue shareInstance].TOKEN=nil;
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc=[sb instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==1) {
        [self performSegueWithIdentifier:@"about" sender:nil];
    }else if (indexPath.section==2&&indexPath.row==1) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self clearCache];
            [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
                       
                       });
    }else if(indexPath.section==2&&indexPath.row==0){
        [self performSegueWithIdentifier:@"blind" sender:nil];
    }else if(indexPath.section==1&&indexPath.row==0){
//        [self checkUpdateState];
        [MBProgressHUD showError:@"该功能正在建设中..." toView:self.view.window];
    }
    else{
        [MBProgressHUD showError:@"该功能正在建设中..." toView:self.view.window];
    }
//    if (indexPath.section==1&&indexPath.row==1) {
//        [self performSegueWithIdentifier:@"about" sender:nil];
//    }
//    if (indexPath.section==2&&indexPath.row==1) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [self clearCache];
//            [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
//            
//        });
//    }
//    if (indexPath.section==2&&indexPath.row==0) {
//        [self performSegueWithIdentifier:@"blind" sender:nil];
//    }else{
//    
//        [MBProgressHUD showError:@"该功能正在建设中..." toView:self.view.window];
//    }

}
-(void)clearCache{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    self.cacheSize=[self folderSizeAtPath:cachPath]/1024.0/1024.0;
    NSLog(@"cacheSize====%lf",self.cacheSize);
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
   
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize=[fileManager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        return folderSize;
    }
    return 0;
}
-(void)clearCacheSuccess{
    self.cacheSizeLabel.text=[NSString stringWithFormat:@"0.0MB"];
    UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"清理成功！" message:[NSString stringWithFormat:@"共清理了%.2fMB缓存。",self.cacheSize] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [al show];
}
-(void)autoCheckVersionState{
    self.versionStateLabel.text=@"正在检测版本更新信息...";
    UpdateNewVersionRequest* request=[[UpdateNewVersionRequest alloc]init];
    [SystemAPI UpdateNewVersionRequest:request success:^(UpdateNewVersionResponse *response) {
        [shareValue shareInstance].updateURL=response.url;
        if (response.minVersionid>[[shareValue shareInstance].VERSIONID integerValue]) {
            self.versionStateLabel.text=@"检测到新版本，点击更新";
        }else if ([[shareValue shareInstance].VERSIONID integerValue]<response.versionid&&response.minVersionid<[[shareValue shareInstance].VERSIONID integerValue]){
            self.versionStateLabel.text=@"检测到新版本，需要强制更新";
        }else{
            self.versionStateLabel.text=@"已是最新版本";
        }
    } fail:^(BOOL notReachable, NSString *desciption) {
    }];
    

}

-(void)checkUpdateState{
    self.versionStateLabel.text=@"正在检测版本更新信息...";
    UpdateNewVersionRequest* request=[[UpdateNewVersionRequest alloc]init];
    [SystemAPI UpdateNewVersionRequest:request success:^(UpdateNewVersionResponse *response) {
        [MBProgressHUD showMessag:@"正在检测更新..." toView:self.view.window];
        [shareValue shareInstance].updateURL=response.url;
        NSString* message=response.summary;
        if (response.minVersionid>[[shareValue shareInstance].VERSIONID integerValue]) {
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"版本需要更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            al.tag=100;
            [al show];
            self.versionStateLabel.text=@"检测到新版本，点击确定更新";
        }else if ([[shareValue shareInstance].VERSIONID integerValue]<response.versionid&&response.minVersionid<[[shareValue shareInstance].VERSIONID integerValue]){
            
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"版本需要更新" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            al.tag=101;
            [al show];
            self.versionStateLabel.text=@"检测到新版本，需要强制更新";
        }else{
            UIAlertView* al=[[UIAlertView alloc]initWithTitle:@"已经是最新版本!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [al show];
            self.versionStateLabel.text=@"已是最新版本";
        }
        
        
        [MBProgressHUD hideAllHUDsForView:self.view.window animated:YES];
    } fail:^(BOOL notReachable, NSString *desciption) {
        [MBProgressHUD showError:desciption toView:self.view.window];
    }];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_UPDATING_APP]];
            [self exitApplication];
        }
        if (buttonIndex==0) {
            exit(0);
        }
    }
    
    if (alertView.tag==101) {
        if (buttonIndex==0) {
            
        }
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_UPDATING_APP]];
            [self exitApplication];
        }
        
    }
    
}
- (void)exitApplication
{
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:0.5f animations:^
     {
         window.alpha = 0;
         window.frame = CGRectMake(CGRectGetWidth(window.frame)/2,CGRectGetHeight(window.frame)/2,1, 1);
     }
                     completion:^(BOOL finished)
     {
         exit(0);
     }];
}
@end
