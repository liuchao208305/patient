//
//  SearchViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initRecognizer{
    
}

@end
