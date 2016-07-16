//
//  HealthListDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListDetailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "HealthListDetailData.h"
#import "HealthListDetailTableCell.h"

@interface HealthListDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@property (strong,nonatomic)NSString *complain;
@property (strong,nonatomic)NSString *shuimianStatus;
@property (strong,nonatomic)NSString *shuimianString;
@property (strong,nonatomic)NSString *yinshiStatus;
@property (strong,nonatomic)NSString *yinshiString;
@property (strong,nonatomic)NSString *yinshuiStatus;
@property (strong,nonatomic)NSString *yinshuiString;

@property (strong,nonatomic)NSString *dabian1;
@property (strong,nonatomic)NSString *dabian2;
@property (strong,nonatomic)NSString *dabian3;
@property (strong,nonatomic)NSString *xiaobian1;
@property (strong,nonatomic)NSString *xiaobian2;

@property (strong,nonatomic)NSString *dabianCishu;
@property (strong,nonatomic)NSString *bianmiStatus;
@property (strong,nonatomic)NSString *bianmiString;
@property (strong,nonatomic)NSString *xiexieStatus;
@property (strong,nonatomic)NSString *xiexieString;
@property (strong,nonatomic)NSString *chengxingStatus;
@property (strong,nonatomic)NSString *chengxingString;
@property (strong,nonatomic)NSString *bianzhiStatus;
@property (strong,nonatomic)NSString *bianzhiString;
@property (strong,nonatomic)NSString *bianzhiStringFix;
@property (strong,nonatomic)NSString *paibianganStatus;
@property (strong,nonatomic)NSString *paibianganString;
@property (strong,nonatomic)NSString *paibianganStringFix;
@property (strong,nonatomic)NSString *dabianyanseString;
@property (strong,nonatomic)NSString *xiaobianBaitianString;
@property (strong,nonatomic)NSString *xiaobianWanshangString;
@property (strong,nonatomic)NSString *sezhiStatus;
@property (strong,nonatomic)NSString *sezhiString;
@property (strong,nonatomic)NSString *sezhiStringFix;
@property (strong,nonatomic)NSString *painiaoganStatus;
@property (strong,nonatomic)NSString *painiaoganString;
@property (strong,nonatomic)NSString *painiaoganStringFix;

@property (strong,nonatomic)NSString *hanreStatus;
@property (strong,nonatomic)NSString *hanreString;
@property (strong,nonatomic)NSString *hanreStringFix;
@property (strong,nonatomic)NSString *tiwenStatus;
@property (strong,nonatomic)NSString *tiwenString;
@property (strong,nonatomic)NSString *tiwenStringFix;
@property (strong,nonatomic)NSString *chuhanStatus;
@property (strong,nonatomic)NSString *chuhanString;
@property (strong,nonatomic)NSString *chuhanStringFix;

@property (strong,nonatomic)NSString *healthPhotoString;

@end

@implementation HealthListDetailViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthListDetailViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendHealthListDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthListDetailViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.healthListDetailArray = [NSMutableArray array];
    self.healthListDetailIdArray = [NSMutableArray array];
    self.healthListDetailTimeArray = [NSMutableArray array];
    self.healthListDetailResultArray = [NSMutableArray array];
    self.healthListDetailPhotoArray  = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.title = @"健康自查列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
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
        [self sendHealthListDetailRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.healthListDetailArray.count == 0 ? 0 : self.healthListDetailArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.healthListDetailPhotoArray[indexPath.section] isEqualToString:@""]) {
        return 550 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-40];
    }else{
        NSMutableArray *zhaopianArray = [NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]];
        CGFloat height = 0;
        if (zhaopianArray.count<=3) {
            height= SCREEN_WIDTH/3;
        } else if (zhaopianArray.count <=6) {
            height= SCREEN_WIDTH/3*2;
        } else if (zhaopianArray.count <=9) {
            height= SCREEN_WIDTH/3*3;
        } else {
            height= SCREEN_WIDTH/3*3;
        }
        return 560+height+[StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-40];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.healthListHeaderView = [[HealthListHeaderView alloc] init];
    self.healthListHeaderView.titleLabel.text = [self.healthListDetailTimeArray[section] substringToIndex:10];
    return self.healthListHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *zhaopianArray = [NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]];
    HealthListDetailTableCell *cell = [[HealthListDetailTableCell alloc] init];
    [cell initViewWithPhotoArray:zhaopianArray];
    
    self.complain = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]];
    self.shuimianStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_status"]];
    self.shuimianString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]];
    self.yinshiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"c_status"]];
    self.yinshiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"c_val"]];
    self.yinshuiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"d_status"]];
    self.yinshuiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"d_val"]];
    
    self.dabianCishu = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_val"]];
    self.bianmiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isBM"]];
    self.xiexieStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isXM"]];
    self.chengxingStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isCX"]];
    self.bianzhiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isEX"]];
    self.bianzhiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_EX_val"]];
    self.paibianganStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"f_status"]];
    self.paibianganString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"f_val"]];
    self.dabianyanseString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_color"]];
    self.xiaobianBaitianString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"g_up_no"]];
    self.xiaobianWanshangString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"g_down_no"]];
    self.sezhiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"h_status"]];
    self.sezhiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"h_val"]];
    self.painiaoganStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"i_status"]];
    self.painiaoganString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"i_val"]];
    
    if ([self.bianmiStatus intValue] == 1) {
        self.bianmiString = @"是";
    }else if ([self.bianmiStatus intValue]== 2){
        self.bianmiString = @"否";
    }
    
    if ([self.xiexieStatus intValue] == 1) {
        self.xiexieString = @"是";
    }else if ([self.xiexieStatus intValue]== 2){
        self.xiexieString = @"否";
    }
    
    if ([self.chengxingStatus intValue] == 1) {
        self.chengxingString = @"是";
    }else if ([self.chengxingStatus intValue]== 2){
        self.chengxingString = @"否";
    }
    
    if ([self.bianzhiStatus intValue] == 1) {
        self.bianzhiStringFix = @"正常";
    }else if ([self.bianzhiStatus intValue]== 2){
        self.bianzhiStringFix = self.bianzhiString;
    }
    
    if ([self.paibianganStatus intValue] == 1) {
        self.paibianganStringFix = @"正常";
    }else if ([self.paibianganStatus intValue]== 2){
        self.paibianganStringFix = self.paibianganString;
    }
    
    self.dabian1 = [NSString stringWithFormat:@"每天%@次  便秘:%@   泄泻:%@   成形:%@",self.dabianCishu,self.bianmiString,self.xiexieString,self.chengxingString];
    self.dabian2 = [NSString stringWithFormat:@"便质:%@  排便感：%@",self.bianzhiStringFix,self.paibianganStringFix];
    self.dabian3 = [NSString stringWithFormat:@"大便颜色:%@",self.dabianyanseString];
    
    if ([self.sezhiStatus intValue] == 1) {
        self.sezhiStringFix = @"正常";
    }else if ([self.sezhiStatus intValue]== 2){
        self.sezhiStringFix = self.sezhiString;
    }
    
    if ([self.paibianganStatus intValue] == 1) {
        self.paibianganStringFix = @"正常";
    }else if ([self.paibianganStatus intValue]== 2){
        self.paibianganStringFix = self.painiaoganString;
    }
    
    self.xiaobian1 = [NSString stringWithFormat:@"白天%@次，晚上%@次  色质:%@",self.xiaobianBaitianString,self.xiaobianWanshangString,self.sezhiStringFix];
    self.xiaobian2 = [NSString stringWithFormat:@"排尿感:%@",self.paibianganStringFix];
    
    self.hanreStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"v_status"]];
    self.hanreString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"v_val"]];
    self.tiwenStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"w_status"]];
    self.tiwenString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"w_val"]];
    self.chuhanStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_status"]];
    self.chuhanString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]];
    
    if ([self.hanreStatus intValue] == 1) {
        self.hanreStringFix = @"正常";
    }else if ([self.hanreStatus intValue]== 2){
        self.hanreStringFix = self.hanreString;
    }
    
    if ([self.tiwenStatus intValue] == 1) {
        self.tiwenStringFix = @"未测";
    }else if ([self.tiwenStatus intValue]== 2){
        self.tiwenStringFix = self.tiwenString;
    }
    
    if ([self.chuhanStatus intValue] == 1) {
        self.chuhanStringFix = @"正常";
    }else if ([self.chuhanStatus intValue]== 2){
        self.chuhanStringFix = self.chuhanString;
    }
    
    cell.complainLabel1.text = @"主诉：";
    cell.complainLabel2.text = [self.complain isEqualToString:@""] ? @"正常" : self.complain;
    cell.shuimianLabel1.text = @"睡眠：";
    cell.shuimianLabel2.text = [self.shuimianString isEqualToString:@""] ? @"正常" : self.shuimianString;
    cell.yinshiLabel1.text = @"饮食：";
    cell.yinshiLabel2.text = [self.yinshiString isEqualToString:@""] ? @"正常" : self.yinshiString;
    cell.yinshuiLabel1.text = @"饮水：";
    cell.yinshuiLabel2.text = [self.yinshuiString isEqualToString:@""] ? @"不口渴" : self.yinshuiString;
    cell.dabianLabel1.text = @"大便：";
    cell.dabianLabel2_1.text = self.dabian1;
    cell.dabianLabel2_2.text = self.dabian2;
    cell.dabianLabel2_3.text = self.dabian3;
    cell.xiaobianLabel1.text = @"小便：";
    cell.xiaobianLabel2_1.text = self.xiaobian1;
    cell.xiaobianLabel2_2.text = self.xiaobian2;
    cell.hanreLabel1.text = @"寒热：";
    cell.hanreLabel2.text = self.hanreStringFix;
    cell.tiwenLabel1.text = @"体温：";
    cell.tiwenLabel2.text = self.tiwenStringFix;
    cell.chuhanLabel1.text = @"出汗：";
    cell.chuhanLabel2.text = self.chuhanStringFix;
    cell.zhaopianLabel1.text = @"照片资料：";
    if ([self.healthListDetailPhotoArray[indexPath.section] isEqualToString:@""]) {
        cell.zhaopianLabel2.hidden = NO;
        cell.zhaopianLabel2.text = @"无";
    }else{
        cell.zhaopianLabel2.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sourceVC isEqualToString:@"QuestionInquiryViewController"]) {
        if (self.healthListDelegate && [self.healthListDelegate respondsToSelector:@selector(healthListChoosed:time:type:)]) {
            [self.healthListDelegate healthListChoosed:self.healthListDetailIdArray[indexPath.section] time:self.healthListDetailTimeArray[indexPath.section] type:@"健康自查"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendHealthListDetailRequest{
    DLog(@"sendTestResultListRequest");
    
    self.currentPage = 1;
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_LIST_DETAIL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self healthListDetailDataParse];
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
-(void)healthListDetailDataParse{
    self.healthListDetailArray = [HealthListDetailData mj_objectArrayWithKeyValuesArray:self.data];
    [self.healthListDetailIdArray removeAllObjects];
    [self.healthListDetailTimeArray removeAllObjects];
    [self.healthListDetailResultArray removeAllObjects];
    [self.healthListDetailPhotoArray removeAllObjects];
    for (HealthListDetailData *healthListDetailData in self.healthListDetailArray) {
        [self.healthListDetailIdArray addObject:[NullUtil judgeStringNull:healthListDetailData.q_healthy_id]];
        [self.healthListDetailTimeArray addObject:[NullUtil judgeStringNull:healthListDetailData.create_date]];
        [self.healthListDetailResultArray addObject:[NullUtil judgeStringNull:healthListDetailData.results]];
        [self.healthListDetailPhotoArray addObject:[NullUtil judgeStringNull:healthListDetailData.photos]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

@end
