//
//  CustomerCenterViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "CustomerCenterViewController.h"
#import "SystemAPI.h"
#import "SystemHttpRequest.h"
#import "SystemHttpResponse.h"


@interface CustomerCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray* options;

@end

@implementation CustomerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self requestData];
    [self loadOptionsMenus];
   }

-(void)initView{
    self.phoneNumber.text=@"加载中...";
    self.goods.text=@"0";
    self.stores.text=@"0";
    self.footPrints.text=@"0";
    
    self.title=@"我的";
    self.collectionView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.15];
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];

    self.tableView.bounces=NO;
    
    UIButton *backItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backItem setImage:[UIImage imageNamed:@"title_setting.png"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(showSettingView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    self.navigationItem.leftBarButtonItem=leftItem;
}
-(void)loadOptionsMenus{
    GetCutomerCenterMenusRequest* request=[[GetCutomerCenterMenusRequest alloc]init];
    [SystemAPI GetCutomerCenterMenusRequest:request success:^(GetCutomerCenterMenusResponse *response) {
        self.options=response.menuList;
        [self.tableView reloadData];
    } fail:^(BOOL notReachable, NSString *desciption) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    [self requestData];
}
-(void)showSettingView{
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"setting" sender:nil];
}
- (IBAction)showGoodsAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"collectionGoods" sender:nil];
}

- (IBAction)showStores:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"collectionStores" sender:nil];
}

- (IBAction)showFootPrints:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"footPrints" sender:nil];
}

- (IBAction)showPayMentAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"payment" sender:nil];
    
}
- (IBAction)showReciveAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"receive" sender:nil];
}
- (IBAction)showPickUpAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"pickup" sender:nil];
}
- (IBAction)showCommentAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"comment" sender:nil];
}
- (IBAction)showDeliveryAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"delivery" sender:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* reuseID=@"cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary* dic=[self.options objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* dic=[self.options objectAtIndex:indexPath.row];
    NSString* title=[dic objectForKey:@"title"];
//    NSString* address=[dic objectForKey:@"address"];
    if ([title isEqualToString:@"我的订单"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self performSegueWithIdentifier:@"order" sender:nil];
    }
    if ([title isEqualToString:@"物流查询"]) {
        [MBProgressHUD showError:@"该功能正在建设中..." toView:self.view.window];
    }
    if ([title isEqualToString:@"地址管理"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self performSegueWithIdentifier:@"address" sender:nil];
    }
    if ([title isEqualToString:@"输入邀请码"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self performSegueWithIdentifier:@"input" sender:nil];
    }
    if ([title isEqualToString:@"我的消息"]) {
        [MBProgressHUD showError:@"该功能正在建设中..." toView:self.view.window];
    }
    if ([title isEqualToString:@"意见反馈"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self performSegueWithIdentifier:@"feedback" sender:nil];
    }
}
-(void)requestData{
    UserCenterRequest* request=[[UserCenterRequest alloc]init];
    [SystemAPI UserCenterMessageRequest:request success:^(UserCenterResponse *response) {
        self.phoneNumber.text=response.username;
        self.stores.text=[NSString stringWithFormat:@"%ld",(unsigned long)response.num1];
        self.goods.text=[NSString stringWithFormat:@"%ld",(unsigned long)response.num2];
        self.footPrints.text=[NSString stringWithFormat:@"%ld",(unsigned long)response.num3];
    } fail:^(BOOL notReachable, NSString *desciption) {
        
    }];

}
@end
