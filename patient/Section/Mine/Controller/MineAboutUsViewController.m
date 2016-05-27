//
//  MineAboutUsViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineAboutUsViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"

@interface MineAboutUsViewController ()

@property (strong,nonatomic)NSString *appVersion;

@end

@implementation MineAboutUsViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineAboutUsViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineAboutUsViewController"];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"关于我们";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.logoImageView = [[UIImageView alloc] init];
    [self.logoImageView setImage:[UIImage imageNamed:@"mine_aboutus_logo_image"]];
    [self.view addSubview:self.logoImageView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"就这看国医";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.versionLabel = [[UILabel alloc] init];
    self.versionLabel.text = [NSString stringWithFormat:@"当前版本：%@",self.appVersion];
    self.versionLabel.font = [UIFont systemFontOfSize:11];
    self.versionLabel.textColor = kLIGHT_GRAY_COLOR;
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.versionLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.text = @"“就这看”国医网，国家中医药管理局中医信息化项目。1000多位名老中医、国医大师的独家保健经验；男科、妇科等疑难杂症的中医权威方法；家门口就可看全国名老中医的在线特需服务平台。";
    self.contentLabel.numberOfLines = 0;
    [self.view addSubview:self.contentLabel];
    
    self.hotLineLabel = [[UILabel alloc] init];
    self.hotLineLabel.text = @"咨询热线：400-800-1801";
    self.hotLineLabel.textColor = kMAIN_COLOR;
    self.hotLineLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hotLineLabel];
    
    self.companyLabel = [[UILabel alloc] init];
    self.companyLabel.text = @"©杭州聪宝科技有限公司";
    self.companyLabel.font = [UIFont systemFontOfSize:11];
    self.companyLabel.textColor = kLIGHT_GRAY_COLOR;
    self.companyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.companyLabel];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(34);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(68);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView).offset(68+12);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(16);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel).offset(15+5);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(11);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.versionLabel).offset(11+25);
        make.leading.equalTo(self.view).offset(30);
        make.trailing.equalTo(self.view).offset(-30);
    }];
    
    [self.hotLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.companyLabel).offset(-15-15);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15);
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-34);
        make.centerX.equalTo(self.view).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark Network Request

#pragma mark Data Parse

@end
