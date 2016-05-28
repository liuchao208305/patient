//
//  MineCustomServiceViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineCustomServiceViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"

@interface MineCustomServiceViewController ()

@end

@implementation MineCustomServiceViewController
#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [AnalyticUtil UMBeginLogPageView:@"MineCustomServiceViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineCustomServiceViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    //    label.text = @"关于我们";
    //    label.textColor = [UIColor whiteColor];
    //    label.font = [UIFont systemFontOfSize:20];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    self.navigationItem.titleView = label;
    self.title=@"联系客服";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.logoImageView = [[UIImageView alloc] init];
    [self.logoImageView setImage:[UIImage imageNamed:@"mine_customservice_logo_image"]];
    [self.view addSubview:self.logoImageView];
    
//    self.hotLineLabel = [[UILabel alloc] init];
//    self.hotLineLabel.numberOfLines = 0;
//    self.hotLineLabel.text = @"咨询热线";
//    self.hotLineLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.hotLineLabel];
//    
//    self.hotLineFixLabel = [[UILabel alloc] init];
//    self.hotLineFixLabel.font = [UIFont systemFontOfSize:22];
//    self.hotLineFixLabel.text = @"400-800-1801";
//    self.hotLineFixLabel.textColor = kLIGHT_GRAY_COLOR;
//    self.hotLineFixLabel.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:self.hotLineFixLabel];
    
    self.hotlineImageView = [[UIImageView alloc] init];
    [self.hotlineImageView setImage:[UIImage imageNamed:@"mine_customservice_hotline_image"]];
    [self.view addSubview:self.hotlineImageView];
    
    self.companyLabel = [[UILabel alloc] init];
    self.companyLabel.text = @"©杭州聪宝科技有限公司";
    self.companyLabel.textColor = kLIGHT_GRAY_COLOR;
    self.companyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.companyLabel];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(45);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
    [self.hotlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView).offset(200+31);
        make.centerX.equalTo(self.logoImageView).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
//    [self.hotLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.logoImageView).offset(200+31);
//        make.leading.equalTo(self.logoImageView).offset(0);
//        make.width.mas_equalTo(50);
//    }];
//    
//    [self.hotLineFixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.logoImageView).offset(0);
//        make.centerY.equalTo(self.hotLineLabel).offset(0);
//        make.width.mas_equalTo(200);
//    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-25);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15);
    }];
}

-(void)initRecognizer{
    self.hotlineImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotlineImageClicked)];
    [self.hotlineImageView addGestureRecognizer:tap];
}

#pragma mark Target Action
-(void)hotlineImageClicked{
    DLog(@"hotlineImageClicked");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-800-1801"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark Network Request

#pragma mark Data Parse

@end
