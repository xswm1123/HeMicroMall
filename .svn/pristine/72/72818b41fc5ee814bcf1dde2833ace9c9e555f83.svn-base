//
//  AboutHPHViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/12.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "AboutHPHViewController.h"
#import "shareValue.h"

@interface AboutHPHViewController ()

@end

@implementation AboutHPHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *key = (NSString *)kCFBundleVersionKey;
    //加载程序中的info.plist
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    
    self.currentVersion.text=[NSString stringWithFormat:@"For IOS V%@ Build%@",currentVersionCode,[shareValue shareInstance].VERSIONID];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
