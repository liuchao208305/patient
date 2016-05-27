//
//  RecordListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/26.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RecordListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "LoginViewController.h"
#import "RecordListData.h"
#import "RecordListRecordTableCell.h"
#import "RecordListTestTableCell.h"
#import "TestResultDetailViewController.h"
#import "RecordDetailViewController.h"

@interface RecordListViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@end

@implementation RecordListViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"RecordListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendRecordListRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"RecordListViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.recordArray = [NSMutableArray array];
    self.recordIdArray = [NSMutableArray array];
    self.recordIdFixArray = [NSMutableArray array];
    self.recordTimeArray = [NSMutableArray array];
    self.recordExpertNameArray = [NSMutableArray array];
    self.recordExpertImageArray = [NSMutableArray array];
    self.recordDoctorNameArray = [NSMutableArray array];
    self.recordDoctorImageArray = [NSMutableArray array];
    self.recordMoneyArray = [NSMutableArray array];
    self.recordSymptomArray = [NSMutableArray array];
    self.testIdArray = [NSMutableArray array];
    self.testTimeArray = [NSMutableArray array];
    self.testImageArray = [NSMutableArray array];
    self.testMainTizhiArray = [NSMutableArray array];
    self.testTrendTizhiArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"病历本列表";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendRecordListRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendRecordListRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.recordArray.count == 0 ? 0 : self.recordArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.testIdArray[indexPath.section] isEqualToString:@""]) {
        static NSString *cellName = @"RecordListRecordTableCell";
        RecordListRecordTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RecordListRecordTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.label1_1.text = @"就诊订单";
        cell.label1_3.text = [NSString stringWithFormat:@"特需专家：%@",self.recordExpertNameArray[indexPath.section]];
        
        cell.label2_1.text = [self.recordTimeArray[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.recordTimeArray[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.recordTimeArray[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.recordExpertImageArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.recordDoctorImageArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.recordDoctorNameArray[indexPath.section];
        cell.label2_8.text = self.recordMoneyArray[indexPath.section];
        cell.label2_9.text = self.recordSymptomArray[indexPath.section];
        
        return cell;
    }else{
        static NSString *cellName = @"RecordListTestTableCell";
        RecordListTestTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[RecordListTestTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.label1_1.text = @"体质辨识";
        
        cell.label2_1.text = [self.testTimeArray[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.testTimeArray[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.testTimeArray[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.recordExpertImageArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
//        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayEvaluating[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.testMainTizhiArray[indexPath.section];
        cell.label2_8.text = [self.testTrendTizhiArray[indexPath.section] isEqualToString:@""] ? @"暂无" :self.testTrendTizhiArray[indexPath.section];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.testIdArray[indexPath.section] isEqualToString:@""]) {
        
    }else{
        TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
        detailVC.resultId = self.testIdArray[indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendRecordListRequest{
    DLog(@"sendRecordListRequest");
    
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.recordId forKey:@"cast_id"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_RECORD_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_RECORD_LIST_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self recordListDataParse];
        }else{
            DLog(@"%@",self.message);
            if (self.code == kTOKENINVALID) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentViewController:navController animated:YES completion:nil];
            }
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)recordListDataParse{
    self.recordArray = [RecordListData mj_objectArrayWithKeyValuesArray:self.data];
    for (RecordListData *recordListData in self.recordArray) {
        [self.recordIdArray addObject:[NullUtil judgeStringNull:recordListData.cast_b_id]];
        [self.recordIdFixArray addObject:[NullUtil judgeStringNull:recordListData.consult_id]];
        [self.recordTimeArray addObject:[NullUtil judgeStringNull:recordListData.create_date]];
        [self.recordExpertNameArray addObject:[NullUtil judgeStringNull:recordListData.maxDoctorName]];
        [self.recordExpertImageArray addObject:[NullUtil judgeStringNull:recordListData.maxHeandUrl]];
        [self.recordDoctorNameArray addObject:[NullUtil judgeStringNull:recordListData.minDoctorName]];
        [self.recordDoctorImageArray addObject:[NullUtil judgeStringNull:recordListData.minHeandUrl]];
        [self.recordMoneyArray addObject:[NullUtil judgeStringNull:recordListData.price]];
        [self.recordSymptomArray addObject:[NullUtil judgeStringNull:recordListData.symptom_ids]];
        
        [self.testIdArray addObject:[NullUtil judgeStringNull:recordListData.constitution_id]];
        [self.testTimeArray addObject:[NullUtil judgeStringNull:recordListData.create_date]];
//        [self.testImageArray addObject:[NullUtil judgeStringNull:recordListData.maxHeandUrl]];
        [self.testMainTizhiArray addObject:[NullUtil judgeStringNull:recordListData.main_result]];
        [self.testTrendTizhiArray addObject:[NullUtil judgeStringNull:recordListData.trend_result]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
