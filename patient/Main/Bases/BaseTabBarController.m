//
//  BaseTabBarController.m
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNaviController.h"
#import "InfoViewController.h"
#import "TestViewController.h"
#import "SearchViewController.h"
#import "MineViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView=[[UIView alloc]initWithFrame:self.view.frame];
    backView.backgroundColor=[UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque=YES;
    self.tabBar.tintColor=[UIColor blackColor];
    
    [self initChildViewControllers];
}

-(void)initChildViewControllers
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    InfoViewController *InfoVC = [[InfoViewController alloc] init];
    [InfoVC.tabBarItem setTitle:@"首页"];
    [InfoVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_info_normal"]];
    [InfoVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_home_selected"]];
    BaseNaviController *InfoNavC = [[BaseNaviController alloc] initWithRootViewController:InfoVC];
    [childVCArray addObject:InfoNavC];
    
    TestViewController *TestVC = [[TestViewController alloc] init];
    [TestVC.tabBarItem setTitle:@"测体质"];
    [TestVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_info_normal"]];
    [TestVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_column_selected"]];
    BaseNaviController *TestNavC = [[BaseNaviController alloc] initWithRootViewController:TestVC];
    [childVCArray addObject:TestNavC];
    
    SearchViewController *SearchVC = [[SearchViewController alloc] init];
    [SearchVC.tabBarItem setTitle:@"搜索"];
    [SearchVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_info_normal"]];
    [SearchVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_live_selected"]];
    BaseNaviController *SearchNavC = [[BaseNaviController alloc] initWithRootViewController:SearchVC];
    [childVCArray addObject:SearchNavC];
    
    MineViewController *MineVC = [[MineViewController alloc] init];
    [MineVC.tabBarItem setTitle:@"我的"];
    [MineVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_info_normal"]];
    [MineVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"btn_user_selected"]];
    BaseNaviController *MineNavC = [[BaseNaviController alloc] initWithRootViewController:MineVC];
    [childVCArray addObject:MineNavC];
    
    [self setViewControllers:childVCArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
