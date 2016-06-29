//
//  HealthSelfInspectionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthSelfInspectionViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "SelfInspectionTableCell.h"

@interface HealthSelfInspectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@end

@implementation HealthSelfInspectionViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthSelfInspectionViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthSelfInspectionViewController"];
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
    
    self.title = @"健康自查";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 18;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107;
    }else if (indexPath.section == 1){
        return 150;
    }else if (indexPath.section == 2){
        return 110;
    }else if (indexPath.section == 3){
        return 60;
    }else if (indexPath.section == 8){
        return 60;
    }else if (indexPath.section == 9){
        return 60;
    }else if (indexPath.section == 10){
        return 100;
    }else if (indexPath.section == 12){
        return 110;
    }else if (indexPath.section == 13){
        return 60;
    }else if (indexPath.section == 14){
        return 110;
    }else if (indexPath.section == 16){
        return 205;
    }else if (indexPath.section == 17){
        return 210;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 0.01;
    }else if (section == 5){
        return 0.01;
    }else if (section == 6){
        return 0.01;
    }else if (section == 7){
        return 0.01;
    }else if (section == 8){
        return 0.01;
    }else if (section == 9){
        return 0.01;
    }else if (section == 11){
        return 0.01;
    }else if (section == 12){
        return 0.01;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.selfInspectionHeaderView = [[SelfInspectionHeaderView alloc] init];
    if (section == 0) {
        NSString *title = @"主诉";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 1){
        NSString *title = @"睡眠";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 2){
        NSString *title = @"饮食";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 3){
        NSString *title = @"饮水";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"口渴",@"不口渴",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 4){
        NSString *title = @"大便";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content2_1 = @"每天";
        NSString *content2_2 = @"1";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content2_1:content2_1 content2_2:content2_2];
    }else if (section == 5){
        NSString *title = @"便秘";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 6){
        NSString *title = @"泄泻";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 7){
        NSString *title = @"成形";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 8){
        NSString *title = @"便质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 9){
        NSString *title = @"排便感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 10){
        NSString *title = @"大便颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 11){
        NSString *title = @"小便";
        NSString *content1_1 = @"白天";
        NSString *content1_2 = @"1";
        NSString *content2_1 = @"晚上";
        NSString *content2_2 = @"1";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content2_1:content2_1 content2_2:content2_2];
    }else if (section == 12){
        NSString *title = @"色质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 13){
        NSString *title = @"排尿感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 14){
        NSString *title = @"寒热";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 15){
        NSString *title = @"体温";
        NSString *content = @"37";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未测",@"已测",nil];
        [self.selfInspectionHeaderView initView:title content:content array:segmentedArray];
    }else if (section == 16){
        NSString *title = @"出汗";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray];
    }else if (section == 17){
        NSString *title = @"照片资料";
        NSString *titleFix = @"（请在自然光下拍摄哦）";
        [self.selfInspectionHeaderView initView:title titleFix:titleFix];
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SelfInspectionTableCell *cell = [[SelfInspectionTableCell alloc] init];;
        [cell initView];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"SelfInspectionOneTableCell";
        SelfInspectionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }else if (indexPath.section > 1){
        static NSString *cellName = @"SelfInspectionOneTableCell";
        SelfInspectionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark Network Request

#pragma mark Data Parse

@end
