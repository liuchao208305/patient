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
#import "HealthListDetailViewController.h"

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

@property (strong,nonatomic)NSString *diseaseHistoryId;
@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guomingshi;
@property (strong,nonatomic)NSString *jiazushi;
@property (assign,nonatomic)int hunfou;
@property (assign,nonatomic)int erzi;
@property (assign,nonatomic)int nver;

@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthTime;
@property (strong,nonatomic)NSString *healthResultString;
@property (strong,nonatomic)NSDictionary *healthResultDictionary;
@property (strong,nonatomic)NSString *shuimian;
@property (strong,nonatomic)NSString *yinshi;
@property (strong,nonatomic)NSString *yinshui;

@property (strong,nonatomic)NSString *dabian1;
@property (strong,nonatomic)NSString *dabian2;
@property (strong,nonatomic)NSString *dabian3;
@property (strong,nonatomic)NSString *xiaobian1;
@property (strong,nonatomic)NSString *xiaobian2;

@property (strong,nonatomic)NSString *dabianCishu;
@property (strong,nonatomic)NSString *bianmiStatus;
@property (strong,nonatomic)NSString *xiexieStatus;
@property (strong,nonatomic)NSString *chengxingStatus;
@property (strong,nonatomic)NSString *bianzhiStatus;
@property (strong,nonatomic)NSString *bianzhiString;
@property (strong,nonatomic)NSString *paibianganStatus;
@property (strong,nonatomic)NSString *paibianganString;
@property (strong,nonatomic)NSString *dabianyanseString;
@property (strong,nonatomic)NSString *xiaobianBaitianString;
@property (strong,nonatomic)NSString *xiaobianWanshangString;
@property (strong,nonatomic)NSString *sezhiStatus;
@property (strong,nonatomic)NSString *sezhiString;
@property (strong,nonatomic)NSString *painiaoganStatus;
@property (strong,nonatomic)NSString *painiaoganString;

@property (strong,nonatomic)NSString *hanre;
@property (strong,nonatomic)NSString *tiwen;
@property (strong,nonatomic)NSString *chuhan;
@property (strong,nonatomic)NSString *healthPhotoString;

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
    
    self.jiwangshi = @"";
    self.shoushushi = @"";
    self.guomingshi = @"";
    self.jiazushi = @"";
    self.hunfou = @"";
    self.erzi = 0;
    self.nver = 0;
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
    HealthListDetailViewController *healthListDetailVC = [[HealthListDetailViewController alloc] init];
    [self.navigationController pushViewController:healthListDetailVC animated:YES];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        DLog(@"既往史／手术史／过敏史／家族史");
        HealthDiseaseHistoryViewController *diseasHistoryVC = [[HealthDiseaseHistoryViewController alloc] init];
        diseasHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
        diseasHistoryVC.hunfou = self.hunfou;
        diseasHistoryVC.erzi = self.erzi;
        diseasHistoryVC.nver = self.nver;
        [self.navigationController pushViewController:diseasHistoryVC animated:YES];
    }else if (buttonIndex == 1){
        DLog(@"婚育情况");
        HealthMarriageHistoryViewController *marriageHistoryVC = [[HealthMarriageHistoryViewController alloc] init];
        marriageHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
        marriageHistoryVC.jiwangshi = self.jiwangshi;
        marriageHistoryVC.shoushushi = self.shoushushi;
        marriageHistoryVC.guominshi = self.guomingshi;
        marriageHistoryVC.jiazushi = self.jiazushi;
        [self.navigationController pushViewController:marriageHistoryVC animated:YES];
    }else if (buttonIndex == 2){
        DLog(@"健康自查");
        HealthSelfInspectionViewController *selfInspectionVC = [[HealthSelfInspectionViewController alloc] init];
        [self.navigationController pushViewController:selfInspectionVC animated:YES];
        
//        HealthSelfInspectionFixViewController *selfInspectionFixVC = [[HealthSelfInspectionFixViewController alloc] init];
//        [self.navigationController pushViewController:selfInspectionFixVC animated:YES];
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
        return 480;
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
        
        cell.jiwangshiLabel1.text = @"既往史：";
        cell.jiwangshiLabel2.text = [self.jiwangshi isEqualToString:@""] ? @"无" : self.jiwangshi;
        cell.shoushushiLabel1.text = @"手术史：";
        cell.shoushushiLabel2.text = [self.shoushushi isEqualToString:@""] ? @"无" : self.shoushushi;
        cell.guomingshiLabel1.text = @"过敏史：";
        cell.guomingshiLabel2.text = [self.guomingshi isEqualToString:@""] ? @"无" : self.guomingshi;
        cell.jiazushiLabel1.text = @"家族史：";
        cell.jiazushiLabel2.text = [self.jiazushi isEqualToString:@""] ? @"无" : self.jiazushi;
        
        cell.hunfouLabel1.text = @"婚否：";
        if (self.hunfou == 0) {
            cell.hunfouLabel2.text = @"无";
        }else{
            if (self.hunfou == 1) {
                cell.hunfouLabel2.text = @"未婚";
            }else if (self.hunfou == 2){
                cell.hunfouLabel2.text = @"已婚";
            }
        }
        
        cell.erziLabel1.text = @"儿子：";
        if (self.erzi == 0) {
            cell.erziLabel2.text = @"无";
        }else{
            cell.erziLabel2.text = [NSString stringWithFormat:@"%d个",self.erzi];
        }
        
        cell.nverLabel1.text = @"女儿：";
        if (self.nver == 0) {
            cell.nverLabel2.text = @"无";
        }else{
            cell.nverLabel2.text = [NSString stringWithFormat:@"%d个",self.nver];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"HealthInspectionTableCell";
        HealthInspectionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HealthInspectionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (![[self.data1 objectForKey:@"healthy"] isKindOfClass:[NSNull class]]) {
            cell.noImageView.hidden = YES;
            cell.noLabel.hidden = YES;
            cell.noButton.hidden = YES;
            
            cell.timeLabel.text = [self.healthTime substringToIndex:10];
            cell.shuimianLabel1.text = @"睡眠：";
            cell.shuimianLabel2.text = [self.shuimian isEqualToString:@""] ? @"无" : self.shuimian;
            cell.yinshiLabel1.text = @"饮食：";
            cell.yinshiLabel2.text = [self.yinshi isEqualToString:@""] ? @"无" : self.yinshi;
            cell.yinshuiLabel1.text = @"饮水：";
            cell.yinshuiLabel2.text = [self.yinshui isEqualToString:@""] ? @"无" : self.yinshui;
            cell.dabianLabel1.text = @"大便：";
            cell.dabianLabel2_1.text = [self.dabian1 isEqualToString:@""] ? @"无" : self.dabian1;
            cell.dabianLabel2_2.text = [self.dabian2 isEqualToString:@""] ? @"无" : self.dabian2;
            cell.dabianLabel2_3.text = [self.dabian3 isEqualToString:@""] ? @"无" : self.dabian3;
            //        NSString *test = @"0xb6bc16";
            //        unsigned long red = strtoul([test UTF8String],0,0);
            //        [cell.dabianImageView setBackgroundColor:ColorWithHexRGB(red)];
            self.dabianyanseString = @"";
            
            if ([self.dabianyanseString isEqualToString:@""]) {
                [cell.dabianImageView setBackgroundColor:kWHITE_COLOR];
            }else{
                unsigned long dabian = strtoul([self.dabianyanseString UTF8String],0,0);
                [cell.dabianImageView setBackgroundColor:ColorWithHexRGB(dabian)];
            }
            cell.xiaobianLabel1.text = @"小便：";
            cell.xiaobianLabel2_1.text = [self.xiaobian1 isEqualToString:@""] ? @"无" : self.xiaobian1;
            cell.xiaobianLabel2_2.text = [self.xiaobian2 isEqualToString:@""] ? @"无" : self.xiaobian2;
            cell.hanreLabel1.text = @"寒热：";
            cell.hanreLabel2.text = [self.hanre isEqualToString:@""] ? @"无" : self.hanre;
            cell.tiwenLabel1.text = @"体温：";
            cell.tiwenLabel2.text = [self.tiwen isEqualToString:@""] ? @"无" : self.tiwen;
            cell.chuhanLabel1.text = @"出汗：";
            cell.chuhanLabel2.text = [self.chuhan isEqualToString:@""] ? @"无" : self.chuhan;
            cell.zhaopianLabel1.text = @"照片资料：";
            cell.zhaopianLabel2.text = [self.healthPhotoString isEqualToString:@""] ? @"无" : @"有";
        }else{
            cell.shuimianLineView.hidden = YES;
            cell.yinshiLineView.hidden = YES;
            cell.yinshuiLineView.hidden = YES;
            cell.dabianLineView.hidden = YES;
            cell.xiaobianLineView.hidden = YES;
            cell.hanreLineView.hidden = YES;
            cell.tiwenLineView.hidden = YES;
            cell.chuhanLineView.hidden = YES;
            [cell.noButton addTarget:self action:@selector(addHealthButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
            [HudUtil showSimpleTextOnlyHUD:self.message1 withDelaySeconds:kHud_DelayTime];
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
        self.diseaseHistoryId = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"ids"]];
        self.jiwangshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_history"]];
        self.shoushushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_history"]];
        self.guomingshi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"c_history"]];
        self.jiazushi = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"userHistory"] objectForKey:@"d_history"]];
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"marriage_status"] isKindOfClass:[NSNull class]]) {
            self.hunfou = 0;
        }else{
            self.hunfou = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"marriage_status"] intValue];
        }
        
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_son"] isKindOfClass:[NSNull class]]) {
            self.erzi = 0;
        }else{
            self.erzi = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"a_son"] intValue];
        }
        
        if ([[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_son"] isKindOfClass:[NSNull class]]) {
            self.nver = 0;
        }else{
            self.nver = [[[self.data1 objectForKey:@"userHistory"] objectForKey:@"b_son"] intValue];
        }
    }

    if (![[self.data1 objectForKey:@"healthy"] isKindOfClass:[NSNull class]]) {
        self.healthId = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"q_healthy_id"]];
        self.healthTime = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"create_date"]];
        
        self.healthResultString = [[self.data1 objectForKey:@"healthy"] objectForKey:@"results"];
        self.healthResultDictionary = [StringUtil dictionaryWithJsonString:self.healthResultString];
        
        self.shuimian = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"b_val"]];
        self.yinshi = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"c_val"]];
        self.yinshui = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"d_val"]];
        
        self.dabianCishu = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_val"]];
        self.bianmiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isBM"]];
        self.xiexieStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"	e_isXM"]];
        self.chengxingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"	e_isCX"]];
        self.bianzhiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isEX"]];
        self.bianzhiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_EX_val"]];
        self.paibianganStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"f_status"]];
        self.paibianganString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"f_val"]];
        self.dabianyanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"	e_color"]];
        self.xiaobianBaitianString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"g_up_no"]];
        self.xiaobianWanshangString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"g_down_no"]];
        self.sezhiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"h_status"]];
        self.sezhiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"h_val"]];
        self.painiaoganStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"i_status"]];
        self.painiaoganString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"i_val"]];
        
        self.dabian1 = [NSString stringWithFormat:@"每天%@次；便秘：%@；泄泻：%@；成形：%@；",self.dabianCishu,self.bianmiStatus,self.xiexieStatus,self.chengxingStatus];
        self.dabian2 = [NSString stringWithFormat:@"便质：%@；排便感：%@",self.bianzhiString,self.paibianganString];
        self.dabian3 = @"大便颜色：";
        
        self.xiaobian1 = [NSString stringWithFormat:@"白天%@次，晚上%@次；色质：%@；",self.xiaobianBaitianString,self.xiaobianWanshangString,self.sezhiString];
        self.xiaobian2 = [NSString stringWithFormat:@"排尿感：%@；",self.painiaoganString];
        
        self.hanre = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"v_val"]];
        self.tiwen = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"w_val"]];
        self.chuhan = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"x_val"]];
        
        self.healthPhotoString = [NullUtil judgeStringNull:[[self.data1 objectForKey:@"healthy"] objectForKey:@"photos"]];
    }
    
    [self sendTestResultListRequest];
}

-(void)testResultListDataParse{
    self.resultArray = [ResultData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.resultPatientIdArray removeAllObjects];
    [self.resultPatientImageArray removeAllObjects];
    [self.resultIdArray removeAllObjects];
    [self.resultMainArray removeAllObjects];
    [self.resultTrendArray removeAllObjects];
    [self.resultTimeArray removeAllObjects];
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
