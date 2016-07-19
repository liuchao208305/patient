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
#import "StringUtil.h"
#import "LoginViewController.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

#import "MRZhaopianCollectionCell.h"
#import "xPhotoViewController.h"
#import "MRChufangTableCell.h"
#import "MRChufangData.h"

@interface OrderListDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UIActionSheetDelegate>

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

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSString *doctorImageString;
@property (strong,nonatomic)NSString *doctorName;
@property (strong,nonatomic)NSString *doctorTitle;
@property (assign,nonatomic)double doctorMoney;
@property (strong,nonatomic)NSString *doctorTime;
@property (strong,nonatomic)NSString *doctorAddress;

@property (strong,nonatomic)NSString *patientName;
@property (assign,nonatomic)int patientSex;
@property (assign,nonatomic)int patientAge;
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
@property (strong,nonatomic)NSString *healthResultString;
@property (strong,nonatomic)NSDictionary *healthResultDictionary;
@property (strong,nonatomic)NSString *complain;
@property (strong,nonatomic)NSString *shuimianStatus;
@property (strong,nonatomic)NSString *shuimianString;
@property (strong,nonatomic)NSString *shuimianStringFix;
@property (strong,nonatomic)NSString *yinshiStatus;
@property (strong,nonatomic)NSString *yinshiString;
@property (strong,nonatomic)NSString *yinshiStringFix;
@property (strong,nonatomic)NSString *yinshuiStatus;
@property (strong,nonatomic)NSString *yinshuiString;
@property (strong,nonatomic)NSString *yinshuiStringFix;

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
@property (strong,nonatomic)NSMutableArray *photoArray;

@property (strong,nonatomic)NSString *bianzhengString;
@property (strong,nonatomic)NSString *bianbingString;
@property (strong,nonatomic)NSString *shexiangString;
@property (strong,nonatomic)NSString *maixiangString;

@property (strong,nonatomic)NSString *fuyaofangfa;
@property (strong,nonatomic)NSString *fuyaoshijian;
@property (strong,nonatomic)NSString *fuyaocishu;

@property (assign,nonatomic)NSInteger paymentType;

@property (strong,nonatomic)NSString *paymentInfomation;

@property (strong,nonatomic)NSString *alipayMomo;
@property (strong,nonatomic)NSString *alipayResult;
@property (strong,nonatomic)NSString *alipayResultStatus;

@property (strong,nonatomic)NSMutableDictionary *payinfo;
@property (strong,nonatomic)NSString *appid;
@property (strong,nonatomic)NSString *noncestr;
@property (strong,nonatomic)NSString *package;
@property (strong,nonatomic)NSString *partnerid;
@property (strong,nonatomic)NSString *prepayid;
@property (strong,nonatomic)NSString *sign;
@property (nonatomic, assign)UInt32 timeStamp;

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
//    [self initView];
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.photoArray = [NSMutableArray array];
    
    self.chufangArray = [NSMutableArray array];
    self.chufangNameArray = [NSMutableArray array];
    self.chufangQuantityArray = [NSMutableArray array];
    self.chufangUnitArray = [NSMutableArray array];
    self.chufangUsageArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"预约详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    if (self.orderType == 1) {
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消预约" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }else if (self.orderType == 2){
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消预约" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 4.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 3.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 3*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.doctorBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    self.doctorBackView.backgroundColor = kWHITE_COLOR;
    [self initDoctorSubView];
    [self.scrollView addSubview:self.doctorBackView];
    
    self.patientBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10, SCREEN_WIDTH, 120)];
    self.patientBackView1.backgroundColor = kWHITE_COLOR;
    [self initPatientSubView1];
    [self.scrollView addSubview:self.patientBackView1];
    
    self.patientBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120, SCREEN_WIDTH, 195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24])];
    self.patientBackView2.backgroundColor = ColorWithHexRGB(0xf8f8f8);
    [self initPatientSubView2];
    [self.scrollView addSubview:self.patientBackView2];
    
    if (![[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
            if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24], SCREEN_WIDTH, 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 20)];
            }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24], SCREEN_WIDTH, 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70])];
            }
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
            if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24], SCREEN_WIDTH, 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 230)];
            }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24], SCREEN_WIDTH, 470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 210)];
            }
            
        }
        //    self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24], SCREEN_WIDTH, 650)];
        self.patientBackView3.backgroundColor = kWHITE_COLOR;
        [self initPatientSubView3];
        [self.scrollView addSubview:self.patientBackView3];
    }
    
    
    if (self.orderType == 1) {
        self.payButton = [[UIButton alloc] init];
        [self.payButton setTitle:@"支付" forState:UIControlStateNormal];
        [self.payButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.payButton setBackgroundColor:kMAIN_COLOR];
        [self.payButton addTarget:self action:@selector(payButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.payButton];
        
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
                make.top.equalTo(self.patientBackView2.mas_bottom).offset(20);
            }else{
                make.top.equalTo(self.patientBackView3.mas_bottom).offset(20);
            }
            make.leading.equalTo(self.scrollView).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
    }else if (self.orderType == 2){
        
    }else if (self.orderType == 3){
//        self.diagnoseBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10, SCREEN_WIDTH, 140)];
        self.diagnoseBackView = [[UIView alloc] init];
        self.diagnoseBackView.backgroundColor = kWHITE_COLOR;
        [self initDiagnoseSubView];
        [self.scrollView addSubview:self.diagnoseBackView];
        
        [self.diagnoseBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.scrollView).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            if ([[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
                make.top.equalTo(self.patientBackView2.mas_bottom).offset(10);
            }else{
                make.top.equalTo(self.patientBackView3.mas_bottom).offset(10);
            }
            make.height.mas_equalTo(140);
        }];
        
        if (![[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
                if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                    self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24]+470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70], SCREEN_WIDTH, 160) style:UITableViewStylePlain];
                }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                    self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24]+470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70], SCREEN_WIDTH, 160) style:UITableViewStylePlain];
                }
            }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
                if ([AdaptionUtil isIphoneFour] ||[AdaptionUtil isIphoneFive]) {
                    self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24]+470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 230, SCREEN_WIDTH, 160) style:UITableViewStylePlain];
                }else if ([AdaptionUtil isIphoneSix] ||[AdaptionUtil isIphoneSixPlus]){
                    self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24]+470 + [StringUtil cellWithStr:self.complain fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.shuimianString fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingbijingStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.yuejingqitaStringFix fontSize:13 width:SCREEN_WIDTH-70] + [StringUtil cellWithStr:self.chuhanStringFix fontSize:13 width:SCREEN_WIDTH-70] + 210, SCREEN_WIDTH, 160) style:UITableViewStylePlain];
                }
            }
        }else{
            self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+195+[StringUtil cellWithStr:self.patientProblem fontSize:14 width:SCREEN_WIDTH-24]+10+140+10, SCREEN_WIDTH, 160) style:UITableViewStylePlain];
        }
//        self.prescriptionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10+140+10, SCREEN_WIDTH, 160) style:UITableViewStylePlain];
        self.prescriptionTableView.delegate = self;
        self.prescriptionTableView.dataSource = self;
        self.prescriptionTableView.showsVerticalScrollIndicator = YES;
        self.prescriptionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.scrollView addSubview:self.prescriptionTableView];

//        self.medicineBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10+140+10+160+10, SCREEN_WIDTH, 145)];
        self.medicineBackView = [[UIView alloc] init];
        self.medicineBackView.backgroundColor = kWHITE_COLOR;
        [self initMedicineSubView];
        [self.scrollView addSubview:self.medicineBackView];
        
        [self.medicineBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.scrollView).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.top.equalTo(self.prescriptionTableView.mas_bottom).offset(10);
            make.height.mas_equalTo(145);
        }];
    }
}

-(void)initDoctorSubView{
    self.doctorImageView = [[UIImageView alloc] init];
    self.doctorImageView.layer.cornerRadius = 33;
    [self.doctorBackView addSubview:self.doctorImageView];
    
    self.doctorNameLabel = [[UILabel alloc] init];
    self.doctorNameLabel.font = [UIFont systemFontOfSize:16];
    [self.doctorBackView addSubview:self.doctorNameLabel];
    
    self.doctorTitleLabel = [[UILabel alloc] init];
    self.doctorTitleLabel.font = [UIFont systemFontOfSize:14];
    self.doctorTitleLabel.textColor = ColorWithHexRGB(0x909090);
    [self.doctorBackView addSubview:self.doctorTitleLabel];
    
    self.doctorMoneyLabel1 = [[UILabel alloc] init];
    self.doctorMoneyLabel1.font = [UIFont systemFontOfSize:12];
    self.doctorMoneyLabel1.textColor = kMAIN_COLOR;
    [self.doctorBackView addSubview:self.doctorMoneyLabel1];
    
    self.doctorMoneyLabel2 = [[UILabel alloc] init];
    self.doctorMoneyLabel2.font = [UIFont systemFontOfSize:20];
    self.doctorMoneyLabel2.textColor = kMAIN_COLOR;
    [self.doctorBackView addSubview:self.doctorMoneyLabel2];
    
    self.doctorMoneyLabel3 = [[UILabel alloc] init];
    self.doctorMoneyLabel3.font = [UIFont systemFontOfSize:13];
    self.doctorMoneyLabel3.textColor = kMAIN_COLOR;
    [self.doctorBackView addSubview:self.doctorMoneyLabel3];
    
    self.doctorTimeLabel1 = [[UILabel alloc] init];
    self.doctorTimeLabel1.font = [UIFont systemFontOfSize:14];
    [self.doctorBackView addSubview:self.doctorTimeLabel1];
    
    self.doctorTimeLabel2 = [[UILabel alloc] init];
    self.doctorTimeLabel2.font = [UIFont systemFontOfSize:13];
    self.doctorTimeLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.doctorBackView addSubview:self.doctorTimeLabel2];
    
    self.doctorAddressLabel1 = [[UILabel alloc] init];
    self.doctorAddressLabel1.font = [UIFont systemFontOfSize:14];
    [self.doctorBackView addSubview:self.doctorAddressLabel1];
    
    self.doctorAddressLabel2 = [[UILabel alloc] init];
    self.doctorAddressLabel2.font = [UIFont systemFontOfSize:13];
    self.doctorAddressLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.doctorBackView addSubview:self.doctorAddressLabel2];
    
    [self.doctorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.doctorBackView).offset(12);
        make.top.equalTo(self.doctorBackView).offset(16);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(66);
    }];
    
    [self.doctorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.doctorImageView).offset(0);
        make.leading.equalTo(self.doctorImageView.mas_trailing).offset(11);
    }];
    
    [self.doctorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.doctorNameLabel.mas_trailing).offset(22);
//        make.centerY.equalTo(self.doctorNameLabel).offset(0);
        make.leading.equalTo(self.doctorNameLabel).offset(0);
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(5);
    }];
    
    [self.doctorMoneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorMoneyLabel2.mas_leading).offset(-2);
        make.bottom.equalTo(self.doctorMoneyLabel2).offset(0);
    }];
    
    [self.doctorMoneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorMoneyLabel3.mas_leading).offset(-2);
        make.centerY.equalTo(self.doctorNameLabel).offset(0);
    }];
    
    [self.doctorMoneyLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorBackView).offset(-12);
        make.bottom.equalTo(self.doctorMoneyLabel2).offset(0);
    }];
    
    [self.doctorTimeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.doctorTitleLabel).offset(0);
        make.top.equalTo(self.doctorTitleLabel.mas_bottom).offset(8);
    }];
    
    [self.doctorTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorBackView).offset(-12);
        make.centerY.equalTo(self.doctorTimeLabel1).offset(0);
    }];
    
    [self.doctorAddressLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.doctorTimeLabel1).offset(0);
        make.top.equalTo(self.doctorTimeLabel1.mas_bottom).offset(8);
    }];
    
    [self.doctorAddressLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorBackView).offset(-12);
        make.centerY.equalTo(self.doctorAddressLabel1).offset(0);
    }];
}

-(void)initPatientSubView1{
    self.patientNameLabel1 = [[UILabel alloc] init];
    [self.patientBackView1 addSubview:self.patientNameLabel1];
    
    self.patientNameLabel2 = [[UILabel alloc] init];
    self.patientNameLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView1 addSubview:self.patientNameLabel2];
    
    self.patientSexLabel = [[UILabel alloc] init];
    self.patientSexLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView1 addSubview:self.patientSexLabel];
    
    self.patientAgeLabel = [[UILabel alloc] init];
    self.patientAgeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView1 addSubview:self.patientAgeLabel];
    
    self.patientLineView1 = [[UIView alloc] init];
    self.patientLineView1.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.patientBackView1 addSubview:self.patientLineView1];
    
    self.patientIdNumberLabel1 = [[UILabel alloc] init];
    [self.patientBackView1 addSubview:self.patientIdNumberLabel1];
    
    self.patientIdNumberLabel2 = [[UILabel alloc] init];
    self.patientIdNumberLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView1 addSubview:self.patientIdNumberLabel2];
    
    self.patientLineView2 = [[UIView alloc] init];
    self.patientLineView2.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.patientBackView1 addSubview:self.patientLineView2];
    
    self.patientPhoneLabel1 = [[UILabel alloc] init];
    [self.patientBackView1 addSubview:self.patientPhoneLabel1];
    
    self.patientPhoneLabel2 = [[UILabel alloc] init];
    self.patientPhoneLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView1 addSubview:self.patientPhoneLabel2];
    
    self.patientLineView3 = [[UIView alloc] init];
    self.patientLineView3.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.patientBackView1 addSubview:self.patientLineView3];
    
    [self.patientNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(12);
        make.top.equalTo(self.patientBackView1).offset(10);
    }];
    
    [self.patientNameLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientNameLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientNameLabel1).offset(0);
    }];
    
    [self.patientSexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientNameLabel2.mas_trailing).offset(30);
        make.centerY.equalTo(self.patientNameLabel1).offset(0);
    }];
    
    [self.patientAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.patientBackView1).offset(-12);
        make.centerY.equalTo(self.patientNameLabel1).offset(0);
    }];
    
    [self.patientLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(0);
        make.trailing.equalTo(self.patientBackView1).offset(0);
        make.top.equalTo(self.patientNameLabel1.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientIdNumberLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(12);
        make.top.equalTo(self.patientLineView1.mas_bottom).offset(10);
    }];
    
    [self.patientIdNumberLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.patientBackView1).offset(-12);
        make.centerY.equalTo(self.patientIdNumberLabel1).offset(0);
    }];
    
    [self.patientLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(0);
        make.trailing.equalTo(self.patientBackView1).offset(0);
        make.top.equalTo(self.patientIdNumberLabel1.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientPhoneLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(12);
        make.top.equalTo(self.patientLineView2.mas_bottom).offset(10);
    }];
    
    [self.patientPhoneLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.patientBackView1).offset(-12);
        make.centerY.equalTo(self.patientPhoneLabel1).offset(0);
    }];
    
    [self.patientLineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView1).offset(0);
        make.trailing.equalTo(self.patientBackView1).offset(0);
        make.top.equalTo(self.patientPhoneLabel1.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
}

-(void)initPatientSubView2{
    self.patientProblemLabel = [[UILabel alloc] init];
    self.patientProblemLabel.numberOfLines = 0;
    self.patientProblemLabel.font = [UIFont systemFontOfSize:14];
    self.patientProblemLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientProblemLabel];
    
    self.patientLineView4 = [[UIView alloc] init];
    self.patientLineView4.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.patientBackView2 addSubview:self.patientLineView4];
    
    self.patientJiwangshiLabel = [[UILabel alloc] init];
    self.patientJiwangshiLabel.font = [UIFont systemFontOfSize:13];
    self.patientJiwangshiLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientJiwangshiLabel];
    
    self.patientShoushushiLabel = [[UILabel alloc] init];
    self.patientShoushushiLabel.font = [UIFont systemFontOfSize:13];
    self.patientShoushushiLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientShoushushiLabel];
    
    self.patientGuominshiLabel = [[UILabel alloc] init];
    self.patientGuominshiLabel.font = [UIFont systemFontOfSize:13];
    self.patientGuominshiLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientGuominshiLabel];
    
    self.patientJiazushiLabel = [[UILabel alloc] init];
    self.patientJiazushiLabel.font = [UIFont systemFontOfSize:13];
    self.patientJiazushiLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientJiazushiLabel];
    
    self.patientLineView5 = [[UIView alloc] init];
    self.patientLineView5.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.patientBackView2 addSubview:self.patientLineView5];
    
    self.patientTestLabel = [[UILabel alloc] init];
    self.patientTestLabel.font = [UIFont systemFontOfSize:14];
    self.patientTestLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView2 addSubview:self.patientTestLabel];
    
    self.patientLineView6 = [[UIView alloc] init];
    self.patientLineView6.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.patientBackView2 addSubview:self.patientLineView6];
    
    [self.patientProblemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.trailing.equalTo(self.patientBackView2).offset(-12);
        make.top.equalTo(self.patientBackView2).offset(12);
    }];
    
    [self.patientLineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(0);
        make.trailing.equalTo(self.patientBackView2).offset(0);
        make.top.equalTo(self.patientProblemLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientJiwangshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.top.equalTo(self.patientLineView4.mas_bottom).offset(12);
    }];
    
    [self.patientShoushushiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.patientBackView2).offset(-12);
//        make.centerY.equalTo(self.patientJiwangshiLabel).offset(0);
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.top.equalTo(self.patientJiwangshiLabel.mas_bottom).offset(15);
    }];
    
    [self.patientGuominshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.patientBackView2).offset(12);
//        make.top.equalTo(self.patientJiwangshiLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.top.equalTo(self.patientShoushushiLabel.mas_bottom).offset(15);
    }];
    
    [self.patientJiazushiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.patientBackView2).offset(-12);
//        make.centerY.equalTo(self.patientGuominshiLabel).offset(0);
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.top.equalTo(self.patientGuominshiLabel.mas_bottom).offset(15);
    }];
    
    [self.patientLineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(0);
        make.trailing.equalTo(self.patientBackView2).offset(0);
        make.top.equalTo(self.patientJiazushiLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientTestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.top.equalTo(self.patientLineView5.mas_bottom).offset(15);
    }];
    
    [self.patientLineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(0);
        make.trailing.equalTo(self.patientBackView2).offset(0);
        make.top.equalTo(self.patientTestLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
}

-(void)initPatientSubView3{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.timeLabel];
    
    self.complainLabel1 = [[UILabel alloc] init];
    self.complainLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.complainLabel1];
    
    self.complainLabel2 = [[UILabel alloc] init];
    self.complainLabel2.numberOfLines = 0;
    self.complainLabel2.font = [UIFont systemFontOfSize:13];
    self.complainLabel2.textColor = ColorWithHexRGB(0x909090);
    self.complainLabel2.textAlignment = NSTextAlignmentLeft;
    [self.patientBackView3 addSubview:self.complainLabel2];
    
    self.compalainLineView = [[UIView alloc] init];
    self.compalainLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.compalainLineView];
    
    self.shuimianLabel1 = [[UILabel alloc] init];
    self.shuimianLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.shuimianLabel1];
    
    self.shuimianLabel2 = [[UILabel alloc] init];
    self.shuimianLabel2.numberOfLines = 0;
    self.shuimianLabel2.font = [UIFont systemFontOfSize:13];
    self.shuimianLabel2.textColor = ColorWithHexRGB(0x909090);
    self.shuimianLabel2.textAlignment = NSTextAlignmentLeft;
    [self.patientBackView3 addSubview:self.shuimianLabel2];
    
    self.shuimianLineView = [[UIView alloc] init];
    self.shuimianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.shuimianLineView];
    
    self.yinshiLabel1 = [[UILabel alloc] init];
    self.yinshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.yinshiLabel1];
    
    self.yinshiLabel2 = [[UILabel alloc] init];
    self.yinshiLabel2.font = [UIFont systemFontOfSize:13];
    self.yinshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.yinshiLabel2];
    
    self.yinshiLineView = [[UIView alloc] init];
    self.yinshiLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.yinshiLineView];
    
    self.yinshuiLabel1 = [[UILabel alloc] init];
    self.yinshuiLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.yinshuiLabel1];
    
    self.yinshuiLabel2 = [[UILabel alloc] init];
    self.yinshuiLabel2.font = [UIFont systemFontOfSize:13];
    self.yinshuiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.yinshuiLabel2];
    
    self.yinshuiLineView = [[UIView alloc] init];
    self.yinshuiLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.yinshuiLineView];
    
    self.dabianLabel1 = [[UILabel alloc] init];
    self.dabianLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.dabianLabel1];
    
    self.dabianLabel2_1 = [[UILabel alloc] init];
    self.dabianLabel2_1.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_1.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.dabianLabel2_1];
    
    self.dabianLabel2_2 = [[UILabel alloc] init];
    self.dabianLabel2_2.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.dabianLabel2_2];
    
    self.dabianLabel2_3 = [[UILabel alloc] init];
    self.dabianLabel2_3.font = [UIFont systemFontOfSize:13];
    self.dabianLabel2_3.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.dabianLabel2_3];
    
    self.dabianImageView = [[UIImageView alloc] init];
    [self.patientBackView3 addSubview:self.dabianImageView];
    
    self.dabianLineView = [[UIView alloc] init];
    self.dabianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.dabianLineView];
    
    self.xiaobianLabel1 = [[UILabel alloc] init];
    self.xiaobianLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.xiaobianLabel1];
    
    self.xiaobianLabel2_1 = [[UILabel alloc] init];
    self.xiaobianLabel2_1.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_1.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.xiaobianLabel2_1];
    
    self.xiaobianLabel2_1Fix = [[UILabel alloc] init];
    self.xiaobianLabel2_1Fix.numberOfLines = 0;
    self.xiaobianLabel2_1Fix.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_1Fix.textColor = ColorWithHexRGB(0x909090);
    self.xiaobianLabel2_1Fix.textAlignment = NSTextAlignmentLeft;
    [self.patientBackView3 addSubview:self.xiaobianLabel2_1Fix];
    
    self.xiaobianLabel2_2 = [[UILabel alloc] init];
    self.xiaobianLabel2_2.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.xiaobianLabel2_2];
    
    self.xiaobianLineView = [[UIView alloc] init];
    self.xiaobianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.xiaobianLineView];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2) {
        /******************************************************/
        self.daixiaLabel1 = [[UILabel alloc] init];
        self.daixiaLabel1.font = [UIFont systemFontOfSize:14];
        [self.patientBackView3 addSubview:self.daixiaLabel1];
        
        self.daixiaLabel2 = [[UILabel alloc] init];
        self.daixiaLabel2.font = [UIFont systemFontOfSize:13];
        self.daixiaLabel2.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.daixiaLabel2];
        
        self.daixiaLineView = [[UIView alloc] init];
        self.daixiaLineView.backgroundColor = kBACKGROUND_COLOR;
        [self.patientBackView3 addSubview:self.daixiaLineView];
        
        self.yuejingLabel1 = [[UILabel alloc] init];
        self.yuejingLabel1.font = [UIFont systemFontOfSize:14];
        [self.patientBackView3 addSubview:self.yuejingLabel1];
        
        self.yuejingLabel2_1 = [[UILabel alloc] init];
        self.yuejingLabel2_1.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_1.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_1];
        
        self.yuejingLabel2_2 = [[UILabel alloc] init];
        self.yuejingLabel2_2.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_2.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_2];
        
        self.yuejingLabel2_3 = [[UILabel alloc] init];
        self.yuejingLabel2_3.numberOfLines = 0;
        self.yuejingLabel2_3.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_3.textColor = ColorWithHexRGB(0x909090);
        self.yuejingLabel2_3.textAlignment = NSTextAlignmentLeft;
        [self.patientBackView3 addSubview:self.yuejingLabel2_3];
        
        self.yuejingLabel2_4 = [[UILabel alloc] init];
        self.yuejingLabel2_4.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_4.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_4];
        
        self.yuejingLabel2_5 = [[UILabel alloc] init];
        self.yuejingLabel2_5.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_5.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_5];
        
        self.yuejingLabel2_6 = [[UILabel alloc] init];
        self.yuejingLabel2_6.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_6.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_6];
        
        self.yuejingLabel2_7 = [[UILabel alloc] init];
        self.yuejingLabel2_7.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_7.textColor = ColorWithHexRGB(0x909090);
        [self.patientBackView3 addSubview:self.yuejingLabel2_7];
        
        self.yuejingLabel2_8 = [[UILabel alloc] init];
        self.yuejingLabel2_8.numberOfLines = 0;
        self.yuejingLabel2_8.font = [UIFont systemFontOfSize:13];
        self.yuejingLabel2_8.textColor = ColorWithHexRGB(0x909090);
        self.yuejingLabel2_8.textAlignment = NSTextAlignmentLeft;
        [self.patientBackView3 addSubview:self.yuejingLabel2_8];
        
        self.yuejingLineView = [[UIView alloc] init];
        self.yuejingLineView.backgroundColor = kBACKGROUND_COLOR;
        [self.patientBackView3 addSubview:self.yuejingLineView];
        /*******************************************************/
    }
    
    self.hanreLabel1 = [[UILabel alloc] init];
    self.hanreLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.hanreLabel1];
    
    self.hanreLabel2 = [[UILabel alloc] init];
    self.hanreLabel2.font = [UIFont systemFontOfSize:13];
    self.hanreLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.hanreLabel2];
    
    self.hanreLineView = [[UIView alloc] init];
    self.hanreLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.hanreLineView];
    
    self.tiwenLabel1 = [[UILabel alloc] init];
    self.tiwenLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.tiwenLabel1];
    
    self.tiwenLabel2 = [[UILabel alloc] init];
    self.tiwenLabel2.font = [UIFont systemFontOfSize:13];
    self.tiwenLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.tiwenLabel2];
    
    self.tiwenLineView = [[UIView alloc] init];
    self.tiwenLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.tiwenLineView];
    
    self.chuhanLabel1 = [[UILabel alloc] init];
    self.chuhanLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.chuhanLabel1];
    
    self.chuhanLabel2 = [[UILabel alloc] init];
    self.chuhanLabel2.numberOfLines = 0;
    self.chuhanLabel2.font = [UIFont systemFontOfSize:13];
    self.chuhanLabel2.textColor = ColorWithHexRGB(0x909090);
    self.chuhanLabel2.textAlignment = NSTextAlignmentLeft;
    [self.patientBackView3 addSubview:self.chuhanLabel2];
    
    self.chuhanLineView = [[UIView alloc] init];
    self.chuhanLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.chuhanLineView];
    
    self.zhaopianLabel1 = [[UILabel alloc] init];
    self.zhaopianLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.zhaopianLabel1];
    
    self.zhaopianLabel2 = [[UILabel alloc] init];
    self.zhaopianLabel2.font = [UIFont systemFontOfSize:13];
    self.zhaopianLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.zhaopianLabel2];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.patientBackView3).offset(15);
    }];
    
    [self.complainLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
    }];
    
    [self.complainLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.complainLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.complainLabel1).offset(0);
    }];
    
    [self.compalainLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.complainLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.shuimianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.compalainLineView.mas_bottom).offset(12);
    }];
    
    [self.shuimianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shuimianLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.shuimianLabel1).offset(0);
    }];
    
    [self.shuimianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.shuimianLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.yinshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.shuimianLineView.mas_bottom).offset(12);
    }];
    
    [self.yinshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.yinshiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.yinshiLabel1).offset(0);
    }];
    
    [self.yinshiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.yinshiLabel1.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.yinshuiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.yinshiLineView.mas_bottom).offset(12);
    }];
    
    [self.yinshuiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.yinshuiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.yinshuiLabel1).offset(0);
    }];
    
    [self.yinshuiLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.yinshuiLabel1.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.dabianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.yinshuiLineView.mas_bottom).offset(12);
    }];
    
    [self.dabianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.dabianLabel1).offset(0);
    }];
    
    [self.dabianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_1).offset(0);
        make.top.equalTo(self.dabianLabel2_1.mas_bottom).offset(10);
    }];
    
    [self.dabianLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_2).offset(0);
        make.top.equalTo(self.dabianLabel2_2.mas_bottom).offset(10);
    }];
    
    [self.dabianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dabianLabel2_3.mas_trailing).offset(5);
        make.centerY.equalTo(self.dabianLabel2_3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    [self.dabianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.dabianLabel2_3.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.xiaobianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.dabianLineView.mas_bottom).offset(12);
    }];
    
    [self.xiaobianLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.xiaobianLabel1).offset(0);
    }];
    
    [self.xiaobianLabel2_1Fix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel2_1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.xiaobianLabel2_1.mas_bottom).offset(10);
    }];
    
    [self.xiaobianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel2_1Fix).offset(0);
        make.top.equalTo(self.xiaobianLabel2_1Fix.mas_bottom).offset(10);
    }];
    
    [self.xiaobianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.xiaobianLabel2_2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    /********************************************************************/
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
        [self.daixiaLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.patientBackView3).offset(12);
            make.top.equalTo(self.xiaobianLineView.mas_bottom).offset(12);
        }];
        
        [self.daixiaLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.daixiaLabel1.mas_trailing).offset(10);
            make.centerY.equalTo(self.daixiaLabel1).offset(0);
        }];
        
        [self.daixiaLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.patientBackView3).offset(0);
            make.trailing.equalTo(self.patientBackView3).offset(0);
            make.top.equalTo(self.daixiaLabel2.mas_bottom).offset(12);
            make.height.mas_equalTo(1);
        }];
        
        [self.yuejingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.patientBackView3).offset(12);
            make.top.equalTo(self.daixiaLineView.mas_bottom).offset(12);
        }];
        
        [self.yuejingLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel1.mas_trailing).offset(10);
            make.centerY.equalTo(self.yuejingLabel1).mas_offset(0);
        }];
        
        [self.yuejingLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_1).offset(0);
            make.top.equalTo(self.yuejingLabel2_1.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_2).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 70);
            make.top.equalTo(self.yuejingLabel2_2.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_3).offset(0);
            make.top.equalTo(self.yuejingLabel2_3.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_4).offset(0);
            make.top.equalTo(self.yuejingLabel2_4.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_5).offset(0);
            make.top.equalTo(self.yuejingLabel2_5.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_6).offset(0);
            make.top.equalTo(self.yuejingLabel2_6.mas_bottom).offset(10);
        }];
        
        [self.yuejingLabel2_8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.yuejingLabel2_7).offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 70);
            make.top.equalTo(self.yuejingLabel2_7.mas_bottom).offset(10);
        }];
        
        [self.yuejingLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.patientBackView3).offset(0);
            make.trailing.equalTo(self.patientBackView3).offset(0);
            make.top.equalTo(self.yuejingLabel2_8.mas_bottom).offset(12);
            make.height.mas_equalTo(1);
        }];
    }
    /********************************************************************/
    
    [self.hanreLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 1) {
            make.top.equalTo(self.xiaobianLineView.mas_bottom).offset(12);
        }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userSex] intValue] == 2){
            make.top.equalTo(self.yuejingLineView.mas_bottom).offset(12);
        }
    }];
    
    [self.hanreLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.hanreLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.hanreLabel1).offset(0);
    }];
    
    [self.hanreLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.hanreLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.tiwenLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.hanreLineView.mas_bottom).offset(12);
    }];
    
    [self.tiwenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.tiwenLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.tiwenLabel1).offset(0);
    }];
    
    [self.tiwenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.tiwenLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.chuhanLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.tiwenLineView.mas_bottom).offset(12);
    }];
    
    [self.chuhanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.chuhanLabel1.mas_trailing).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-70);
        make.top.equalTo(self.chuhanLabel1).offset(0);
    }];
    
    [self.chuhanLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.chuhanLabel2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.zhaopianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.chuhanLineView.mas_bottom).offset(12);
    }];
    
    [self.zhaopianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.zhaopianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.zhaopianLabel1).offset(0);
    }];
    
//    if (self.photoArray.count > 0) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.minimumLineSpacing = 5;
//        flowLayout.minimumInteritemSpacing = 5;
//        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3-10, SCREEN_WIDTH/3-10);
//        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//        
//        CGFloat height = 0;
//        if (self.photoArray.count<=3) {
//            height= SCREEN_WIDTH/3;
//        } else if (self.photoArray.count <=6) {
//            height= SCREEN_WIDTH/3*2;
//        } else if (self.photoArray.count <=9) {
//            height= SCREEN_WIDTH/3*3;
//        } else {
//            height= SCREEN_WIDTH/3*3;
//        }
//        
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,480, SCREEN_WIDTH, height) collectionViewLayout:flowLayout];
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.scrollEnabled = NO;
//        collectionView.backgroundColor = [UIColor whiteColor];
//        [self.patientBackView3 addSubview:collectionView];
//        [collectionView registerClass:[MRZhaopianCollectionCell class] forCellWithReuseIdentifier:@"MRZhaopianCollectionCell"];
//    }
}

-(void)initDiagnoseSubView{
    self.diagnoseTitleLabel = [[UILabel alloc] init];
    self.diagnoseTitleLabel.textColor = ColorWithHexRGB(0x909090);
    [self.diagnoseBackView addSubview:self.diagnoseTitleLabel];
    
    self.bianzhengLabel1 = [[UILabel alloc] init];
    self.bianzhengLabel1.font = [UIFont systemFontOfSize:14];
    [self.diagnoseBackView addSubview:self.bianzhengLabel1];
    
    self.bianzhengLabel2 = [[UILabel alloc] init];
    self.bianzhengLabel2.font = [UIFont systemFontOfSize:14];
    self.bianzhengLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.diagnoseBackView addSubview:self.bianzhengLabel2];
    
    self.bianbingLabel1 = [[UILabel alloc] init];
    self.bianbingLabel1.font = [UIFont systemFontOfSize:14];
    [self.diagnoseBackView addSubview:self.bianbingLabel1];
    
    self.bianbingLabel2 = [[UILabel alloc] init];
    self.bianbingLabel2.font = [UIFont systemFontOfSize:14];
    self.bianbingLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.diagnoseBackView addSubview:self.bianbingLabel2];
    
    self.shexiangLabel1 = [[UILabel alloc] init];
    self.shexiangLabel1.font = [UIFont systemFontOfSize:14];
    [self.diagnoseBackView addSubview:self.shexiangLabel1];
    
    self.shexiangLabel2 = [[UILabel alloc] init];
    self.shexiangLabel2.font = [UIFont systemFontOfSize:14];
    self.shexiangLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.diagnoseBackView addSubview:self.shexiangLabel2];
    
    self.maixiangLabel1 = [[UILabel alloc] init];
    self.maixiangLabel1.font = [UIFont systemFontOfSize:14];
    [self.diagnoseBackView addSubview:self.maixiangLabel1];
    
    self.maixiangLabel2 = [[UILabel alloc] init];
    self.maixiangLabel2.font = [UIFont systemFontOfSize:14];
    self.maixiangLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.diagnoseBackView addSubview:self.maixiangLabel2];
    
    [self.diagnoseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diagnoseBackView).offset(12);
        make.top.equalTo(self.diagnoseBackView).offset(10);
    }];
    
    [self.bianzhengLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diagnoseBackView).offset(12);
        make.top.equalTo(self.diagnoseTitleLabel.mas_bottom).offset(10);
    }];
    
    [self.bianzhengLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bianzhengLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.bianzhengLabel1).offset(0);
    }];
    
    [self.bianbingLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diagnoseBackView).offset(12);
        make.top.equalTo(self.bianzhengLabel1.mas_bottom).offset(8);
    }];
    
    [self.bianbingLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bianbingLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.bianbingLabel1).offset(0);
    }];
    
    [self.shexiangLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diagnoseBackView).offset(12);
        make.top.equalTo(self.bianbingLabel1.mas_bottom).offset(8);
    }];
    
    [self.shexiangLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shexiangLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.shexiangLabel1).offset(0);
    }];
    
    [self.maixiangLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diagnoseBackView).offset(12);
        make.top.equalTo(self.shexiangLabel1.mas_bottom).offset(8);
    }];
    
    [self.maixiangLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.maixiangLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.maixiangLabel1).offset(0);
    }];
}

-(void)initMedicineSubView{
    self.medicineTitleLabel = [[UILabel alloc] init];
    self.medicineTitleLabel.textColor = ColorWithHexRGB(0x909090);
    [self.medicineBackView addSubview:self.medicineTitleLabel];
    
    self.fuyaofangfaLabel1 = [[UILabel alloc] init];
    self.fuyaofangfaLabel1.font = [UIFont systemFontOfSize:14];
    [self.medicineBackView addSubview:self.fuyaofangfaLabel1];
    
    self.fuyaofangfaLabel2 = [[UILabel alloc] init];
    self.fuyaofangfaLabel2.font = [UIFont systemFontOfSize:14];
    self.fuyaofangfaLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.medicineBackView addSubview:self.fuyaofangfaLabel2];
    
    self.fuyaoshijianLabel1 = [[UILabel alloc] init];
    self.fuyaoshijianLabel1.font = [UIFont systemFontOfSize:14];
    [self.medicineBackView addSubview:self.fuyaoshijianLabel1];
    
    self.fuyaoshijianLabel2 = [[UILabel alloc] init];
    self.fuyaoshijianLabel2.font = [UIFont systemFontOfSize:14];
    self.fuyaoshijianLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.medicineBackView addSubview:self.fuyaoshijianLabel2];
    
    self.fuyaocishuLabel1 = [[UILabel alloc] init];
    self.fuyaocishuLabel1.font = [UIFont systemFontOfSize:14];
    [self.medicineBackView addSubview:self.fuyaocishuLabel1];
    
    self.fuyaocishuLabel2 = [[UILabel alloc] init];
    self.fuyaocishuLabel2.font = [UIFont systemFontOfSize:14];
    self.fuyaocishuLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.medicineBackView addSubview:self.fuyaocishuLabel2];
    
    [self.medicineTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.medicineBackView).offset(12);
        make.top.equalTo(self.medicineBackView).offset(15);
    }];
    
    [self.fuyaofangfaLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.medicineBackView).offset(12);
        make.top.equalTo(self.medicineTitleLabel.mas_bottom).offset(15);
    }];
    
    [self.fuyaofangfaLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fuyaofangfaLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.fuyaofangfaLabel1).offset(0);
    }];
    
    [self.fuyaoshijianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.medicineBackView).offset(12);
        make.top.equalTo(self.fuyaofangfaLabel1.mas_bottom).offset(10);
    }];
    
    [self.fuyaoshijianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fuyaoshijianLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.fuyaoshijianLabel1).offset(0);
    }];
    
    [self.fuyaocishuLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.medicineBackView).offset(12);
        make.top.equalTo(self.fuyaoshijianLabel1.mas_bottom).offset(10);
    }];
    
    [self.fuyaocishuLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fuyaocishuLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.fuyaocishuLabel1).offset(10);
    }];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    DLog(@"scrollViewClicked");
}

-(void)cancelButtonClicked{
    DLog(@"cancelButtonClicked");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要取消吗？" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alert show];
}

-(void)payButtonClicked:(UIButton *)sender{
    DLog(@"allButtonClicked");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择支付方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"支付宝支付", @"微信支付",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //支付宝支付
        self.paymentType = 1;
        [self sendPayNowInfoRequest:self.orderId payType:self.paymentType];
    }else if (buttonIndex == 1){
        //微信支付
        self.paymentType = 2;
        [self sendPayNowInfoRequest:self.orderId payType:self.paymentType];
    }else if (buttonIndex == 2){
        //取消
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1){
        [self sendCancelTreatmentRequest];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chufangArray.count == 0 ? 2: self.chufangArray.count+2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MRChufangTableCell";
    MRChufangTableCell *cell = [self.prescriptionTableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MRChufangTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"建议处方";
        cell.label1.hidden = YES;
        cell.label2.hidden = YES;
        cell.label3.hidden = YES;
        cell.label4.hidden = YES;
    }else if (indexPath.row == 1){
        cell.titleLabel.hidden = YES;
        cell.backgroundColor = ColorWithHexRGB(0xf5f5f5);
        cell.label1.text = @"药名";
        cell.label2.text = @"剂量";
        cell.label3.text = @"规格";
        cell.label4.text = @"用法";
    }else{
        for (int i = 2; i<self.chufangArray.count+2; i++) {
            if (indexPath.row == i){
                cell.titleLabel.hidden = YES;
                cell.label1.text = self.chufangNameArray[indexPath.row-2];
                cell.label2.text = self.chufangQuantityArray[indexPath.row-2];
                cell.label3.text = self.chufangUnitArray[indexPath.row-2];
                cell.label4.text = self.chufangUsageArray[indexPath.row-2];
            }
        }
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.photoArray.count>0){
        if (self.photoArray.count>9){
            return 9;
        }else{
            return self.photoArray.count;
        }
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MRZhaopianCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MRZhaopianCollectionCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    xPhotoViewController *photoViewController = [[xPhotoViewController alloc] init];
    photoViewController.index = indexPath.row;
    photoViewController.photoPaths = self.photoArray;
    
    [self.navigationController pushViewController:photoViewController animated:YES];
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

-(void)sendCancelTreatmentRequest{
    DLog(@"sendCancelTreatmentRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.orderId forKey:@"consult_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_TREATMENT_CANCEL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"取消成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
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

-(void)sendPayNowInfoRequest:(NSString *)orderId payType:(NSInteger)payType{
    DLog(@"sendPayNowInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:orderId forKey:@"consult_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)payType] forKey:@"pay_type"];
    
    DLog(@"%@%@",kServerAddressPay,kJZK_TREATMENT_DETAIL_INFORMATION_PAYNOW);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_ORDER_LIST_PAY] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            if (self.paymentType == 1) {
                [self paymentInfoAliPayDataParse];
            }else if (self.paymentType == 2){
                [self paymentInfoWechatPayDataParse];
            }
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
    self.patientAge = [[self.data1 objectForKey:@"age"] intValue];
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
    
    if (![[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
        self.healthResultString = [self.data1 objectForKey:@"results"];
        self.healthResultDictionary = [StringUtil dictionaryWithJsonString:self.healthResultString];
        self.complain = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"a_val"]];
        self.shuimianStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"b_status"]];
        self.shuimianString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"b_val"]];
        self.yinshiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"c_status"]];
        self.yinshiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"c_val"]];
        self.yinshuiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"d_status"]];
        self.yinshuiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"d_val"]];
        self.dabianCishu = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_val"]];
        self.bianmiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isBM"]];
        self.xiexieStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isXM"]];
        self.chengxingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"e_isCX"]];
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
        /********************************************************************************/
        self.daixiaqiweiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"j_status"]];
        self.daixiaqiweiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"j_val"]];
        self.daixiazhidiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"k_status"]];
        self.daixiazhidiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"k_val"]];
        self.daixiayanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"l_color"]];
        self.yuejingmociString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"p_endDate"]];
        self.yuejingjuejingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"m_status"]];
        self.yuejingbijingStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"n_status"]];
        self.yuejingbijingString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"n_val"]];
        self.yuejingchuchaoString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"o_age"]];
        self.yuejingzhouqiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"p_val"]];
        self.yuejingtianshuString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"q_val"]];
        self.yuejingjingliangStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"r_status"]];
        self.yuejingjingliangString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"r_val"]];
        self.yuejingzhidiStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"s_status"]];
        self.yuejingzhidiString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"s_val"]];
        self.yuejingyanseString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"t_color"]];
        self.yuejingqitaStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"u_status"]];
        self.yuejingqitaString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"u_val"]];
        /********************************************************************************/
        self.hanreStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"v_status"]];
        self.hanreString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"v_val"]];
        self.tiwenStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"w_status"]];
        self.tiwenString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"w_val"]];
        self.chuhanStatus = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"x_status"]];
        self.chuhanString = [NullUtil judgeStringNull:[self.healthResultDictionary objectForKey:@"x_val"]];
        
        if ([self.shuimianStatus intValue] == 1) {
            self.shuimianStringFix = @"正常";
        }else if ([self.shuimianStatus intValue]== 2){
            self.shuimianStringFix = self.shuimianString;
        }
        
        if ([self.yinshiStatus intValue] == 1) {
            self.yinshiStringFix = @"正常";
        }else if ([self.yinshiStatus intValue]== 2){
            self.yinshiStringFix = self.yinshiString;
        }
        
        if ([self.yinshuiStatus intValue] == 1) {
            self.yinshuiStringFix = self.yinshuiString;
        }else if ([self.yinshuiStatus intValue]== 2){
            self.yinshuiStringFix = @"不口渴";
        }
        
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
        
        self.dabian1 = [NSString stringWithFormat:@"每天%@次   便秘:%@   泄泻:%@   成形:%@",self.dabianCishu,self.bianmiString,self.xiexieString,self.chengxingString];
        self.dabian2 = [NSString stringWithFormat:@"便质:%@   排便感:%@",self.bianzhiStringFix,self.paibianganStringFix];
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
        
        self.xiaobian1 = [NSString stringWithFormat:@"白天%@次,晚上%@次",self.xiaobianBaitianString,self.xiaobianWanshangString];
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
            self.tiwenStringFix = [NSString stringWithFormat:@"%@℃",self.tiwenString];
        }
        
        if ([self.chuhanStatus intValue] == 1) {
            self.chuhanStringFix = @"正常";
        }else if ([self.chuhanStatus intValue]== 2){
            self.chuhanStringFix = self.chuhanString;
        }
    }
    self.healthPhotoString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"healthyPhotos"]];
    self.photoArray = [NSMutableArray arrayWithArray:[self.healthPhotoString componentsSeparatedByString:@","]];
    
    self.bianzhengString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"dialec"]];
    self.bianbingString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"disease"]];
    self.shexiangString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"tongue"]];
    self.maixiangString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"pulse"]];
    
    if (![[self.data1 objectForKey:@"details"] isKindOfClass:[NSNull class]]){
        self.chufangArray = [MRChufangData mj_objectArrayWithKeyValuesArray:[self.data1 objectForKey:@"details"]];
        [self.chufangNameArray removeAllObjects];
        [self.chufangQuantityArray removeAllObjects];
        [self.chufangUnitArray removeAllObjects];
        [self.chufangUsageArray removeAllObjects];
        for (MRChufangData *chufangData in self.chufangArray) {
            [self.chufangNameArray addObject:chufangData.storage_id];
            [self.chufangQuantityArray addObject:chufangData.dose];
            [self.chufangUnitArray addObject:chufangData.unit];
            [self.chufangUsageArray addObject:chufangData.uses];
        }
    }
    
    self.fuyaofangfa = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medication"]];
    self.fuyaoshijian = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medication_date"]];
    self.fuyaocishu = [NullUtil judgeStringNull:[self.data1 objectForKey:@"medicationC"]];
    
    [self initView];
    
    [self orderDetailDataFilling];
}

-(void)paymentInfoAliPayDataParse{
    self.paymentInfomation = [self.data3 objectForKey:@"payinfo"];
    
    NSString *appScheme = @"alipaytest";
    
    [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"resultDic-->%@",resultDic);
        self.alipayMomo = [resultDic objectForKey:@"memo"];
        self.alipayResult = [resultDic objectForKey:@"result"];
        self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
        
        if ([self.alipayResultStatus integerValue] == 9000) {
            //支付成功
            [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
            
        }else if ([self.alipayResultStatus integerValue] == 8000){
            //支付结果确认中
            [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
        }else{
            //支付失败
            [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
        }
        
        [self sendOrderDetailRequest];
    }];
}

-(void)paymentInfoWechatPayDataParse{
    self.payinfo = [self.data3 objectForKey:@"payinfo"];
    self.appid = [self.payinfo objectForKey:@"appid"];
    self.noncestr = [self.payinfo objectForKey:@"noncestr"];
    self.package = [self.payinfo objectForKey:@"package"];
    self.partnerid = [self.payinfo objectForKey:@"partnerid"];
    self.prepayid = [self.payinfo objectForKey:@"prepayid"];
    self.sign = [self.payinfo objectForKey:@"sign"];
    self.timeStamp = [[self.payinfo objectForKey:@"timestamp"] intValue];
    
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = self.appid;
    req.partnerId           = self.partnerid;
    req.prepayId            = self.prepayid;
    req.nonceStr            = self.noncestr;
    req.timeStamp           = self.timeStamp;
    req.package             = self.package;
    req.sign                = self.sign;
    [WXApi sendReq:req];
    
    if ([WXApi isWXAppInstalled]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPayOrderListDetailViewController" object:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"WXPayOrderListDetailViewController" forKey:kJZK_weixinpayType];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

-(void)getOrderPayResult:(NSNotification *)notification{
    NSLog(@"userInfo: %@",notification.userInfo);
    if ([notification.object isEqualToString:@"success"]){
        [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
    }else{
        [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
    }
    
    [self sendOrderDetailRequest];
}

#pragma mark Data Filling
-(void)orderDetailDataFilling{
    [self.doctorImageView sd_setImageWithURL:[NSURL URLWithString:self.doctorImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.doctorNameLabel.text = self.doctorName;
    self.doctorTitleLabel.text = self.doctorTitle;
    self.doctorMoneyLabel1.text = @"¥";
    self.doctorMoneyLabel2.text = [NSString stringWithFormat:@"%.2f",self.doctorMoney];
    self.doctorMoneyLabel3.text = @"元";
    self.doctorTimeLabel1.text = @"就诊时间";
    self.doctorTimeLabel2.text = self.doctorTime;
    self.doctorAddressLabel1.text = @"就诊地点";
    self.doctorAddressLabel2.text = self.doctorAddress;
    
    self.patientNameLabel1.text = @"用户姓名：";
    self.patientNameLabel2.text = self.patientName;
    self.patientSexLabel.text = self.patientSex == 1 ? @"男" : @"女";
    self.patientAgeLabel.text = [NSString stringWithFormat:@"%d岁",self.patientAge];
    self.patientIdNumberLabel1.text = @"身份证号：";
    self.patientIdNumberLabel2.text = self.patientIdNumber;
    self.patientPhoneLabel1.text = @"电话号码：";
    self.patientPhoneLabel2.text = self.patientPhone;
    
    if ([self.patientProblem isEqualToString:@""]) {
        self.patientProblemLabel.text = @"";
    }else{
        self.patientProblemLabel.text = self.patientProblem;
    }
    
    if ([self.patientJiwangshi isEqualToString:@""]) {
        self.patientJiwangshiLabel.text = [NSString stringWithFormat:@"既往史暂无"];
    }else{
        self.patientJiwangshiLabel.text = [NSString stringWithFormat:@"既往史：%@",self.patientJiwangshi];
    }
    
    if ([self.patientShoushushi isEqualToString:@""]) {
        self.patientShoushushiLabel.text = [NSString stringWithFormat:@"手术史暂无"];
    }else{
        self.patientShoushushiLabel.text = [NSString stringWithFormat:@"手术史：%@",self.patientShoushushi];
    }
    
    if ([self.patientGuominshi isEqualToString:@""]) {
        self.patientGuominshiLabel.text = [NSString stringWithFormat:@"过敏史暂无"];
    }else{
        self.patientGuominshiLabel.text = [NSString stringWithFormat:@"过敏史：%@",self.patientGuominshi];
    }
    
    if ([self.patientJiazushi isEqualToString:@""]) {
        self.patientJiazushiLabel.text = [NSString stringWithFormat:@"家族史暂无"];
    }else{
        self.patientJiazushiLabel.text = [NSString stringWithFormat:@"家族史：%@",self.patientJiazushi];
    }
    
    
    
    if ([self.patientTestTime isEqualToString:@""]) {
        self.patientTestLabel.text = @"无体质测试情况";
    }else{
        self.patientTestLabel.text = [NSString stringWithFormat:@"%@的体质是：%@ 偏向%@",self.patientTestTime,self.patientZhutizhi,self.patientPiantizhi];
    }
    
    if (![[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
        self.complainLabel1.hidden = NO;
        self.complainLabel2.hidden = NO;
        self.compalainLineView.hidden = NO;
        self.shuimianLabel1.hidden = NO;
        self.shuimianLabel2.hidden = NO;
        self.shuimianLineView.hidden = NO;
        self.yinshiLabel1.hidden = NO;
        self.yinshuiLabel2.hidden = NO;
        self.yinshiLineView.hidden = NO;
        self.yinshuiLabel1.hidden = NO;
        self.yinshuiLabel2.hidden = NO;
        self.yinshuiLineView.hidden = NO;
        self.dabianLabel1.hidden = NO;
        self.dabianLabel2_1.hidden = NO;
        self.dabianLabel2_2.hidden = NO;
        self.dabianLabel2_3.hidden = NO;
        self.dabianLineView.hidden = NO;
        self.xiaobianLabel1.hidden = NO;
        self.xiaobianLabel2_2.hidden = NO;
        self.xiaobianLineView.hidden = NO;
        self.daixiaLabel1.hidden = NO;
        self.daixiaLabel2.hidden = NO;
        self.daixiaLineView.hidden = NO;
        self.yuejingLabel1.hidden = NO;
        self.yuejingLabel2_1.hidden = NO;
        self.yuejingLabel2_2.hidden = NO;
        self.yuejingLabel2_3.hidden = NO;
        self.yuejingLabel2_4.hidden = NO;
        self.yuejingLabel2_5.hidden = NO;
        self.yuejingLabel2_6.hidden = NO;
        self.yuejingLabel2_7.hidden = NO;
        self.yuejingLabel2_8.hidden = NO;
        self.yuejingLineView.hidden = NO;
        self.hanreLabel1.hidden = NO;
        self.hanreLineView.hidden = NO;
        self.tiwenLabel1.hidden = NO;
        self.tiwenLineView.hidden = NO;
        self.chuhanLabel1.hidden = NO;
        self.chuhanLineView.hidden = NO;
        self.zhaopianLabel1.hidden = NO;
        self.zhaopianLabel2.hidden = NO;
        
        self.timeLabel.text = [self.inspectionTime substringToIndex:10];
        self.complainLabel1.text = @"主诉：";
        self.complainLabel2.text = [self.complain isEqualToString:@""] ? @"正常" : self.complain;
        self.shuimianLabel1.text = @"睡眠：";
        self.shuimianLabel2.text = self.shuimianStringFix;
        self.yinshiLabel1.text = @"饮食：";
        self.yinshiLabel2.text = self.yinshiStringFix;
        self.yinshuiLabel1.text = @"饮水：";
        self.yinshuiLabel2.text = self.yinshuiStringFix;
        self.dabianLabel1.text = @"大便：";
        self.dabianLabel2_1.text = self.dabian1;
        self.dabianLabel2_2.text = self.dabian2;
        self.dabianLabel2_3.text = self.dabian3;
        self.xiaobianLabel1.text = @"小便：";
        self.xiaobianLabel2_1.text = self.xiaobian1;
        self.xiaobianLabel2_1Fix.text = self.xiaobian1Fix;
        self.xiaobianLabel2_2.text = self.xiaobian2;
        
        /*******************************************************/
        self.daixiaLabel1.text = @"带下：";
        self.daixiaLabel2.text = self.daixia;
        self.yuejingLabel1.text = @"月经：";
        self.yuejingLabel2_1.text = self.yuejing1;
        self.yuejingLabel2_2.text = self.yuejing2;
        self.yuejingLabel2_3.text = self.yuejing3;
        self.yuejingLabel2_4.text = self.yuejing4;
        self.yuejingLabel2_5.text = self.yuejing5;
        self.yuejingLabel2_6.text = self.yuejing6;
        self.yuejingLabel2_7.text = self.yuejing7;
        self.yuejingLabel2_8.text = self.yuejing8;
        /********************************************************/
        
        self.hanreLabel1.text = @"寒热：";
        self.hanreLabel2.text = self.hanreStringFix;
        self.tiwenLabel1.text = @"体温：";
        self.tiwenLabel2.text = self.tiwenStringFix;
        self.chuhanLabel1.text = @"出汗：";
        self.chuhanLabel2.text = self.chuhanStringFix;
        self.zhaopianLabel1.text = @"照片资料：";
        self.zhaopianLabel2.text = [self.healthPhotoString isEqualToString:@""] ? @"无" : @"有";
    }else{
        self.complainLabel1.hidden = YES;
        self.complainLabel2.hidden = YES;
        self.compalainLineView.hidden = YES;
        self.shuimianLabel1.hidden = YES;
        self.shuimianLabel2.hidden = YES;
        self.shuimianLineView.hidden = YES;
        self.yinshiLabel1.hidden = YES;
        self.yinshuiLabel2.hidden = YES;
        self.yinshiLineView.hidden = YES;
        self.yinshuiLabel1.hidden = YES;
        self.yinshuiLabel2.hidden = YES;
        self.yinshuiLineView.hidden = YES;
        self.dabianLabel1.hidden = YES;
        self.dabianLabel2_1.hidden = YES;
        self.dabianLabel2_2.hidden = YES;
        self.dabianLabel2_3.hidden = YES;
        self.dabianLineView.hidden = YES;
        self.xiaobianLabel1.hidden = YES;
        self.xiaobianLabel2_2.hidden = YES;
        self.xiaobianLineView.hidden = YES;
        self.daixiaLabel1.hidden = YES;
        self.daixiaLabel2.hidden = YES;
        self.daixiaLineView.hidden = YES;
        self.yuejingLabel1.hidden = YES;
        self.yuejingLabel2_1.hidden = YES;
        self.yuejingLabel2_2.hidden = YES;
        self.yuejingLabel2_3.hidden = YES;
        self.yuejingLabel2_4.hidden = YES;
        self.yuejingLabel2_5.hidden = YES;
        self.yuejingLabel2_6.hidden = YES;
        self.yuejingLabel2_7.hidden = YES;
        self.yuejingLabel2_8.hidden = YES;
        self.yuejingLineView.hidden = YES;
        self.hanreLabel1.hidden = YES;
        self.hanreLineView.hidden = YES;
        self.tiwenLabel1.hidden = YES;
        self.tiwenLineView.hidden = YES;
        self.chuhanLabel1.hidden = YES;
        self.chuhanLineView.hidden = YES;
        self.zhaopianLabel1.hidden = YES;
        self.zhaopianLabel2.hidden = YES;
    }
    
    self.diagnoseTitleLabel.text = @"诊断";
    self.bianzhengLabel1.text = @"辨证：";
    self.bianzhengLabel2.text = self.bianzhengString;
    self.bianbingLabel1.text = @"辨病：";
    self.bianbingLabel2.text = self.bianbingString;
    self.shexiangLabel1.text = @"舌象：";
    self.shexiangLabel2.text = self.shexiangString;
    self.maixiangLabel1.text = @"脉象：";
    self.maixiangLabel2.text = self.maixiangString;
    
    self.medicineTitleLabel.text = @"建议服药";
    self.fuyaofangfaLabel1.text = @"服药方法：";
    self.fuyaofangfaLabel2.text = self.fuyaofangfa;
    self.fuyaoshijianLabel1.text = @"服药时间：";
    self.fuyaoshijianLabel2.text = self.fuyaoshijian;
    self.fuyaocishuLabel1.text = @"服药次数：";
    self.fuyaocishuLabel2.text = self.fuyaocishu;
}

@end
