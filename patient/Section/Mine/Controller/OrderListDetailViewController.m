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
        self.scrollView.contentSize = CGSizeMake(0, 2.5*SCREEN_HEIGHT);
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
    
    self.patientBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120, SCREEN_WIDTH, 200)];
    self.patientBackView2.backgroundColor = ColorWithHexRGB(0xf8f8f8);
    [self initPatientSubView2];
    [self.scrollView addSubview:self.patientBackView2];
    
    self.patientBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200, SCREEN_WIDTH, 650)];
    self.patientBackView3.backgroundColor = kWHITE_COLOR;
    [self initPatientSubView3];
    [self.scrollView addSubview:self.patientBackView3];
    
    self.diagnoseBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10, SCREEN_WIDTH, 140)];
    self.diagnoseBackView.backgroundColor = kWHITE_COLOR;
    [self initDiagnoseSubView];
    [self.scrollView addSubview:self.diagnoseBackView];
    
    self.prescriptionBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10+140+10, SCREEN_WIDTH, 100)];
    self.prescriptionBackView.backgroundColor = kWHITE_COLOR;
    [self initPrescriptionSubView];
    [self.scrollView addSubview:self.prescriptionBackView];
    
    self.medicineBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 115+10+120+200+650+10+140+10+100+10, SCREEN_WIDTH, 145)];
    self.medicineBackView.backgroundColor = kWHITE_COLOR;
    [self medicineBackView];
    [self.scrollView addSubview:self.medicineBackView];
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
        make.leading.equalTo(self.doctorNameLabel.mas_trailing).offset(22);
        make.centerY.equalTo(self.doctorNameLabel).offset(0);
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
        make.leading.equalTo(self.doctorNameLabel).offset(0);
        make.top.equalTo(self.doctorNameLabel.mas_bottom).offset(12);
    }];
    
    [self.doctorTimeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorBackView).offset(-12);
        make.centerY.equalTo(self.doctorTimeLabel1).offset(0);
    }];
    
    [self.doctorAddressLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.doctorTimeLabel1).offset(0);
        make.top.equalTo(self.doctorTimeLabel1.mas_bottom).offset(12);
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
    self.patientLineView6.backgroundColor = ColorWithHexRGB(0x646464);
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
        make.top.equalTo(self.patientLineView4.mas_bottom).offset(12);
    }];
    
    [self.patientShoushushiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.patientBackView2).offset(-12);
        make.centerY.equalTo(self.patientJiwangshiLabel).offset(0);
    }];
    
    [self.patientGuominshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(12);
        make.top.equalTo(self.patientJiwangshiLabel.mas_bottom).offset(15);
    }];
    
    [self.patientJiazushiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.patientBackView2).offset(-12);
        make.centerY.equalTo(self.patientGuominshiLabel).offset(0);
    }];
    
    [self.patientLineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView2).offset(0);
        make.trailing.equalTo(self.patientBackView2).offset(0);
        make.top.equalTo(self.patientGuominshiLabel.mas_bottom).offset(12);
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
        make.width.mas_equalTo(1);
    }];
}

-(void)initPatientSubView3{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.timeLabel];
    
    self.shuimianLabel1 = [[UILabel alloc] init];
    self.shuimianLabel1.font = [UIFont systemFontOfSize:14];
    [self.patientBackView3 addSubview:self.shuimianLabel1];
    
    self.shuimianLabel2 = [[UILabel alloc] init];
    self.shuimianLabel2.font = [UIFont systemFontOfSize:13];
    self.shuimianLabel2.textColor = ColorWithHexRGB(0x909090);
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
    
    self.xiaobianLabel2_2 = [[UILabel alloc] init];
    self.xiaobianLabel2_2.font = [UIFont systemFontOfSize:13];
    self.xiaobianLabel2_2.textColor = ColorWithHexRGB(0x909090);
    [self.patientBackView3 addSubview:self.xiaobianLabel2_2];
    
    self.xiaobianLineView = [[UIView alloc] init];
    self.xiaobianLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView3 addSubview:self.xiaobianLineView];
    
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
    self.chuhanLabel2.font = [UIFont systemFontOfSize:13];
    self.chuhanLabel2.textColor = ColorWithHexRGB(0x909090);
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
    
    [self.shuimianLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
    }];
    
    [self.shuimianLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shuimianLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.shuimianLabel1).offset(0);
    }];
    
    [self.shuimianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.shuimianLabel1.mas_bottom).offset(12);
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
    
    [self.xiaobianLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.xiaobianLabel2_1).offset(0);
        make.top.equalTo(self.xiaobianLabel2_1.mas_bottom).offset(10);
    }];
    
    [self.xiaobianLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(0);
        make.trailing.equalTo(self.patientBackView3).offset(0);
        make.top.equalTo(self.xiaobianLabel2_2.mas_bottom).offset(12);
        make.height.mas_equalTo(1);
    }];
    
    [self.hanreLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView3).offset(12);
        make.top.equalTo(self.xiaobianLineView.mas_bottom).offset(12);
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
        make.centerY.equalTo(self.chuhanLabel1).offset(0);
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
}

-(void)initDiagnoseSubView{
    
}

-(void)initPrescriptionSubView{
    
}

-(void)initMedicineSubView{
    
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
    self.inspectionResult = [NullUtil judgeStringNull:[self.data1 objectForKey:@"results"]];
    
    if (![[self.data1 objectForKey:@"results"] isKindOfClass:[NSNull class]]) {
        self.healthResultString = [self.data1 objectForKey:@"results"];
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
    }
    self.healthPhotoString = [NullUtil judgeStringNull:[self.data1 objectForKey:@"healthyPhotos"]];
    
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
    
    self.patientProblemLabel.text = self.patientProblem;
    self.patientJiwangshiLabel.text = [NSString stringWithFormat:@"既往史：%@",self.patientJiwangshi];
    self.patientShoushushiLabel.text = [NSString stringWithFormat:@"手术史：%@",self.patientShoushushi];
    self.patientGuominshiLabel.text = [NSString stringWithFormat:@"过敏史：%@",self.patientGuominshi];
    self.patientJiazushiLabel.text = [NSString stringWithFormat:@"家族史：%@",self.patientJiazushi];
    self.patientTestLabel.text = [NSString stringWithFormat:@"%@的体质是：%@ 偏向%@",self.patientTestTime,self.patientZhutizhi,self.patientPiantizhi];
    
    if ([self.inspectionTime isEqualToString:@""]) {
        self.timeLabel.text = @"暂无";
    }else{
        self.timeLabel.text = [self.inspectionTime substringToIndex:10];
    }
    self.shuimianLabel1.text = @"睡眠：";
    self.shuimianLabel2.text = [self.shuimian isEqualToString:@""] ? @"无" : self.shuimian;
    self.yinshiLabel1.text = @"饮食：";
    self.yinshiLabel2.text = [self.yinshi isEqualToString:@""] ? @"无" : self.yinshi;
    self.yinshuiLabel1.text = @"饮水：";
    self.yinshuiLabel2.text = [self.yinshui isEqualToString:@""] ? @"无" : self.yinshui;
    self.dabianLabel1.text = @"大便：";
    self.dabianLabel2_1.text = [self.dabian1 isEqualToString:@""] ? @"无" : self.dabian1;
    self.dabianLabel2_2.text = [self.dabian2 isEqualToString:@""] ? @"无" : self.dabian2;
    self.dabianLabel2_3.text = [self.dabian3 isEqualToString:@""] ? @"无" : self.dabian3;
    //        NSString *test = @"0xb6bc16";
    //        unsigned long red = strtoul([test UTF8String],0,0);
    //        [cell.dabianImageView setBackgroundColor:ColorWithHexRGB(red)];
    self.dabianyanseString = @"";
    
    if ([self.dabianyanseString isEqualToString:@""]) {
        [self.dabianImageView setBackgroundColor:kWHITE_COLOR];
    }else{
        unsigned long dabian = strtoul([self.dabianyanseString UTF8String],0,0);
        [self.dabianImageView setBackgroundColor:ColorWithHexRGB(dabian)];
    }
    self.xiaobianLabel1.text = @"小便：";
    self.xiaobianLabel2_1.text = [self.xiaobian1 isEqualToString:@""] ? @"无" : self.xiaobian1;
    self.xiaobianLabel2_2.text = [self.xiaobian2 isEqualToString:@""] ? @"无" : self.xiaobian2;
    self.hanreLabel1.text = @"寒热：";
    self.hanreLabel2.text = [self.hanre isEqualToString:@""] ? @"无" : self.hanre;
    self.tiwenLabel1.text = @"体温：";
    self.tiwenLabel2.text = [self.tiwen isEqualToString:@""] ? @"无" : self.tiwen;
    self.chuhanLabel1.text = @"出汗：";
    self.chuhanLabel2.text = [self.chuhan isEqualToString:@""] ? @"无" : self.chuhan;
    self.zhaopianLabel1.text = @"照片资料：";
    self.zhaopianLabel2.text = [self.healthPhotoString isEqualToString:@""] ? @"无" : @"有";
}

@end