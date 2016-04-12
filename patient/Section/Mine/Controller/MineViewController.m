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
#import "MineOrderTableCell.h"
#import "MineRecordTableCell.h"
#import "MineFunctionTableCell.h"

@interface MineViewController ()

@end

@implementation MineViewController

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
    
    if ([CommonUtil judgeIsLoginSuccess] == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
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
    self.navigationController.navigationBar.hidden = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mine_top_background"] forBarMetrics:(UIBarMetricsDefault)];
//    
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_navbar_item_left"] style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.leftBarButtonItem =leftButtonItem;
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
//    
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_navbar_item_right"] style:UIBarButtonItemStylePlain target:self action:nil];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
}

-(void)initView{
    [self initTopView];
    [self initHeadView];
    [self initFootView];
    [self initTableView];
    [self initBottomView];
}

-(void)initTopView{
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 181+20)];
    [self.backImageView setImage:[UIImage imageNamed:@"mine_top_background"]];
    [self.view addSubview:self.backImageView];
    
    UIButton *leftButton = [[UIButton alloc] init];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"mine_navbar_item_left"] forState:UIControlStateNormal];
    [self.backImageView addSubview:leftButton];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backImageView).offset(12);
        make.top.equalTo(self.backImageView).offset(10+20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *rightButton = [[UIButton alloc] init];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"mine_navbar_item_right"] forState:UIControlStateNormal];
    [self.backImageView addSubview:rightButton];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backImageView).offset(-12);
        make.top.equalTo(self.backImageView).offset(10+20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *patientImageView = [[UIImageView alloc] init];
    [patientImageView setImage:[UIImage imageNamed:@"mine_top_patient_image"]];
    [self.backImageView addSubview:patientImageView];
    
    [patientImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImageView).offset(0);
        make.centerY.equalTo(self.backImageView).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *patientLabel = [[UILabel alloc] init];
    patientLabel.textAlignment = NSTextAlignmentCenter;
    patientLabel.textColor = kWHITE_COLOR;
    patientLabel.text = @"艾伦";
    [self.backImageView addSubview:patientLabel];
    
    [patientLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImageView).offset(0);
        make.top.equalTo(patientImageView).offset(80+10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(16);
    }];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 181+20, SCREEN_WIDTH, SCREEN_HEIGHT-181-20) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    
}

-(void)initRecognizer{
    
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 85;
    }else if (indexPath.section == 1){
        return 110;
    }else if (indexPath.section == 2){
        return 161;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        static NSString *cellName = @"MineOrderTableCell";
        MineOrderTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineOrderTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"MineRecordTableCell";
        MineRecordTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineRecordTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"MineFunctionTableCell";
        MineFunctionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[MineFunctionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 0;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        self.orderHeadView = [[OrderHeadView alloc] init];
        return self.orderHeadView;
    }else if (section == 1){
        self.recordHeaderView = [[RecordHeaderView alloc] init];
        return self.recordHeaderView;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld",(long)indexPath.section);
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }
}

#pragma mark Target Action


@end
