//
//  DiscoveryViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/6.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "shareValue.h"


@interface DiscoveryViewController ()<UIScrollViewDelegate>
{
    BOOL isAutoPlay;
    NSTimer * timer;
}
@property(nonatomic,strong)UIImageView* imv;
@property (weak, nonatomic) IBOutlet UILabel *adTitle;
@property (weak, nonatomic) IBOutlet UILabel *adContent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (nonatomic,strong) UIPageControl* pageControl;
@property (nonatomic,strong) NSArray* lists;
@property (nonatomic,strong) NSMutableArray* images;
@property (nonatomic,strong) NSMutableArray* totalContents;
@property (nonatomic,strong) NSMutableArray* contents;
@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isAutoPlay=YES;
    self.labelView.layer.cornerRadius=3;
    [self checkPiidState];
    [self loadAdvertisingImage];
    self.title=@"发现";
    self.view.backgroundColor=[UIColor lightGrayColor];
    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
}

-(NSMutableArray *)images{
    if (!_images) {
        _images=[NSMutableArray array];
    }
    return _images;
}
-(NSMutableArray *)totalContents{
    if (!_totalContents) {
        _totalContents=[NSMutableArray array];
    }
    return _totalContents;
}
-(NSMutableArray *)contents{
    if (!_contents) {
        _contents=[NSMutableArray array];
    }
    return _contents;
}
-(void)initViewAndLoadImages{
    //config scrollView
     self.scrollView.bounces = NO;
     self.scrollView.pagingEnabled = YES;
     self.scrollView.delegate = self;
     self.scrollView.userInteractionEnabled = YES;
     self.scrollView.showsHorizontalScrollIndicator = NO;
     self.scrollView.showsVerticalScrollIndicator=NO;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width * ([self.images count] + 2), self.scrollView.frame.size.height)];
    //config pageControl
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
    self.pageControl.currentPage=0;
    self.pageControl.numberOfPages=self.images.count;
    self.pageControl.userInteractionEnabled=NO;
    CGSize newSize=self.pageControl.frame.size;
    newSize=CGSizeMake(self.scrollView.frame.size.width, 20);
    CGRect frame=CGRectMake(0, 0, newSize.width, newSize.height);
    self.pageControl.frame=frame;
    self.pageControl.center=CGPointMake(self.scrollView.center.x, self.scrollView.frame.size.height+self.scrollView.frame.origin.y-10);
    [self.view insertSubview:self.pageControl aboveSubview:self.scrollView];
    //config logic
    for (int i = 0;i<[self.images count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:i]];
        imageView.frame = CGRectMake(self.scrollView.frame.size.width * (i +1) , 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        imageView.userInteractionEnabled=YES;
        imageView.tag=i;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showWebView:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:self.images.count-1]];
    imageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
     imageView.userInteractionEnabled=YES;
    imageView.tag=self.images.count-1;
    UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showWebView:)];
    [imageView addGestureRecognizer:tap1];
    [self.scrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:0]];
    imageView.frame = CGRectMake((self.scrollView.frame.size.width * ([self.images count] + 1)) , 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    imageView.tag=0;
     imageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showWebView:)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    if (isAutoPlay) {
        if (timer==nil) {
            timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        }
    }
}

-(void)showWebView:(UITapGestureRecognizer*) tapGesture{
    
    id obj=tapGesture.view;
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView* iv=(UIImageView*)obj;
            NSDictionary* dic=[self.contents objectAtIndex:iv.tag];
            TempWebViewViewController* vc=[[TempWebViewViewController alloc]init];
            vc.URLString=[NSString stringWithFormat:@"%@?piId=%@&token=%@&channel=1002&versionId=%@",[dic objectForKey:@"href"],[shareValue shareInstance].PIID,[shareValue shareInstance].TOKEN,[shareValue shareInstance].VERSIONID];
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
//    CGFloat pagewidth = self.scrollView.frame.size.width;
//    int page = floor(self.scrollView.contentOffset.x /pagewidth);
//    page --;  // 默认从第二页开始
//    self.pageControl.currentPage = page;
//    NSLog(@"scrollViewDidScroll");
//    CGFloat pagewidth = self.scrollView.frame.size.width;
//    int currentPage = floor(self.scrollView.contentOffset.x /pagewidth);
//    
//    if (currentPage==0)
//    {
//        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * [self.images count],0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
//        self.pageControl.currentPage=self.pageControl.numberOfPages-1;
//    }
//    else if (currentPage==([self.images count]+1))
//    {
//        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
//    }else{
//        self.pageControl.currentPage=currentPage-1;
//    }
//    
//    if (isAutoPlay) {
//        if (timer==nil) {
//            [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
//        }
//    }

}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    [timer invalidate];
//    timer=nil;
    NSLog(@"scrollViewDidEndDecelerating");
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor(self.scrollView.contentOffset.x /pagewidth);

    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * [self.images count],0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
        self.pageControl.currentPage=self.pageControl.numberOfPages-1;
    }
    else if (currentPage==([self.images count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width,0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
    }else{
        self.pageControl.currentPage=currentPage-1;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.adContent.alpha=0.0;
        self.adTitle.alpha=0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.adContent.alpha=1;
            self.adTitle.alpha=1;
            [self loadTitleAndContentAtIndex:self.pageControl.currentPage];
        }];
        
    }];

   
        if (timer==nil) {
            
            timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
        }
  
//    [self runTimePage];
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    unsigned long page = self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width*(page+1),0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
//    if (isAutoPlay) {
        if (timer!=nil) {
            [timer invalidate];
            timer=nil;
        }
//    }
}
// 定时器 绑定的方法
- (void)runTimePage
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor(self.scrollView.contentOffset.x /pagewidth);
    
    if (currentPage==0)
    {
        self.pageControl.currentPage=self.pageControl.numberOfPages-1;
    }
    else if (currentPage==([self.images count]+1))
    {
        self.pageControl.currentPage=0;
    }else{
        self.pageControl.currentPage=currentPage-1;
    }
    __block unsigned long  page = self.pageControl.currentPage; // 获取当前的page
    
    
    [UIView animateWithDuration:0.7 animations:^{
         [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width*(page+2),0,self.scrollView.frame.size.width,self.scrollView.frame.size.height) animated:NO];
       
    } completion:^(BOOL finished) {
        page++;
        if (page==self.pageControl.numberOfPages) {
             [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
            page=0;
        }
        
    }];
    int currentPage2 = floor(self.scrollView.contentOffset.x /pagewidth);
    if (currentPage2==0)
    {
        self.pageControl.currentPage=self.pageControl.numberOfPages-1;
    }
    else if (currentPage2==([self.images count]+1))
    {
        self.pageControl.currentPage=0;
    }else{
        self.pageControl.currentPage=currentPage2-1;
    }
//    [self loadTitleAndContentAtIndex:page];
   [UIView animateWithDuration:0.35 animations:^{
       self.adContent.alpha=0.0;
       self.adTitle.alpha=0.0;
   } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.15 animations:^{
           self.adContent.alpha=1;
           self.adTitle.alpha=1;
           [self loadTitleAndContentAtIndex:page];
       }];
       
   }];
    
}
-(void)loadTitleAndContentAtIndex:(NSInteger) index{
    NSDictionary* list=[self.totalContents objectAtIndex:index];
    self.adTitle.text=[list objectForKey:@"title"];
    self.adContent.text=[list objectForKey:@"remark"];
}

//=============================//
-(void)checkPiidState{
    if ([[shareValue shareInstance].PIID isEqualToString:@""]) {
        [self showShadowView];
        NSArray* items=self.tabBarController.tabBar.items;
        UIBarItem* item_index=[items objectAtIndex:0];
        UIBarItem* item_categorie=[items objectAtIndex:1];
        item_index.enabled=NO;
        item_categorie.enabled=NO;
        self.tabBarController.selectedIndex=2;
    }else{
        NSArray* items=self.tabBarController.tabBar.items;
        for (UIBarItem* item in items) {
            item.enabled=YES;
        }
    }
}
-(void)showShadowView{
    self.imv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.imv.image=[UIImage imageNamed:@"mask.png"];
    self.imv.userInteractionEnabled=YES;
    [self.view.window addSubview:self.imv];
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeImv)];
    [self.imv addGestureRecognizer:tap];
}
-(void)removeImv{
    self.imv.hidden=YES;
    [self.imv removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    [self checkPiidState];
}
- (IBAction)aroundHPHAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"around" sender:nil];
}
- (IBAction)showScanQRCodeView:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"scanQR" sender:nil];
}
- (IBAction)showShakeView:(id)sender {
}
- (IBAction)discountActivityAction:(id)sender {
    self.tabBarController.tabBar.hidden=YES;
    [self performSegueWithIdentifier:@"discount" sender:nil];
}
-(void)loadAdvertisingImage{
    self.totalContents=nil;
    self.totalContents=[NSMutableArray array];
    [MBProgressHUD showHUDAddedTo:self.scrollView animated:YES];
    AdvertisingContentRequest* request=[[AdvertisingContentRequest alloc]init];
    [SystemAPI AdvertisingContentRequest:request success:^(AdvertisingContentResponse *response) {
        NSLog(@"%@",response.list);
        self.lists=response.list;
        if (self.lists.count>0) {
            for (NSDictionary* adList in self.lists) {
                UIImage* image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[adList objectForKey:@"url"]]]];
                if (image) {
                    [self.images addObject:image];
                    [self.contents addObject:adList];
                    [self.totalContents addObject:adList];
                }
               
            }
            [self.totalContents insertObject:[self.contents lastObject] atIndex:0];
            [self.totalContents addObject:[self.contents firstObject]];
        }
        
        if (self.images.count>0) {
            [self initViewAndLoadImages];
            [self loadTitleAndContentAtIndex:1];
        }
        [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
    } fail:^(BOOL notReachable, NSString *desciption) {
        [MBProgressHUD showError:desciption toView:self.scrollView];
        [MBProgressHUD hideAllHUDsForView:self.scrollView animated:YES];
    }];
}
@end
