//
//  SearchViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SearchViewController.h"
#import "AnalyticUtil.h"

@implementation SearchViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"SearchViewController"];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"SearchViewController"];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    self.title = @"搜索";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    self.tempImageView = [[UIImageView alloc] init];
    self.tempImageView.layer.cornerRadius = 79;
    self.tempImageView.backgroundColor = ColorWithHexRGB(0xfe8787);
    [self.view addSubview:self.tempImageView];
    
    [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(158);
        make.height.mas_equalTo(158);
    }];
    
    self.tempLabel1 = [[UILabel alloc] init];
    self.tempLabel1.font = [UIFont systemFontOfSize:18];
    self.tempLabel1.text = @"此功能暂未运行";
    self.tempLabel1.textColor = kWHITE_COLOR;
    self.tempLabel1.textAlignment = NSTextAlignmentCenter;
    [self.tempImageView addSubview:self.tempLabel1];
    
    self.tempLabel2 = [[UILabel alloc] init];
    self.tempLabel2.font = [UIFont systemFontOfSize:18];
    self.tempLabel2.text = @"敬请期待";
    self.tempLabel2.textColor = kWHITE_COLOR;
    self.tempLabel2.textAlignment = NSTextAlignmentCenter;
    [self.tempImageView addSubview:self.tempLabel2];
    
    [self.tempLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tempImageView).offset(-18);
        make.centerX.equalTo(self.tempImageView).offset(0);
        make.width.mas_equalTo(158);
        make.height.mas_equalTo(18);
    }];
    
    [self.tempLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tempLabel1).offset(18+20);
        make.centerX.equalTo(self.tempImageView).offset(0);
        make.width.mas_equalTo(158);
        make.height.mas_equalTo(18);
    }];
}

-(void)initRecognizer{
    
}

@end
