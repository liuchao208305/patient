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
#import "AdaptionUtil.h"
#import "LoginViewController.h"
#import "HealthListDetailData.h"
#import "HealthListDetailTableCell.h"
#import "MRZhaopianCollectionCell.h"
#import "xPhotoViewController.h"

@interface HealthListDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

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
@property (strong,nonatomic)NSString *xiaobian1Fix;
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

@property (strong,nonatomic)NSString *daixia;
@property (strong,nonatomic)NSString *yuejing1;
@property (strong,nonatomic)NSString *yuejing2;
@property (strong,nonatomic)NSString *yuejing3;
@property (strong,nonatomic)NSString *yuejing4;
@property (strong,nonatomic)NSString *yuejing5;
@property (strong,nonatomic)NSString *yuejing6;
@property (strong,nonatomic)NSString *yuejing7;
@property (strong,nonatomic)NSString *yuejing8;

@property (strong,nonatomic)NSString *daixiaqiweiStatus;
@property (strong,nonatomic)NSString *daixiaqiweiString;
@property (strong,nonatomic)NSString *daixiaqiweiStringFix;
@property (strong,nonatomic)NSString *daixiazhidiStatus;
@property (strong,nonatomic)NSString *daixiazhidiString;
@property (strong,nonatomic)NSString *daixiazhidiStringFix;
@property (strong,nonatomic)NSString *daixiayanseString;
@property (strong,nonatomic)NSString *yuejingmociString;
@property (strong,nonatomic)NSString *yuejingjuejingStatus;
@property (strong,nonatomic)NSString *yuejingjuejingStatusFix;
@property (strong,nonatomic)NSString *yuejingbijingStatus;
@property (strong,nonatomic)NSString *yuejingbijingString;
@property (strong,nonatomic)NSString *yuejingbijingStringFix;
@property (strong,nonatomic)NSString *yuejingchuchaoString;
@property (strong,nonatomic)NSString *yuejingzhouqiString;
@property (strong,nonatomic)NSString *yuejingtianshuString;
@property (strong,nonatomic)NSString *yuejingjingliangStatus;
@property (strong,nonatomic)NSString *yuejingjingliangString;
@property (strong,nonatomic)NSString *yuejingjingliangStringFix;
@property (strong,nonatomic)NSString *yuejingzhidiStatus;
@property (strong,nonatomic)NSString *yuejingzhidiString;
@property (strong,nonatomic)NSString *yuejingzhidiStringFix;
@property (strong,nonatomic)NSString *yuejingyanseString;
@property (strong,nonatomic)NSString *yuejingqitaStatus;
@property (strong,nonatomic)NSString *yuejingqitaString;
@property (strong,nonatomic)NSString *yuejingqitaStringFix;

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
    CGFloat height = 0;
    if ([NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]].count > 0) {
        if ([NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]].count<=3) {
            if (![self.healthListDetailPhotoArray[indexPath.section] isEqualToString:@""]) {
                height= SCREEN_WIDTH/3;
            }
        } else if ([NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]].count <=6) {
            height= SCREEN_WIDTH/3*2;
        } else if ([NSMutableArray arrayWithArray:[self.healthListDetailPhotoArray[indexPath.section] componentsSeparatedByString:@","]].count <=9) {
            height= SCREEN_WIDTH/3*3;
        } else {
            height= SCREEN_WIDTH/3*3;
        }
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
        if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
            return 440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 10 + height +20;
        }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
            return 440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 10 + height;
        }
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
        if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
            return 440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 230 + 10 + height;
        }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
            return 440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 210 + 10 + height;
        }
    }
    return 0;
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
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
        if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
            [cell initViewWithPhotoArray:zhaopianArray originHeight:(440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 20 + 10) photoString:self.healthListDetailPhotoArray[indexPath.section]];
        }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
            [cell initViewWithPhotoArray:zhaopianArray originHeight:(440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 10) photoString:self.healthListDetailPhotoArray[indexPath.section]];
        }
    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
        if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
            [cell initViewWithPhotoArray:zhaopianArray originHeight:(440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 220 + 10) photoString:self.healthListDetailPhotoArray[indexPath.section]];
        }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
            [cell initViewWithPhotoArray:zhaopianArray originHeight:(440 + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"a_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]] fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_val"]] fontSize:13 width:SCREEN_WIDTH-70]+ [StringUtil cellWithStr:[NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]] fontSize:13 width:SCREEN_WIDTH-70] + 200 + 10) photoString:self.healthListDetailPhotoArray[indexPath.section]];
        }
        
    }
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
    /********************************************************************************/
    self.daixiaqiweiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"j_status"]];
    self.daixiaqiweiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"j_val"]];
    self.daixiazhidiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"k_status"]];
    self.daixiazhidiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"k_val"]];
    self.daixiayanseString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"l_color"]];
    self.yuejingmociString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"p_endDate"]];
    self.yuejingjuejingStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"m_status"]];
    self.yuejingbijingStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_status"]];
    self.yuejingbijingString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"n_val"]];
    self.yuejingchuchaoString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"o_age"]];
    self.yuejingzhouqiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"p_val"]];
    self.yuejingtianshuString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"q_val"]];
    self.yuejingjingliangStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"r_status"]];
    self.yuejingjingliangString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"r_val"]];
    self.yuejingzhidiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"s_status"]];
    self.yuejingzhidiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"s_val"]];
    self.yuejingyanseString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"t_color"]];
    self.yuejingqitaStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_status"]];
    self.yuejingqitaString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"u_val"]];
    /********************************************************************************/
    self.hanreStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"v_status"]];
    self.hanreString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"v_val"]];
    self.tiwenStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"w_status"]];
    self.tiwenString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"w_val"]];
    self.chuhanStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_status"]];
    self.chuhanString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]];
    
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
    
    self.xiaobian1 = [NSString stringWithFormat:@"白天%@次，晚上%@次",self.xiaobianBaitianString,self.xiaobianWanshangString];
    self.xiaobian1Fix = [NSString stringWithFormat:@"色质:%@",self.sezhiStringFix];
    self.xiaobian2 = [NSString stringWithFormat:@"排尿感:%@",self.paibianganStringFix];
    
    if ([self.daixiaqiweiStatus intValue] == 1) {
        self.daixiaqiweiStringFix = @"正常";
    }else if ([self.daixiaqiweiStatus intValue]== 2){
        self.daixiaqiweiStringFix = self.daixiaqiweiString;
    }
    
    if ([self.daixiazhidiStatus intValue] == 1) {
        self.daixiazhidiStringFix = @"正常";
    }else if ([self.daixiazhidiStatus intValue]== 2){
        self.daixiazhidiStringFix = self.daixiazhidiString;
    }
    
    self.daixia = [NSString stringWithFormat:@"气味:%@ 质地:%@ 颜色:%@",self.daixiaqiweiStringFix,self.daixiazhidiStringFix,self.daixiayanseString];
    
    self.yuejing1 = [NSString stringWithFormat:@"末次月经:%@",self.yuejingmociString];
    if ([self.yuejingjuejingStatus intValue] == 2) {
        self.yuejingjuejingStatusFix = @"否";
    }else if ([self.yuejingjuejingStatus intValue]== 1){
        self.yuejingjuejingStatusFix = @"是";
    }
    self.yuejing2 = [NSString stringWithFormat:@"绝经:%@",self.yuejingjuejingStatusFix];
    if ([self.yuejingbijingStatus intValue] == 2) {
        self.yuejingbijingStringFix = @"否";
    }else if ([self.yuejingbijingStatus intValue]== 1){
        self.yuejingbijingStringFix = self.yuejingbijingString;
    }
    self.yuejing3 = [NSString stringWithFormat:@"闭经:%@",self.yuejingbijingStringFix];
    self.yuejing4 = [NSString stringWithFormat:@"初潮年龄:%@岁",self.yuejingchuchaoString];
    self.yuejing5 = [NSString stringWithFormat:@"月经周期:%@天",self.yuejingzhouqiString];
    self.yuejing6 = [NSString stringWithFormat:@"持续天数:%@天",self.yuejingtianshuString];
    if ([self.yuejingjingliangStatus intValue] == 1) {
        self.yuejingjingliangStringFix = @"正常";
    }else if ([self.yuejingjingliangStatus intValue]== 2){
        self.yuejingjingliangStringFix = self.yuejingjingliangString;
    }
    if ([self.yuejingzhidiStatus intValue] == 1) {
        self.yuejingzhidiStringFix = @"正常";
    }else if ([self.yuejingzhidiStatus intValue]== 2){
        self.yuejingzhidiStringFix = self.yuejingzhidiString;
    }
    self.yuejing7 = [NSString stringWithFormat:@"经量:%@ 质地:%@ 颜色:%@",self.yuejingjingliangStringFix,self.yuejingzhidiStringFix,self.yuejingyanseString];
    if ([self.yuejingqitaStatus intValue] == 1) {
        self.yuejingqitaStringFix = self.yuejingqitaString;
    }else if ([self.yuejingqitaStatus intValue]== 2){
        self.yuejingqitaStringFix = @"无";
    }
    self.yuejing8 = [NSString stringWithFormat:@"其他症状:%@",self.yuejingqitaStringFix];
    
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
    cell.xiaobianLabel2_1Fix.text = self.xiaobian1Fix;
    cell.xiaobianLabel2_2.text = self.xiaobian2;
    /*******************************************************/
    cell.daixiaLabel1.text = @"带下：";
    cell.daixiaLabel2.text = self.daixia;
    cell.yuejingLabel1.text = @"月经：";
    cell.yuejingLabel2_1.text = self.yuejing1;
    cell.yuejingLabel2_2.text = self.yuejing2;
    cell.yuejingLabel2_3.text = self.yuejing3;
    cell.yuejingLabel2_4.text = self.yuejing4;
    cell.yuejingLabel2_5.text = self.yuejing5;
    cell.yuejingLabel2_6.text = self.yuejing6;
    cell.yuejingLabel2_7.text = self.yuejing7;
    cell.yuejingLabel2_8.text = self.yuejing8;
    /********************************************************/
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
            [self.healthListDelegate healthListChoosed:self.healthListDetailIdArray[indexPath.section] time:[self.healthListDetailTimeArray[indexPath.section] substringToIndex:10] type:@"健康自查"];
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
