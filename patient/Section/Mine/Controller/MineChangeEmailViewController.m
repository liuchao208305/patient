//
//  MineChangeEmailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineChangeEmailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"

@interface MineChangeEmailViewController ()

@end

@implementation MineChangeEmailViewController

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
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"MineChangeEmailViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineChangeEmailViewController"];
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
    self.title = @"修改邮箱";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.emailBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
    self.emailBackView.backgroundColor = kWHITE_COLOR;
    [self.view addSubview:self.emailBackView];
    
    self.emailTextField = [[UITextField alloc] init];
    [self.emailBackView addSubview:self.emailTextField];
    
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.emailBackView).offset(12);
        make.trailing.equalTo(self.emailBackView).offset(-12);
        make.top.equalTo(self.emailBackView).offset(0);
        make.bottom.equalTo(self.emailBackView).offset(0);
    }];
    
    [self emailDataFilling];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark Network Request

#pragma mark Data Parse

#pragma mark Data Filling
-(void)emailDataFilling{
    if ([self.emailString isEqualToString:@""]) {
        self.emailTextField.placeholder = @"请输入新的邮箱";
    }else{
        self.emailTextField.text = self.emailString;
    }
}

@end
