//
//  GuideViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "GuideViewController.h"
#import "AdaptionUtil.h"
#import "BaseTabBarController.h"
#import "AnalyticUtil.h"

@interface GuideViewController()<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;

@end

@implementation GuideViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initGuideView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"GuideViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"GuideViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark initGuideView
-(void)initGuideView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *imageArray = @[@"guideviewFix1",@"guideviewFix2",@"guideviewFix3"];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*imageArray.count, 0);
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i<imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [self.scrollView addSubview:imageView];

        if (i==2) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            //根据设备尺寸适配按钮大小
            if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
                button.frame = CGRectMake(2*SCREEN_WIDTH+((SCREEN_WIDTH-150)/2), SCREEN_HEIGHT -85, 150, 40);
                button.titleLabel.font = [UIFont systemFontOfSize:14];
            }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
                button.frame = CGRectMake(2*SCREEN_WIDTH+((SCREEN_WIDTH-150)/2), SCREEN_HEIGHT-100, 150, 40);
                button.titleLabel.font = [UIFont systemFontOfSize:16];
            }
            [button setTitle:@"马上提问" forState:UIControlStateNormal];
            [button setTitleColor:ColorWithHexRGB(0xfcba1c) forState:UIControlStateNormal];
            button.layer.cornerRadius = 20;
            button.layer.borderWidth = 1;
            button.layer.borderColor = ColorWithHexRGB(0xfcba1c).CGColor;
            [button addTarget:self action:@selector(initRootWindow) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
        }
    }
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-30, 100, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = ColorWithHexRGB(0xfcba1c);
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
}

#pragma mark Target Action
-(void)initRootWindow{
    BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
    [UIApplication sharedApplication].delegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].delegate.window setRootViewController:rootVC];
    [[UIApplication sharedApplication].delegate.window addSubview:rootVC.view];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

@end
