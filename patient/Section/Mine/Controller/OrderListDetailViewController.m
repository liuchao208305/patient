//
//  OrderListDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "OrderListDetailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "LoginViewController.h"

@interface OrderListDetailViewController ()

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSString *doctorImageString;
@property (strong,nonatomic)NSString *doctorName;
@property (strong,nonatomic)NSString *doctorTitle;
@property (assign,nonatomic)double doctorMoney;
@property (strong,nonatomic)NSString *doctorTime;
@property (strong,nonatomic)NSString *doctorAddress;

@property (strong,nonatomic)NSString *patientName;
@property (assign,nonatomic)int patientSex;
@property (strong,nonatomic)NSString *patientAge;
@property (strong,nonatomic)NSString *patientIdNumber;
@property (strong,nonatomic)NSString *patientPhone;

@property (strong,nonatomic)NSString *patientProblem;
@property (strong,nonatomic)NSString *patientJiwangshi;
@property (strong,nonatomic)NSString *patientShoushushi;
@property (strong,nonatomic)NSString *patientGuominshi;
@property (strong,nonatomic)NSString *patientJiazushi;
@property (strong,nonatomic)NSString *patientTestTime;
@property (strong,nonatomic)NSString *patientZhutizhi;
@property (strong,nonatomic)NSString *patientPiantizhi;

@property (strong,nonatomic)NSString *inspectionTime;
@property (strong,nonatomic)NSString *inspectionResult;
@property (strong,nonatomic)NSString *shuimianString;
@property (strong,nonatomic)NSString *yinshiString;
@property (strong,nonatomic)NSString *yinshuiString;
@property (strong,nonatomic)NSString *dabiancishu;
@property (strong,nonatomic)NSString *dabianBianmi;
@property (strong,nonatomic)NSString *dabianXiexie;
@property (strong,nonatomic)NSString *dabianChengxing;
@property (strong,nonatomic)NSString *dabianBianzhi;
@property (strong,nonatomic)NSString *dabianFeel;
@property (strong,nonatomic)NSString *xiaobiancishu1;
@property (strong,nonatomic)NSString *xiaobiancishu2;
@property (strong,nonatomic)NSString *xiaobiansezhi;
@property (strong,nonatomic)NSString *xiaobianFeel;
@property (strong,nonatomic)NSString *hanreString;
@property (strong,nonatomic)NSString *tiwenString;
@property (strong,nonatomic)NSString *chuhanString;
@property (strong,nonatomic)NSString *photoString;

@property (strong,nonatomic)NSString *bianzhengString;
@property (strong,nonatomic)NSString *bianbingString;
@property (strong,nonatomic)NSString *shexiangString;
@property (strong,nonatomic)NSString *maixiangString;

@property (strong,nonatomic)NSString *fuyaofangfa;
@property (strong,nonatomic)NSString *fuyaoshijian;
@property (strong,nonatomic)NSString *fuyaocishu;


@end

@implementation OrderListDetailViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"OrderListDetailViewController"];
    
    [self sendOrderDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"OrderListDetailViewController"];
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
    self.title = @"预约详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    DLog(@"scrollViewClicked");
}

#pragma mark Network Request
-(void)sendOrderDetailRequest{
    DLog(@"sendOrderDetailRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.orderId forKey:@"conID"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_DETAIL_INFORMATION_FIX] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_BOOK_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self orderDetailDataParse];
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

#pragma mark Data Parse
-(void)orderDetailDataParse{
    self.doctorImageString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"heand_url"]];
    self.doctorName = [NullUtil judgeStringNull:[self.data1 objectForKey:@"doctor_name"]];
    self.doctorTitle = [NullUtil judgeStringNull:[self.data1 objectForKey:@"title_name"]];
    self.doctorMoney = [[self.data1 objectForKey:@"price"] doubleValue];
    self.doctorTime = [NullUtil judgeStringNull:[self.data1 objectForKey:@"bespoke_date"]];
    self.doctorAddress = [NullUtil judgeStringNull:[self.data1 objectForKey:@"address"]];
    
    self.patientName = [NullUtil judgeStringNull:[self.data1 objectForKey:@"name"]];
    self.patientSex = [[self.data1 objectForKey:@"sex"] intValue];
    self.patientAge = [NullUtil judgeStringNull:[self.data1 objectForKey:@"age"]];
    self.patientIdNumber = [NullUtil judgeStringNull:[self.data1 objectForKey:@"ID_no"]];
    self.patientPhone = [NullUtil judgeStringNull:[self.data1 objectForKey:@"phone"]];
    
    self.patientProblem = [NullUtil judgeStringNull:[self.data1 objectForKey:@"complain"]];
    self.patientJiwangshi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"a_history"]];
    self.patientShoushushi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"b_history"]];
    self.patientGuominshi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"c_history"]];
    self.patientJiazushi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"d_history"]];
    
    self.patientTestTime = [NullUtil judgeStringNull:[self.data1 objectForKey:@"tizhi_date"]];
    self.patientZhutizhi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"main_result"]];
    self.patientPiantizhi = [NullUtil judgeStringNull:[self.data1 objectForKey:@"trend_result"]];
    
    self.inspectionTime = [NullUtil judgeStringNull:[self.data1 objectForKey:@"healthy_date"]];
    self.inspectionResult = [NullUtil judgeStringNull:[self.data1 objectForKey:@"results"]];
    
    self.bianzhengString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"dialec"]];
    self.bianbingString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"disease"]];
    self.shexiangString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"tongue"]];
    self.maixiangString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"pulse"]];
    
    self.fuyaofangfa = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medication"]];
    self.fuyaoshijian = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medication_date"]];
    self.fuyaocishu = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medicationC"]];
    
    [self orderDetailDataFilling];
}

#pragma mark Data Filling
-(void)orderDetailDataFilling{
    
}

@end
