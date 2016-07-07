//
//  MineQuestionListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineQuestionListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "LoginViewController.h"
#import "MineQuestionListTableCell.h"
#import "MineQuestionData.h"

@interface MineQuestionListViewController ()

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableArray *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableArray *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSMutableDictionary *result4;
@property (assign,nonatomic)NSInteger code4;
@property (strong,nonatomic)NSString *message4;
@property (strong,nonatomic)NSMutableArray *data4;
@property (assign,nonatomic)NSError *error4;

@property (strong,nonatomic)NSMutableDictionary *result5;
@property (assign,nonatomic)NSInteger code5;
@property (strong,nonatomic)NSString *message5;
@property (strong,nonatomic)NSMutableArray *data5;
@property (assign,nonatomic)NSError *error5;

@property (assign,nonatomic)NSInteger currentPage1;
@property (assign,nonatomic)NSInteger pageSize1;

@property (assign,nonatomic)NSInteger currentPage2;
@property (assign,nonatomic)NSInteger pageSize2;

@property (assign,nonatomic)NSInteger currentPage3;
@property (assign,nonatomic)NSInteger pageSize3;

@property (assign,nonatomic)NSInteger currentPage4;
@property (assign,nonatomic)NSInteger pageSize4;

@property (assign,nonatomic)NSInteger currentPage5;
@property (assign,nonatomic)NSInteger pageSize5;

@end

@implementation MineQuestionListViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView:self.questionType];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"MineQuestionListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    if (self.questionType == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView1];
        [self sendQestionListRequest1];
    }else if (self.questionType == 1){
        self.flag1 = NO;
        self.flag2 = YES;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView2];
        [self sendQestionListRequest2];
    }else if (self.questionType == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView3];
        [self sendQestionListRequest3];
    }else if (self.questionType == 3){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = YES;
        self.flag5 = NO;
        
        [self initSubView4];
        [self sendQestionListRequest4];
    }else if (self.questionType == 4){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = YES;
        
        [self initSubView5];
        [self sendQestionListRequest5];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineQuestionListViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.questionArrayAll = [NSMutableArray array];
    self.questionIdArrayAll = [NSMutableArray array];
    self.questionPayStatusArrayAll = [NSMutableArray array];
    self.questionAnswerStatusArrayAll = [NSMutableArray array];
    self.questionPublicStatusArrayAll = [NSMutableArray array];
    self.questionContentArrayAll = [NSMutableArray array];
    self.questionAskTimeArrayAll = [NSMutableArray array];
    self.questionAnswerTimeArrayAll = [NSMutableArray array];
    self.questionPayTimeArrayAll = [NSMutableArray array];
    self.questionMoneyArrayAll = [NSMutableArray array];
    self.questionExpertIdArrayAll = [NSMutableArray array];
    self.questionExpertNameArrayAll = [NSMutableArray array];
    self.questionAudienceArrayAll = [NSMutableArray array];
    
    self.questionArrayUnpayed = [NSMutableArray array];
    self.questionIdArrayUnpayed = [NSMutableArray array];
    self.questionPayStatusArrayUnpayed = [NSMutableArray array];
    self.questionAnswerStatusArrayUnPayed = [NSMutableArray array];
    self.questionPublicStatusArrayUnpayed = [NSMutableArray array];
    self.questionContentArrayUnpayed = [NSMutableArray array];
    self.questionAskTimeArrayUnpayed = [NSMutableArray array];
    self.questionAnswerTimeArrayUnpayed = [NSMutableArray array];
    self.questionPayTimeArrayUnpayed = [NSMutableArray array];
    self.questionMoneyArrayUnpayed = [NSMutableArray array];
    self.questionExpertIdArrayUnpayed = [NSMutableArray array];
    self.questionExpertNameArrayUnpayed = [NSMutableArray array];
    self.questionAudienceArrayUnpayed = [NSMutableArray array];
    
    self.questionArrayUnanswered = [NSMutableArray array];
    self.questionIdArrayUnanswered = [NSMutableArray array];
    self.questionPayStatusArrayUnanswered = [NSMutableArray array];
    self.questionAnswerStatusArrayUnanswered = [NSMutableArray array];
    self.questionPublicStatusArrayUnanswered = [NSMutableArray array];
    self.questionContentArrayUnanswered = [NSMutableArray array];
    self.questionAskTimeArrayUnanswered = [NSMutableArray array];
    self.questionAnswerTimeArrayUnanswered = [NSMutableArray array];
    self.questionPayTimeArrayUnanswered = [NSMutableArray array];
    self.questionMoneyArrayUnanswered = [NSMutableArray array];
    self.questionExpertIdArrayUnanswered = [NSMutableArray array];
    self.questionExpertNameArrayUnanswered = [NSMutableArray array];
    self.questionAudienceArrayUnanswered = [NSMutableArray array];
    
    self.questionArrayAnswered = [NSMutableArray array];
    self.questionIdArrayAnswered = [NSMutableArray array];
    self.questionPayStatusArrayAnswered = [NSMutableArray array];
    self.questionAnswerStatusArrayAnswered = [NSMutableArray array];
    self.questionPublicStatusArrayAnswered = [NSMutableArray array];
    self.questionContentArrayAnswered = [NSMutableArray array];
    self.questionAskTimeArrayAnswered = [NSMutableArray array];
    self.questionAnswerTimeArrayAnswered = [NSMutableArray array];
    self.questionPayTimeArrayAnswered = [NSMutableArray array];
    self.questionMoneyArrayAnswered = [NSMutableArray array];
    self.questionExpertIdArrayAnswered = [NSMutableArray array];
    self.questionExpertNameArrayAnswered = [NSMutableArray array];
    self.questionAudienceArrayAnswered = [NSMutableArray array];
    
    self.questionArrayPublic = [NSMutableArray array];
    self.questionIdArrayPublic = [NSMutableArray array];
    self.questionPayStatusArrayPublic = [NSMutableArray array];
    self.questionAnswerStatusArrayPublic = [NSMutableArray array];
    self.questionPublicStatusArrayPublic = [NSMutableArray array];
    self.questionContentArrayPublic = [NSMutableArray array];
    self.questionAskTimeArrayPublic = [NSMutableArray array];
    self.questionAnswerTimeArrayPublic = [NSMutableArray array];
    self.questionPayTimeArrayPublic = [NSMutableArray array];
    self.questionMoneyArrayPublic = [NSMutableArray array];
    self.questionExpertIdArrayPublic = [NSMutableArray array];
    self.questionExpertNameArrayPublic = [NSMutableArray array];
    self.questionAudienceArrayPublic = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.title=@"问答列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView:(NSInteger)number{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"全部", @"待支付", @"待回答",@"已回答",@"公开",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:kBACKGROUND_COLOR titleColor:kLIGHT_GRAY_COLOR titleFont:[UIFont systemFontOfSize:14] selectColor:kBLACK_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:number];
    
    [self.view addSubview:self.segmentControl];
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = YES;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView1.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQestionListRequest1];
    }];
    
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQestionListRequest1];
    }];
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = YES;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView2.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQestionListRequest2];
    }];
    
    self.tableView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQestionListRequest2];
    }];
    
    [self.view addSubview:self.tableView2];
}

-(void)initSubView3{
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.showsVerticalScrollIndicator = YES;
    self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView3.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQestionListRequest3];
    }];
    
    self.tableView3.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQestionListRequest3];
    }];
    
    [self.view addSubview:self.tableView3];
}

-(void)initSubView4{
    self.tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView4.delegate = self;
    self.tableView4.dataSource = self;
    self.tableView4.showsVerticalScrollIndicator = YES;
    self.tableView4.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView4.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQestionListRequest4];
    }];
    
    self.tableView4.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQestionListRequest4];
    }];
    
    [self.view addSubview:self.tableView4];
}

-(void)initSubView5{
    self.tableView5 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView5.delegate = self;
    self.tableView5.dataSource = self;
    self.tableView5.showsVerticalScrollIndicator = YES;
    self.tableView5.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView5.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQestionListRequest5];
    }];
    
    self.tableView5.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQestionListRequest5];
    }];
    
    [self.view addSubview:self.tableView5];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.questionArrayAll.count == 0 ? 0 : self.questionArrayAll.count;
    }else if (self.flag2){
        return self.questionArrayUnpayed.count == 0 ? 0 : self.questionArrayUnpayed.count;
    }else if (self.flag3){
        return self.questionArrayUnanswered.count == 0 ? 0 : self.questionArrayUnanswered.count;
    }else if (self.flag4){
        return self.questionArrayAnswered.count == 0 ? 0 : self.questionArrayAnswered.count;
    }else if (self.flag5){
        return self.questionArrayPublic.count == 0 ? 0 : self.questionArrayPublic.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if ([self.questionPayStatusArrayAll[indexPath.section] intValue] == 1) {
            return 150;
        }else if ([self.questionPayStatusArrayAll[indexPath.section] intValue] == 2){
            return 200;
        }
    }else if (self.flag2){
        return 150;
    }else if (self.flag3){
        return 200;
    }else if (self.flag4){
        return 200;
    }else if (self.flag5){
        if ([self.questionPayStatusArrayAll[indexPath.section] intValue] == 1) {
            return 150;
        }else if ([self.questionPayStatusArrayAll[indexPath.section] intValue] == 2){
            return 200;
        }
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MineQuestionListTableCell";
    MineQuestionListTableCell *cell = [self.tableView1 dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MineQuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (self.flag1) {
        
    }else if (self.flag2){
        
    }else if (self.flag3){
        
    }else if (self.flag4){
        
    }else if (self.flag5){
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        //        if ([self.orderStatusArrayAll[indexPath.section] isEqualToString:@"1"]) {
        //            TreatmentDetailViewController *detaiVC = [[TreatmentDetailViewController alloc] init];
        //            detaiVC.isFromOrderListVC = YES;
        //            detaiVC.orderNumber = self.orderPayIdArrayAll[indexPath.section];
        //            [self.navigationController pushViewController:detaiVC animated:YES];
        //        }else if ([self.orderStatusArrayAll[indexPath.section] isEqualToString:@"5"]){
        //            MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        //            medicineVC.orderNumber = self.orderIdArrayAll[indexPath.section];
        //            [self.navigationController pushViewController:medicineVC animated:YES];
        //        }else if ([self.orderStatusArrayAll[indexPath.section] isEqualToString:@"6"]){
        //            MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        //            medicineVC.orderNumber = self.orderIdArrayAll[indexPath.section];
        //            [self.navigationController pushViewController:medicineVC animated:YES];
        //        }else{
        //            TreatmentFinishViewController *finishVC = [[TreatmentFinishViewController alloc] init];
        //            finishVC.orderNumber = self.orderIdArrayAll[indexPath.section];
        //            [self.navigationController pushViewController:finishVC animated:YES];
        //        }
        
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
        //        TreatmentDetailViewController *detaiVC = [[TreatmentDetailViewController alloc] init];
        //        detaiVC.isFromOrderListVC = YES;
        //        detaiVC.orderNumber = self.orderPayIdArrayBooked[indexPath.section];
        //        [self.navigationController pushViewController:detaiVC animated:YES];
        
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag3){
        //        TreatmentFinishViewController *finishVC = [[TreatmentFinishViewController alloc] init];
        //        finishVC.orderNumber = self.orderIdArrayProceeding[indexPath.section];
        //        [self.navigationController pushViewController:finishVC animated:YES];
        
        [self.tableView3 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag4){
        //        MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        //        medicineVC.orderNumber = self.orderIdArrayEvaluating[indexPath.section];
        //        [self.navigationController pushViewController:medicineVC animated:YES];
        
        //        RecordDetailViewController *recordDetailVC = [[RecordDetailViewController alloc] init];
        //        recordDetailVC.orderNumber = self.orderIdArrayEvaluating[indexPath.section];
        //        [self.navigationController pushViewController:recordDetailVC animated:YES];
        
        [self.tableView4 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag5){
        //        MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        //        medicineVC.orderNumber = self.orderIdArrayCompleted[indexPath.section];
        //        [self.navigationController pushViewController:medicineVC animated:YES];
        
        [self.tableView5 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendQestionListRequest1];
        [self initSubView1];
    }else if (selection == 1){
        self.flag1 = NO;
        self.flag2 = YES;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendQestionListRequest2];
        [self initSubView2];
    }else if (selection == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendQestionListRequest3];
        [self initSubView3];
    }else if (selection == 3){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = YES;
        self.flag5 = NO;
        [self sendQestionListRequest4];
        [self initSubView4];
    }else if (selection == 4){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = YES;
        [self sendQestionListRequest5];
        [self initSubView5];
    }
}

#pragma mark Network Request
-(void)sendQestionListRequest1{
    DLog(@"sendQestionListRequest1");
    
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"0" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_QUESTION_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self questionListDataParse1];
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

-(void)sendQestionListRequest2{
    DLog(@"sendQestionListRequest2");
    
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"1" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_QUESTION_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self questionListDataParse2];
        }else{
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

-(void)sendQestionListRequest3{
    DLog(@"sendQestionListRequest3");
    
    self.pageSize3 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"2" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize3] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_QUESTION_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION_FIX);
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self questionListDataParse3];
        }else{
            DLog(@"%@",self.message3);
            if (self.code3 == kTOKENINVALID) {
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

-(void)sendQestionListRequest4{
    DLog(@"sendQestionListRequest4");
    
    self.pageSize4 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"3" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize4] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_QUESTION_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            [self questionListDataParse4];
        }else{
            DLog(@"%@",self.message4);
            if (self.code4 == kTOKENINVALID) {
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

-(void)sendQestionListRequest5{
    DLog(@"sendQestionListRequest5");
    
    self.pageSize5 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:@"4" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize5] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_QUESTION_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result5 = (NSMutableDictionary *)responseObject;
        
        self.code5 = [[self.result5 objectForKey:@"code"] integerValue];
        self.message5 = [self.result5 objectForKey:@"message"];
        self.data5 = [self.result5 objectForKey:@"data"];
        
        if (self.code5 == kSUCCESS) {
            [self questionListDataParse5];
        }else{
            DLog(@"%@",self.message5);
            if (self.code5 == kTOKENINVALID) {
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
-(void)questionListDataParse1{
    DLog(@"questionListDataParse1");
    
    self.questionArrayAll = [MineQuestionData mj_objectArrayWithKeyValuesArray:self.data1];
    
    [self.questionIdArrayAll removeAllObjects];
    [self.questionPayStatusArrayAll removeAllObjects];
    [self.questionAnswerStatusArrayAll removeAllObjects];
    [self.questionPublicStatusArrayAll removeAllObjects];
    [self.questionContentArrayAll removeAllObjects];
    [self.questionAskTimeArrayAll removeAllObjects];
    [self.questionAnswerTimeArrayAll removeAllObjects];
    [self.questionPayTimeArrayAll removeAllObjects];
    [self.questionMoneyArrayAll removeAllObjects];
    [self.questionExpertIdArrayAll removeAllObjects];
    [self.questionExpertNameArrayAll removeAllObjects];
    [self.questionAudienceArrayAll removeAllObjects];
    
    for (MineQuestionData *mineQuestionData in self.questionArrayAll) {
        [self.questionIdArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.interloution_id]];
        [self.questionPayStatusArrayAll addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.pay_status]];
        [self.questionAnswerStatusArrayAll addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.status]];
        [self.questionPublicStatusArrayAll addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.is_public]];
        [self.questionContentArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.content]];
        [self.questionAskTimeArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.create_date]];
        [self.questionAnswerTimeArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.answer_date]];
        [self.questionPayTimeArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.pay_date]];
        [self.questionMoneyArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.money]];
        [self.questionExpertIdArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_id]];
        [self.questionExpertNameArrayAll addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_name]];
        [self.questionAudienceArrayAll addObject:[NSString stringWithFormat:@"%d",mineQuestionData.records]];
    }
    
    [self.tableView1 reloadData];
    
    [self.tableView1.mj_header endRefreshing];
    [self.tableView1.mj_footer endRefreshing];
}

-(void)questionListDataParse2{
    DLog(@"questionListDataParse2");
    
    self.questionArrayUnpayed = [MineQuestionData mj_objectArrayWithKeyValuesArray:self.data2];
    
    [self.questionIdArrayUnpayed removeAllObjects];
    [self.questionPayStatusArrayUnpayed removeAllObjects];
    [self.questionAnswerStatusArrayUnPayed removeAllObjects];
    [self.questionPublicStatusArrayUnpayed removeAllObjects];
    [self.questionContentArrayUnpayed removeAllObjects];
    [self.questionAskTimeArrayUnpayed removeAllObjects];
    [self.questionAnswerTimeArrayUnpayed removeAllObjects];
    [self.questionPayTimeArrayUnpayed removeAllObjects];
    [self.questionMoneyArrayUnpayed removeAllObjects];
    [self.questionExpertIdArrayUnpayed removeAllObjects];
    [self.questionExpertNameArrayUnpayed removeAllObjects];
    [self.questionAudienceArrayUnpayed removeAllObjects];
    
    for (MineQuestionData *mineQuestionData in self.questionArrayUnpayed) {
        [self.questionIdArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.interloution_id]];
        [self.questionPayStatusArrayUnpayed addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.pay_status]];
        [self.questionAnswerStatusArrayUnPayed addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.status]];
        [self.questionPublicStatusArrayUnpayed addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.is_public]];
        [self.questionContentArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.content]];
        [self.questionAskTimeArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.create_date]];
        [self.questionAnswerTimeArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.answer_date]];
        [self.questionPayTimeArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.pay_date]];
        [self.questionMoneyArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.money]];
        [self.questionExpertIdArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_id]];
        [self.questionExpertNameArrayUnpayed addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_name]];
        [self.questionAudienceArrayUnpayed addObject:[NSString stringWithFormat:@"%d",mineQuestionData.records]];
    }
    
    [self.tableView2 reloadData];
    
    [self.tableView2.mj_header endRefreshing];
    [self.tableView2.mj_footer endRefreshing];
}

-(void)questionListDataParse3{
    DLog(@"questionListDataParse3");
    
    self.questionArrayUnanswered = [MineQuestionData mj_objectArrayWithKeyValuesArray:self.data3];
    
    [self.questionIdArrayUnanswered removeAllObjects];
    [self.questionPayStatusArrayUnanswered removeAllObjects];
    [self.questionAnswerStatusArrayUnanswered removeAllObjects];
    [self.questionPublicStatusArrayUnanswered removeAllObjects];
    [self.questionContentArrayUnanswered removeAllObjects];
    [self.questionAskTimeArrayUnanswered removeAllObjects];
    [self.questionAnswerTimeArrayUnanswered removeAllObjects];
    [self.questionPayTimeArrayUnanswered removeAllObjects];
    [self.questionMoneyArrayUnanswered removeAllObjects];
    [self.questionExpertIdArrayUnanswered removeAllObjects];
    [self.questionExpertNameArrayUnanswered removeAllObjects];
    [self.questionAudienceArrayUnanswered removeAllObjects];
    
    for (MineQuestionData *mineQuestionData in self.questionArrayUnanswered) {
        [self.questionIdArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.interloution_id]];
        [self.questionPayStatusArrayUnanswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.pay_status]];
        [self.questionAnswerStatusArrayUnanswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.status]];
        [self.questionPublicStatusArrayUnanswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.is_public]];
        [self.questionContentArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.content]];
        [self.questionAskTimeArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.create_date]];
        [self.questionAnswerTimeArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.answer_date]];
        [self.questionPayTimeArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.pay_date]];
        [self.questionMoneyArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.money]];
        [self.questionExpertIdArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_id]];
        [self.questionExpertNameArrayUnanswered addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_name]];
        [self.questionAudienceArrayUnanswered addObject:[NSString stringWithFormat:@"%d",mineQuestionData.records]];
    }
    
    [self.tableView3 reloadData];
    
    [self.tableView3.mj_header endRefreshing];
    [self.tableView3.mj_footer endRefreshing];
}

-(void)questionListDataParse4{
    DLog(@"questionListDataParse4");
    
    self.questionArrayAnswered = [MineQuestionData mj_objectArrayWithKeyValuesArray:self.data4];
    
    [self.questionIdArrayAnswered removeAllObjects];
    [self.questionPayStatusArrayAnswered removeAllObjects];
    [self.questionAnswerStatusArrayAnswered removeAllObjects];
    [self.questionPublicStatusArrayAnswered removeAllObjects];
    [self.questionContentArrayAnswered removeAllObjects];
    [self.questionAskTimeArrayAnswered removeAllObjects];
    [self.questionAnswerTimeArrayAnswered removeAllObjects];
    [self.questionPayTimeArrayAnswered removeAllObjects];
    [self.questionMoneyArrayAnswered removeAllObjects];
    [self.questionExpertIdArrayAnswered removeAllObjects];
    [self.questionExpertNameArrayAnswered removeAllObjects];
    [self.questionAudienceArrayAnswered removeAllObjects];
    
    for (MineQuestionData *mineQuestionData in self.questionArrayAnswered) {
        [self.questionIdArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.interloution_id]];
        [self.questionPayStatusArrayAnswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.pay_status]];
        [self.questionAnswerStatusArrayAnswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.status]];
        [self.questionPublicStatusArrayAnswered addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.is_public]];
        [self.questionContentArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.content]];
        [self.questionAskTimeArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.create_date]];
        [self.questionAnswerTimeArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.answer_date]];
        [self.questionPayTimeArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.pay_date]];
        [self.questionMoneyArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.money]];
        [self.questionExpertIdArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_id]];
        [self.questionExpertNameArrayAnswered addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_name]];
        [self.questionAudienceArrayAnswered addObject:[NSString stringWithFormat:@"%d",mineQuestionData.records]];
    }
    
    [self.tableView4 reloadData];
    
    [self.tableView4.mj_header endRefreshing];
    [self.tableView4.mj_footer endRefreshing];
}

-(void)questionListDataParse5{
    DLog(@"questionListDataParse5");
    
    self.questionArrayPublic = [MineQuestionData mj_objectArrayWithKeyValuesArray:self.data5];
    
    [self.questionIdArrayPublic removeAllObjects];
    [self.questionPayStatusArrayPublic removeAllObjects];
    [self.questionAnswerStatusArrayPublic removeAllObjects];
    [self.questionPublicStatusArrayPublic removeAllObjects];
    [self.questionContentArrayPublic removeAllObjects];
    [self.questionAskTimeArrayPublic removeAllObjects];
    [self.questionAnswerTimeArrayPublic removeAllObjects];
    [self.questionPayTimeArrayPublic removeAllObjects];
    [self.questionMoneyArrayPublic removeAllObjects];
    [self.questionExpertIdArrayPublic removeAllObjects];
    [self.questionExpertNameArrayPublic removeAllObjects];
    [self.questionAudienceArrayPublic removeAllObjects];
    
    for (MineQuestionData *mineQuestionData in self.questionArrayPublic) {
        [self.questionIdArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.interloution_id]];
        [self.questionPayStatusArrayPublic addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.pay_status]];
        [self.questionAnswerStatusArrayPublic addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.status]];
        [self.questionPublicStatusArrayPublic addObject:[NSString stringWithFormat:@"%ld",(long)mineQuestionData.is_public]];
        [self.questionContentArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.content]];
        [self.questionAskTimeArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.create_date]];
        [self.questionAnswerTimeArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.answer_date]];
        [self.questionPayTimeArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.pay_date]];
        [self.questionMoneyArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.money]];
        [self.questionExpertIdArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_id]];
        [self.questionExpertNameArrayPublic addObject:[NullUtil judgeStringNull:mineQuestionData.doctor_name]];
        [self.questionAudienceArrayPublic addObject:[NSString stringWithFormat:@"%d",mineQuestionData.records]];
    }
    
    [self.tableView5 reloadData];
    
    [self.tableView5.mj_header endRefreshing];
    [self.tableView5.mj_footer endRefreshing];
}

@end
