//
//  MineViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "CommonUtil.h"

@implementation MineViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//    if ([CommonUtil judgeIsLoginSuccess] == NO) {
//        //跳转到登录页面
//        BOOL isLoginSuccess;
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [self presentViewController:navController animated:YES completion:nil];
//        //登录成功之后变更登录状态
//        [CommonUtil changeIsLoginOnce:isLoginSuccess];
//    }
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
}

#pragma mark Init Section
-(void)initNavBar{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
}

-(void)initRecognizer{
    
}

#pragma mark Target Action


@end
