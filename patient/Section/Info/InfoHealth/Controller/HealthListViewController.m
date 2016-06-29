//
//  HealthListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "ResultData.h"
#import "TestResultDetailViewController.h"
#import "HealthDiseaseTableCell.h"
#import "HealthInspectionTableCell.h"
#import "HealthTestTableCell.h"
#import "TestFixViewController.h"
#import "HealthDiseaseHistoryViewController.h"
#import "HealthMarriageHistoryViewController.h"
#import "HealthSelfInspectionViewController.h"
#import "HealthSelfInspectionFixViewController.h"

@interface HealthListViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guomingshi;
@property (strong,nonatomic)NSString *jiazushi;
@property (strong,nonatomic)NSString *hunfou;
@property (strong,nonatomic)NSString *erzi;
@property (strong,nonatomic)NSString *nver;

@end

@implementation HealthListViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendHealthListRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthListViewController"];
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
    
    self.title = @"健康记录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"记一记" style:(UIBarButtonItemStylePlain) target:self action:@selector(addHealthButtonClicked)];
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
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendHealthListRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)addHealthButtonClicked{
    DLog(@"addHealthButtonClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"既往史／手术史／过敏史／家族史", @"婚育情况",@"健康自查",@"体质测试",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)inspectionHeadViewClicked{
    DLog(@"inspectionHeadViewClicked");
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        DLog(@"既往史／手术史／过敏史／家族史");
        HealthDiseaseHistoryViewController *diseasHistoryVC = [[HealthDiseaseHistoryViewController alloc] init];
        [self.navigationController pushViewController:diseasHistoryVC animated:YES];
    }else if (buttonIndex == 1){
        DLog(@"婚育情况");
        HealthMarriageHistoryViewController *marriageHistoryVC = [[HealthMarriageHistoryViewController alloc] init];
        [self.navigationController pushViewController:marriageHistoryVC animated:YES];
    }else if (buttonIndex == 2){
        DLog(@"健康自查");
//        HealthSelfInspectionViewController *selfInspectionVC = [[HealthSelfInspectionViewController alloc] init];
//        [self.navigationController pushViewController:selfInspectionVC animated:YES];
        HealthSelfInspectionFixViewController *selfInspectionFixVC = [[HealthSelfInspectionFixViewController alloc] init];
        [self.navigationController pushViewController:selfInspectionFixVC animated:YES];
    }else if (buttonIndex == 3){
        DLog(@"体质测试");
        TestFixViewController *testVC = [[TestFixViewController alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
    }else if (buttonIndex == 4){
        DLog(@"取消");
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.resultArray.count==0 ? 2 : 2+self.resultArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1){
        return 450;
    }else if (indexPath.section > 1){
        return 45;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else if (section == 1){
        return 40;
    }else if (section == 2){
        return 40;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section < 2) {
        return 10;
    }else{
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.healthListHeaderView = [[HealthListHeaderView alloc] init];
    self.healthListHeaderView.tag = section;
    if (section == 0) {
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.hidden = YES;
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden = YES;
    }
    else if (section == 1){
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.text = @"健康自查";
        self.healthListHeaderView.moreLabel.text = @"更多...";
        self.healthListHeaderView.moreImage.hidden = YES;
        
        self.healthListHeaderView.userInteractionEnabled = YES;
        UITapGestureRecognizer *inspectionHeadViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inspectionHeadViewClicked)];
        [self.healthListHeaderView addGestureRecognizer:inspectionHeadViewTap];
        
    }else if (section == 2){
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.text = @"体质测试";
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden  = YES;
    }else{
        self.healthListHeaderView.titleImage.hidden = YES;
        self.healthListHeaderView.titleLabel.hidden = YES;
        self.healthListHeaderView.moreLabel.hidden = YES;
        self.healthListHeaderView.moreImage.hidden = YES;
    }
    return self.healthListHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"HealthDiseaseTableCell";
        HealthDiseaseTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthDiseaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthInspectionTableCell";
        HealthInspectionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthInspectionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }else if (indexPath.section > 1){
        static NSString *cellName = @"HealthTestTableCell";
        HealthTestTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthTestTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.timeLabel.text = self.resultTimeArray[indexPath.section-2];
        cell.tizhiLabel.text = [NSString stringWithFormat:@"体质：%@ 偏向 %@",self.resultMainArray[indexPath.section-2],self.resultTrendArray[indexPath.section-2]];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 1) {
        TestResultDetailViewController *detailVC = [[TestResultDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        detailVC.resultId = self.resultIdArray[indexPath.section-2];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendHealthListRequest{
    DLog(@"sendHealthListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self healthListDataParse];
        }else{
            DLog(@"%@",self.message1);
            if (self.code1 == kTOKENINVALID) {
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

-(void)sendTestResultListRequest{
    DLog(@"sendTestResultListRequest");
    
    self.currentPage = 1;
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_RESULT_LIST_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self testResultListDataParse];
        }else{
            DLog(@"%ld",(long)self.code2);
            DLog(@"%@",self.message2);
            if (self.code2 == kTOKENINVALID) {
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
-(void)healthListDataParse{
    if (![[self.data1 objectForKey:@"userHistory"] isKindOfClass:[NSNull class]]) {
        self.jiwangshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	a_history"]];
        self.shoushushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	b_history"]];
        self.guomingshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	c_history"]];
        self.jiazushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	d_history"]];
        self.hunfou = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	marriage_status"]];
        self.erzi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	a_son"]];
        self.nver = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"	b_son"]];
    }

    if (![[self.data1 objectForKey:@"healthy"] isKindOfClass:[NSNull class]]) {
        
    }
    
    [self sendTestResultListRequest];
}

-(void)testResultListDataParse{
    self.resultArray = [ResultData mj_objectArrayWithKeyValuesArray:self.data2];
    for (ResultData *resultData in self.resultArray) {
        [self.resultPatientIdArray addObject:[NullUtil judgeStringNull:resultData.user_id]];
        [self.resultPatientImageArray addObject:[NullUtil judgeStringNull:resultData.heand_url]];
        [self.resultIdArray addObject:[NullUtil judgeStringNull:resultData.analy_result_id]];
        [self.resultMainArray addObject:[NullUtil judgeStringNull:resultData.main_result]];
        [self.resultTrendArray addObject:[NullUtil judgeStringNull:resultData.trend_result]];
        [self.resultTimeArray addObject:[NullUtil judgeStringNull:resultData.create_date]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

@end
