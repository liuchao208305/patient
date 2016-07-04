//
//  TestResultListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestResultListViewController.h"
#import "TestResultListTableCell.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "LoginViewController.h"
#import "ResultData.h"
#import "TestResultDetailViewController.h"

@interface TestResultListViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@end

@implementation TestResultListViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"TestResultListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendTestResultListRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"TestResultListViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.resultArray = [NSMutableArray array];
    self.resultPatientIdArray = [NSMutableArray array];
    self.resultPatientImageArray = [NSMutableArray array];
    self.resultIdArray = [NSMutableArray array];
    self.resultMainArray = [NSMutableArray array];
    self.resultTrendArray = [NSMutableArray array];
    self.resultTimeArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"体质测试结果列表";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"体质测试结果列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.resultArray.count==0 ? 0 : self.resultArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 150;
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"TestResultListTableCell";
    TestResultListTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[TestResultListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
//    cell.patientId = self.resultPatientIdArray[indexPath.section];
//    cell.resultId = self.resultIdArray[indexPath.section];
//    [cell.resultImageView sd_setImageWithURL:[NSURL URLWithString:self.resultPatientImageArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
//    cell.resultLabel1.text = @"你的体质是";
//    cell.resultLabel2.text = self.resultMainArray[indexPath.section];
//    cell.resultLabel3.text = self.resultTrendArray[indexPath.section];
//    cell.resultLabel4.text = self.resultTimeArray[indexPath.section];
    
//    cell.resultLabelFix.text = [NSString stringWithFormat:@"%@ 体质：%@, 偏向  %@",[self.resultTimeArray[indexPath.section] substringToIndex:10],self.resultMainArray[indexPath.section],self.resultTrendArray[indexPath.section]];
    cell.resultLabelFix.text = [NSString stringWithFormat:@"%@ 体质：%@, 偏向  %@",self.resultTimeArray[indexPath.section],self.resultMainArray[indexPath.section],self.resultTrendArray[indexPath.section]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sourceVC isEqualToString:@"QuestionInquiryViewController"]) {
        if (self.testListDelegate && [self.testListDelegate respondsToSelector:@selector(testListChoosed:type:)]) {
            [self.testListDelegate testListChoosed:self.resultTimeArray[indexPath.section] type:@"体质测试"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
        detailVC.resultId = self.resultIdArray[indexPath.section];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendTestResultListRequest{
    DLog(@"sendTestResultListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"100" forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_RESULT_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self testResultListDataParse];
        }else{
            DLog(@"%ld",(long)self.code);
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
-(void)testResultListDataParse{
    self.resultArray = [ResultData mj_objectArrayWithKeyValuesArray:self.data];
    for (ResultData *resultData in self.resultArray) {
        [self.resultPatientIdArray addObject:[NullUtil judgeStringNull:resultData.user_id]];
        [self.resultPatientImageArray addObject:[NullUtil judgeStringNull:resultData.heand_url]];
        [self.resultIdArray addObject:[NullUtil judgeStringNull:resultData.analy_result_id]];
        [self.resultMainArray addObject:[NullUtil judgeStringNull:resultData.main_result]];
        [self.resultTrendArray addObject:[NullUtil judgeStringNull:resultData.trend_result]];
        [self.resultTimeArray addObject:[NullUtil judgeStringNull:resultData.create_date]];
    }
    
    [self.tableView reloadData];
}

@end
