//
//  TestResultDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestResultDetailViewController.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "SNChart.h"

@interface TestResultDetailViewController ()<SNChartDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *main_result;
@property (strong,nonatomic)NSString *trend_result;

@property (assign,nonatomic)NSInteger a_score;
@property (assign,nonatomic)NSInteger b_score;
@property (assign,nonatomic)NSInteger c_score;
@property (assign,nonatomic)NSInteger d_score;
@property (assign,nonatomic)NSInteger e_score;
@property (assign,nonatomic)NSInteger f_score;
@property (assign,nonatomic)NSInteger g_score;
@property (assign,nonatomic)NSInteger h_score;
@property (assign,nonatomic)NSInteger i_score;

@property (strong,nonatomic)NSString *tt_description;
@property (strong,nonatomic)NSString *tt_point;

@property (strong,nonatomic)NSString *vegetables;

@property (strong,nonatomic)NSString *tt_rule;

@property (strong,nonatomic)NSString *tt_prescription;
@property (strong,nonatomic)NSString *lzjj;

@end

@implementation TestResultDetailViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"TestResultDetailViewController"];
    
    DLog(@"%@",self.resultId);
    [self sendTestResultDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"TestResultDetailViewController"];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"体质测试结果详情";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_result_detail_share_button"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 85+10+190+10+250+10+260+10+90+10);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initBackView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 85+10, SCREEN_WIDTH, 190)];
    self.backView2.backgroundColor = kWHITE_COLOR;
//    [self initBackView2];
    [self.scrollView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 85+10+190+10, SCREEN_WIDTH, 250)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initBackView3];
    [self.scrollView addSubview:self.backView3];
    
    self.backView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 85+10+190+10+250+10, SCREEN_WIDTH, 260)];
    self.backView4.backgroundColor = kWHITE_COLOR;
    [self initBackView4];
    [self.scrollView addSubview:self.backView4];
    
    self.backView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 85+10+190+10+250+10+260+10, SCREEN_WIDTH, 90)];
    self.backView5.backgroundColor = kWHITE_COLOR;
    [self initBackView5];
    [self.scrollView addSubview:self.backView5];
}

-(void)initBackView1{
    self.label1_1 = [[UILabel alloc] init];
//    self.label1_1.text = @"您的体质是：";
    [self.backView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
//    self.label1_2.text = @"阳虚质";
    self.label1_2.textColor = kMAIN_COLOR;
    self.label1_2.font = [UIFont systemFontOfSize:20];
    [self.backView1 addSubview:self.label1_2];
    
    self.label1_3 = [[UILabel alloc] init];
//    self.label1_3.text = @"倾向湿热质、阴虚质。";
    self.label1_3.textColor = kLIGHT_GRAY_COLOR;
    [self.backView1 addSubview:self.label1_3];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(10);
        make.top.equalTo(self.backView1).offset(20);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(110);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(0);
        make.bottom.equalTo(self.backView1).offset(-20);
        make.width.mas_equalTo(SCREEN_WIDTH-10);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView2{
    SNChart *chart = [[SNChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.backView2.frame.size.height) withDataSource:self andChatStyle:SNChartStyleBar];
    [chart showInView:self.backView2];
}

-(void)initBackView3{
    self.label3_1 = [[UILabel alloc] init];
//    self.label3_1.text = @"您的体质是";
    [self.backView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
//    self.label3_2.text = @"阳虚质";
    self.label3_2.textColor = kMAIN_COLOR;
    [self.backView3 addSubview:self.label3_2];
    
    self.label3_3 = [[UILabel alloc] init];
//    self.label3_3.text = @"（倾向阴虚质）";
    self.label3_3.textColor = kLIGHT_GRAY_COLOR;
    [self.backView3 addSubview:self.label3_3];
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.lineView3];
    
    self.label3_4 = [[UILabel alloc] init];
//    self.label3_4.text = @"阳虚质的人平时比较怕冷，手脚常冰冷，口唇的颜色也较白，不爱说话，而且睡眠也偏多。";
    self.label3_4.textColor = kLIGHT_GRAY_COLOR;
    self.label3_4.font = [UIFont systemFontOfSize:13];
    self.label3_4.numberOfLines = 0;
    [self.backView3 addSubview:self.label3_4];
    
    self.label3_5 = [[UILabel alloc] init];
//    self.label3_5.text = @"(1)温阳佐以养阴：根据阴阳互根的理论，在温壮元阳的同时，佐入适量补阴之品，如熟地、山茱萸等，以达阳得阴助而生化无穷。阳虚者，可阳损及阴，导致阴阳两虚，用药要阴阳相顾，切忌温阳太过，耗血伤津，转现燥热。因此，调理阳虚质时要慢温、慢补，缓缓调治。(2)温阳兼顾脾胃：调治阳虚之质，有益气、补火之别，除温壮元阳外，当兼顾脾胃，只有脾胃健运，始能饮食多进，化源不绝，体质强健，亦即养后天以济先天。";
    self.label3_5.textColor = kLIGHT_GRAY_COLOR;
    self.label3_5.font = [UIFont systemFontOfSize:13];
    self.label3_5.numberOfLines = 0;
    [self.backView3 addSubview:self.label3_5];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(10);
        make.top.equalTo(self.backView3).offset(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(110);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(100);
        make.centerY.equalTo(self.label3_2).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label3_1).offset(15+10);
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(10);
        make.trailing.equalTo(self.backView3).offset(-10);
        make.top.equalTo(self.lineView3).offset(1+10);
        make.height.mas_equalTo(60);
    }];
    
    [self.label3_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(10);
        make.trailing.equalTo(self.backView3).offset(-10);
        make.top.equalTo(self.label3_4).offset(60);
        make.bottom.equalTo(self.backView3).offset(-10);
    }];
}

-(void)initBackView4{
    self.label4_1 = [[UILabel alloc] init];
//    self.label4_1.text = @"养生食疗建议";
    [self.backView4 addSubview:self.label4_1];
    
    self.lineView4 = [[UILabel alloc] init];
    self.lineView4.backgroundColor = kBACKGROUND_COLOR;
    [self.backView4 addSubview:self.lineView4];
    
    self.label4_2 = [[UILabel alloc] init];
//    self.label4_2.text = @"刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n刀豆-----种出温暖的元阳种子\n南瓜-----集天地阳力于一身的“太阳战车”\n韭菜-----补足你的活力\n生姜-----热辣“还魂草”\n黄豆芽-----激起心中的斗志\n椒类-----送你冬天里的一把火\n茼蒿-----生命力顽强的安心菜";
    self.label4_2.textColor = kLIGHT_GRAY_COLOR;
    self.label4_2.font = [UIFont systemFontOfSize:13];
    self.label4_2.numberOfLines = 0;
    [self.backView4 addSubview:self.label4_2];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView4).offset(10);
        make.top.equalTo(self.backView4).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView4).offset(0);
        make.trailing.equalTo(self.backView4).offset(0);
        make.top.equalTo(self.label4_1).offset(15+10);
        make.height.mas_equalTo(1);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView4).offset(10);
        make.trailing.equalTo(self.backView4).offset(-10);
        make.top.equalTo(self.lineView4).offset(1+10);
        make.bottom.equalTo(self.backView4).offset(-10);
    }];
}

-(void)initBackView5{
    self.label5_1 = [[UILabel alloc] init];
//    self.label5_1.text = @"养生食疗建议";
    [self.backView5 addSubview:self.label5_1];
    
    self.lineView5 = [[UIView alloc] init];
    self.lineView5.backgroundColor = kBACKGROUND_COLOR;
    [self.backView5 addSubview:self.lineView5];
    
    self.label5_2 = [[UILabel alloc] init];
//    self.label5_2.text = @"调味法则：补肾温阳，益火之源。";
    self.label5_2.textColor = kLIGHT_GRAY_COLOR;
    self.label5_2.font = [UIFont systemFontOfSize:13];
    self.label5_2.numberOfLines = 0;
    [self.backView5 addSubview:self.label5_2];
    
    [self.label5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView5).offset(10);
        make.top.equalTo(self.backView5).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView5).offset(0);
        make.trailing.equalTo(self.backView5).offset(0);
        make.top.equalTo(self.label5_1).offset(15+10);
        make.height.mas_equalTo(1);
    }];
    
    [self.label5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView5).offset(10);
        make.trailing.equalTo(self.backView5).offset(-10);
        make.top.equalTo(self.lineView5).offset(1+10);
        make.bottom.equalTo(self.backView5).offset(-10);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark SNChartDataSource
-(NSArray *)chatConfigYValue:(SNChart *)chart{
//    return @[@"100",@"100",@"70",@"30",@"50",@"14",@"5",@"14",@"5"];
    return @[@"100",[NSString stringWithFormat:@"%ld",(long)self.a_score],[NSString stringWithFormat:@"%ld",(long)self.b_score],[NSString stringWithFormat:@"%ld",(long)self.c_score],[NSString stringWithFormat:@"%ld",(long)self.d_score],[NSString stringWithFormat:@"%ld",(long)self.e_score],[NSString stringWithFormat:@"%ld",(long)self.f_score],[NSString stringWithFormat:@"%ld",(long)self.g_score],[NSString stringWithFormat:@"%ld",(long)self.h_score],[NSString stringWithFormat:@"%ld",(long)self.i_score]];
}

-(NSArray *)chatConfigXValue:(SNChart *)chart{
//    return @[@"满分",@"阳虚质",@"阴虚质",@"气虚质",@"痰湿质",@"湿热质",@"血瘀质",@"气郁质",@"特禀质",@"平和质"];
    return @[@"满分",@"阳虚质",@"阴虚质",@"气虚质",@"痰湿质",@"湿热质",@"血瘀质",@"特禀质",@"气郁质",@"平和质"];
}

#pragma mark Target Action
-(void)shareButtonClicked{
    DLog(@"shareButtonClicked");
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"56df91e4e0f55a811e002783"
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能"
                                         shareImage:[UIImage imageNamed:@"default_image_small"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,nil]
                                           delegate:self];
}

#pragma mark Network Request
-(void)sendTestResultDetailRequest{
    DLog(@"sendTestResultListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.resultId forKey:@"analy_result_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_RESULT_DETAIL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self testResultDetailDataParse];
        }else{
            DLog(@"%@",self.message);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)testResultDetailDataParse{
    self.main_result = [NullUtil judgeStringNull:[self.data objectForKey:@"main_result"]];
    self.trend_result = [NullUtil judgeStringNull:[self.data objectForKey:@"trend_result"]];
    
    self.a_score = [[self.data objectForKey:@"a_score"] integerValue];
    self.b_score = [[self.data objectForKey:@"b_score"] integerValue];
    self.c_score = [[self.data objectForKey:@"c_score"] integerValue];
    self.d_score = [[self.data objectForKey:@"d_score"] integerValue];
    self.e_score = [[self.data objectForKey:@"e_score"] integerValue];
    self.f_score = [[self.data objectForKey:@"f_score"] integerValue];
    self.g_score = [[self.data objectForKey:@"g_score"] integerValue];
    self.h_score = [[self.data objectForKey:@"h_score"] integerValue];
    self.i_score = [[self.data objectForKey:@"i_score"] integerValue];
    
    self.tt_prescription = [NullUtil judgeStringNull:[self.data objectForKey:@"description"]];
    self.tt_point = [NullUtil judgeStringNull:[self.data objectForKey:@"tt_point"]];
    
    self.vegetables = [NullUtil judgeStringNull:[self.data objectForKey:@"vegetables"]];
    
    self.tt_rule = [NullUtil judgeStringNull:[self.data objectForKey:@"tt_rule"]];
    
    self.tt_prescription = [NullUtil judgeStringNull:[self.data objectForKey:@"tt_prescription"]];
    self.lzjj = [NullUtil judgeStringNull:[self.data objectForKey:@"lzjj"]];
    
    [self testResultDetailDataFilling];
}

#pragma mark Data Filling
-(void)testResultDetailDataFilling{
    self.label1_1.text = @"您的体质是：";
    self.label1_2.text = self.main_result;
    self.label1_3.text = [NSString stringWithFormat:@"倾向%@",self.trend_result];
    
    [self initBackView2];
    
    self.label3_1.text = @"您的体质是：";
    self.label3_2.text = self.main_result;
    self.label3_3.text = [NSString stringWithFormat:@"(倾向%@)",self.trend_result];
    self.label3_4.text = [NSString stringWithFormat:@"%@%@",self.main_result,self.tt_prescription];
    self.label3_5.text = self.tt_point;
    
    self.label4_1.text = @"养生食疗建议";
    self.label4_2.text = self.vegetables;
    
    self.label5_1.text = @"养生治疗建议";
    self.label5_2.text = [NSString stringWithFormat:@"调味法则：%@",self.tt_rule];
}

@end
