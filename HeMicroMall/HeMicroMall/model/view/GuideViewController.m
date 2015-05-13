//
//  GuideViewController.m
//  HeMicroMall
//
//  Created by NewDoone on 15/2/10.
//  Copyright (c) 2015年 NewDoone. All rights reserved.
//

#import "GuideViewController.h"
#import "ServerConfig.h"
#import "AppDelegate.h"
#import "shareValue.h"

@interface GuideViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic)UIImageView* imageView;
@property(strong,nonatomic)UIPageControl* pageControl;
@property(nonatomic,strong)NSMutableArray* imageViews;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.bounces=NO;
    self.imageViews  =[NSMutableArray array];
    NSArray* images_arr=@[@"sc_01.png",@"sc_02.png",@"sc_03.png"];
    self.scrollView.contentMode=UIControlContentHorizontalAlignmentLeft;
    for (int i=0; i<[images_arr count]; i++) {
        _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[images_arr  objectAtIndex:i ]]];
        CGRect frame=_imageView.frame;
        frame.size=[[UIScreen mainScreen] bounds].size ;
        frame.origin.x=i*frame.size.width;
        _imageView.frame=frame;
        [self.imageViews addObject:_imageView];
        [self.scrollView addSubview:self.imageViews[i]];
        if (i==[images_arr count]-1) {
            UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];//增加一个隐形的button
           
            //适配button位置
            button.frame=CGRectMake(self.view.frame.size.width*i+20, [[UIScreen mainScreen] bounds].size.height-200, [[UIScreen mainScreen] bounds].size.width-40, 180);
            [self.scrollView addSubview:button];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        }
    }

    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.pagingEnabled=YES;//一页一页的翻，生效的条件是，内容的大小是frame大小的整数倍
    self.scrollView.delegate=self;
    _pageControl=[[UIPageControl alloc]init];
    _pageControl.numberOfPages=[self.imageViews count];
    _pageControl.currentPage=0;
//    [self.view addSubview:_pageControl];
}
-(void)viewDidLayoutSubviews{
    //在这里适配屏幕
    //适配scrollView
    self.scrollView.frame=[[UIScreen mainScreen] bounds];
    //适配pageControl
    CGRect frame= CGRectZero;
    frame.size.height=20;
    frame.size.width=self.view.frame.size.width;
    frame.origin.x=0;
    frame.origin.y=self.view.bounds.size.height-20-frame.size.height;
    _pageControl.frame=frame;
    _pageControl.userInteractionEnabled=NO;
    //适配scrollView的contentSize
    CGSize size =self.scrollView.frame.size;
    size.width *=[self.imageViews count];
    size.height=self.view.bounds.size.height;
    self.scrollView.contentSize=size;
}
-(void)tap:(id)sender
{
//    [ShareAppDelegate showLoginViewController];
    if ([shareValue shareInstance].TOKEN) {
        UIStoryboard* sb=[UIStoryboard storyboardWithName:@"index" bundle:nil];
        UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"index"];
        vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    }
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"login"];
    vc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    _pageControl.currentPage=(offset.x/160+1)/2;
    
}



@end
