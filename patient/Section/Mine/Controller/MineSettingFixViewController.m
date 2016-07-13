//
//  MineSettingFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineSettingFixViewController.h"
#import "AdaptionUtil.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "CommonUtil.h"
#import "AnalyticUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "LoginViewController.h"
#import "AgreementViewController.h"
#import "BaseTabBarController.h"
#import "MineChangePasswordViewController.h"
#import "MineAboutUsViewController.h"
#import "MineCustomServiceViewController.h"
#import "MineSettingOneTableCell.h"
#import "MineSettingTwoTableCell.h"
#import "MinePersonInformationViewController.h"
#import "MineAccoutSecurityViewController.h"
#import "MineNotificationSettingViewController.h"
#import "MineFeedBackViewController.h"

@interface MineSettingFixViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation MineSettingFixViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineSettingFixViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineSettingFixViewController"];
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
    self.title=@"个人设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115+64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    self.logoutButton = [[UIButton alloc] init];
    [self.logoutButton setFont:[UIFont systemFontOfSize:17]];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.logoutButton setBackgroundColor:kMAIN_COLOR];
    [self.logoutButton addTarget:self action:@selector(logoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.footView addSubview:self.logoutButton];
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.footView).offset(20);
        make.trailing.equalTo(self.footView).offset(-20);
        make.height.mas_equalTo(44);
        make.centerY.equalTo(self.footView).offset(0);
    }];
    
    self.tableView.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)logoutButtonClicked{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:kJZK_token];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setRootViewController:rootVC];
        [self.window addSubview:rootVC.view];
        [self.window makeKeyAndVisible];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
//        return 2;
        return 1;
    }else if (section == 2){
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 75;
    }else if (indexPath.section == 1){
        return 45;
    }else if (indexPath.section == 2){
        return 45;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"MineSettingOneTableCell";
        MineSettingOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineSettingOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.personLabel.text = @"个人信息";
        [cell.personImageView sd_setImageWithURL:[NSURL URLWithString:self.personImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"MineSettingTwoTableCell";
        MineSettingTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineSettingTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"账号安全";
            [cell.moreImageView setImage:[UIImage imageNamed:@"mine_setting_more_image"]];
        }
//        else if (indexPath.row == 1){
//            cell.titleLabel.text = @"通知设置";
//            [cell.moreImageView setImage:[UIImage imageNamed:@"mine_setting_more_image"]];
//        }
        
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"MineSettingTwoTableCell";
        MineSettingTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineSettingTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"意见反馈";
            [cell.moreImageView setImage:[UIImage imageNamed:@"mine_setting_more_image"]];
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"联系客服";
            cell.phoneLabel.text = @"400 800 1801";
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"关于我们";
            [cell.moreImageView setImage:[UIImage imageNamed:@"mine_setting_more_image"]];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",indexPath.section);
    if (indexPath.section == 0) {
        MinePersonInformationViewController *minePersonInfoVC = [[MinePersonInformationViewController alloc] init];
        [self.navigationController pushViewController:minePersonInfoVC animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            MineAccoutSecurityViewController *mineAccountSecurityVC = [[MineAccoutSecurityViewController alloc] init];
            [self.navigationController pushViewController:mineAccountSecurityVC animated:YES];
        }
//        else if (indexPath.row == 1){
//            MineNotificationSettingViewController *mineNotificationSettingVC = [[MineNotificationSettingViewController alloc] init];
//            [self.navigationController pushViewController:mineNotificationSettingVC animated:YES];
//        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            MineFeedBackViewController *mineFeedBackVC = [[MineFeedBackViewController alloc] init];
            [self.navigationController pushViewController:mineFeedBackVC animated:YES];
        }else if (indexPath.row == 1){
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-800-1801"];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }else if (indexPath.row == 2){
            MineAboutUsViewController *mineAboutUsVC = [[MineAboutUsViewController alloc] init];
            [self.navigationController pushViewController:mineAboutUsVC animated:YES];
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request

#pragma mark Data Parse

#pragma mark Data Filling

@end
