//
//  BookInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/5.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BookInfoViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "LoginViewController.h"
#import "HealthDiseaseHistoryViewController.h"
#import "HealthListDetailViewController.h"
#import "TestResultListViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "OrderListViewController.h"
#import "BookClinicAddressData.h"
#import "BookExpertTimeData.h"


@interface BookInfoViewController ()<UITextViewDelegate,UIActionSheetDelegate,HealthListDelegate,TestListDelegate,ClinicAddressDelegate,ClinicTimeDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
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

@property (strong,nonatomic)NSString *doctor_id;
@property (strong,nonatomic)NSString *heand_url;
@property (strong,nonatomic)NSString *doctor_name;
@property (strong,nonatomic)NSString *titleName;
@property (assign,nonatomic)double consultation_money;
@property (strong,nonatomic)NSString *doctor_descr;

@property (assign,nonatomic)BOOL isAddressSelected;
@property (assign,nonatomic)BOOL isTimeSelected;
@property (strong,nonatomic)NSString *clinicId;
@property (strong,nonatomic)NSString *clinicAddress;
@property (strong,nonatomic)NSString *clinicTime;

@property (strong,nonatomic)NSString *patientId;
@property (strong,nonatomic)NSString *patientName;
@property (assign,nonatomic)int patientSex;
@property (assign,nonatomic)int patientAge;
@property (strong,nonatomic)NSString *patientIdNo;
@property (strong,nonatomic)NSString *patientPhone;

@property (strong,nonatomic)NSString *diseaseHistoryId;
@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guomingshi;
@property (strong,nonatomic)NSString *jiazushi;
@property (assign,nonatomic)int hunfou;
@property (assign,nonatomic)int erzi;
@property (assign,nonatomic)int nver;

@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthResult;
@property (strong,nonatomic)NSString *testId;
@property (strong,nonatomic)NSString *testResult;

@property (assign,nonatomic)BOOL healthAddFlag;
@property (assign,nonatomic)BOOL testAddFlag;

@property (strong,nonatomic)NSString *payType;

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

@implementation BookInfoViewController

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
    self.hunfou = 0;
    self.erzi = 0;
    self.nver = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"BookInfoViewController"];
    
    [self sendBookInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"BookInfoViewController"];
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
    self.addressArray = [NSMutableArray array];
    self.addressIdArray = [NSMutableArray array];
    self.addressUnitArray = [NSMutableArray array];
    
    self.timeArray = [NSMutableArray array];
    self.timeUnformatArray = [NSMutableArray array];
    self.timeFormatArray = [NSMutableArray array];
    self.timePeriodArray = [NSMutableArray array];
    self.timeFullFlagArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"预约医生";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.6*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.6*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.4*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.expertBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 110)];
    self.expertBackView.backgroundColor = kWHITE_COLOR;
    [self initExpertSubView];
    [self.scrollView addSubview:self.expertBackView];
    
    self.clinicBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+110+10, SCREEN_WIDTH, 90)];
    self.clinicBackView.backgroundColor = kWHITE_COLOR;
    [self initClinicSubView];
    [self.scrollView addSubview:self.clinicBackView];
    
    self.patientBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+110+10+90+10, SCREEN_WIDTH, 120)];
    self.patientBackView.backgroundColor = kWHITE_COLOR;
    [self initPatientSubView];
    [self.scrollView addSubview:self.patientBackView];
    
    self.inquiryBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10+110+10+90+10+120+10, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.inquiryBackView.backgroundColor = kWHITE_COLOR;
    [self initInquirySubView];
    [self.scrollView addSubview:self.inquiryBackView];
}

-(void)initExpertSubView{
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 30;
    [self.expertBackView addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertNameLabel];
    
    self.expertTitleLabel = [[UILabel alloc] init];
    self.expertTitleLabel.font = [UIFont systemFontOfSize:13];
    self.expertTitleLabel.textColor = ColorWithHexRGB(0x909090);
    [self.expertBackView addSubview:self.expertTitleLabel];
    
    self.expertMoneyLabel = [[UILabel alloc] init];
    [self.expertBackView addSubview:self.expertMoneyLabel];
    
    self.expertIntroductionLabel = [[UILabel alloc] init];
    self.expertIntroductionLabel.textColor = ColorWithHexRGB(0x646464);
    self.expertIntroductionLabel.numberOfLines = 0;
    self.expertIntroductionLabel.font = [UIFont systemFontOfSize:13];
    [self.expertBackView addSubview:self.expertIntroductionLabel];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertBackView).offset(12);
//        make.centerY.equalTo(self.expertBackView).offset(0);
        make.top.equalTo(self.expertBackView).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView.mas_trailing).offset(10);
        make.top.equalTo(self.expertImageView).offset(0);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.expertNameLabel.mas_trailing).offset(10);
//        make.centerY.equalTo(self.expertNameLabel).offset(0);
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(5);
    }];
    
    [self.expertMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertBackView).offset(-12);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.expertIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(0);
        make.top.equalTo(self.expertTitleLabel.mas_bottom).offset(0);
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.trailing.equalTo(self.expertMoneyLabel).offset(0);
        //        make.bottom.equalTo(self.expertBackView).offset(-15);
        make.height.mas_equalTo(60);
    }];
}

-(void)initClinicSubView{
    self.clinicAddressLabel = [[UILabel alloc] init];
    self.clinicAddressLabel.text = @"就诊地点";
    [self.clinicBackView addSubview:self.clinicAddressLabel];
    
    self.clinicAddressButton = [[UIButton alloc] init];
    [self.clinicAddressButton setTitle:@"请选择" forState:UIControlStateNormal];
    [self.clinicAddressButton setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [self.clinicAddressButton addTarget:self action:@selector(clinicAddressButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.clinicBackView addSubview:self.clinicAddressButton];
    
    self.clinicLineView = [[UIView alloc] init];
    self.clinicLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.clinicBackView addSubview:self.clinicLineView];
    
    self.clinicTimeLabel = [[UILabel alloc] init];
    self.clinicTimeLabel.text = @"就诊时间";
    [self.clinicBackView addSubview:self.clinicTimeLabel];
    
    self.clinicTimeButton = [[UIButton alloc] init];
    [self.clinicTimeButton setTitle:@"请选择" forState:UIControlStateNormal];
    [self.clinicTimeButton setTitleColor:ColorWithHexRGB(0x909090) forState:UIControlStateNormal];
    [self.clinicTimeButton addTarget:self action:@selector(clinicTimeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.clinicBackView addSubview:self.clinicTimeButton];
    
    [self.clinicAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.clinicBackView).offset(12);
        make.top.equalTo(self.clinicBackView).offset(13);
    }];
    
    [self.clinicAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.clinicBackView).offset(-12);
        make.centerY.equalTo(self.clinicAddressLabel).offset(0);
    }];
    
    [self.clinicLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.clinicBackView).offset(0);
        make.trailing.equalTo(self.clinicBackView).offset(0);
        make.top.equalTo(self.clinicAddressLabel.mas_bottom).offset(13);
        make.height.mas_equalTo(1);
    }];
    
    [self.clinicTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.clinicBackView).offset(12);
        make.top.equalTo(self.clinicLineView.mas_bottom).offset(13);
    }];
    
    [self.clinicTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.clinicBackView).offset(-12);
        make.centerY.equalTo(self.clinicTimeLabel).offset(0);
    }];
}

-(void)initPatientSubView{
    self.patientNameLabel = [[UILabel alloc] init];
    self.patientNameLabel.font = [UIFont systemFontOfSize:14];
    [self.patientBackView addSubview:self.patientNameLabel];
    
    self.patientNameTextField = [[UITextField alloc] init];
    self.patientNameTextField.font = [UIFont systemFontOfSize:14];
    self.patientNameTextField.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView addSubview:self.patientNameTextField];
    
    self.patientSexButton = [[UIButton alloc] init];
    [self.patientSexButton setFont:[UIFont systemFontOfSize:14]];
    [self.patientSexButton setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];\
    [self.patientSexButton addTarget:self action:@selector(patientSexButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.patientBackView addSubview:self.patientSexButton];
    
    self.patientAgeLabel = [[UILabel alloc] init];
    self.patientAgeLabel.font = [UIFont systemFontOfSize:14];
    self.patientAgeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView addSubview:self.patientAgeLabel];
    
    self.patientLineView1 = [[UIView alloc] init];
    self.patientLineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView addSubview:self.patientLineView1];
    
    self.patientIdLabel = [[UILabel alloc] init];
    self.patientIdLabel.font = [UIFont systemFontOfSize:14];
    [self.patientBackView addSubview:self.patientIdLabel];
    
    self.patientIdTextField = [[UITextField alloc] init];
    self.patientIdTextField.font = [UIFont systemFontOfSize:12];
    self.patientIdTextField.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView addSubview:self.patientIdTextField];
    
    self.patientLineView2 = [[UIView alloc] init];
    self.patientLineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.patientBackView addSubview:self.patientLineView2];
    
    self.patientPhoneLabel = [[UILabel alloc] init];
    self.patientPhoneLabel.font = [UIFont systemFontOfSize:14];
    [self.patientBackView addSubview:self.patientPhoneLabel];
    
    self.patientPhoneTextField = [[UITextField alloc] init];
    self.patientPhoneTextField.font = [UIFont systemFontOfSize:12];
    self.patientPhoneTextField.textColor = ColorWithHexRGB(0x646464);
    [self.patientBackView addSubview:self.patientPhoneTextField];
    
    [self.patientNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView).offset(12);
        make.top.equalTo(self.patientBackView).offset(11);
    }];
    
    [self.patientNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientNameLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientNameLabel).offset(0);
    }];
    
    [self.patientSexButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientNameTextField.mas_trailing).offset(20);
        make.centerY.equalTo(self.patientNameLabel).offset(0);
    }];
    
    [self.patientAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientSexButton.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientNameLabel).offset(0);
    }];
    
    [self.patientLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView).offset(0);
        make.trailing.equalTo(self.patientBackView).offset(0);
        make.top.equalTo(self.patientNameLabel.mas_bottom).offset(11);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView).offset(12);
        make.top.equalTo(self.patientLineView1.mas_bottom).offset(11);
    }];
    
    [self.patientIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientIdLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientIdLabel).offset(0);
    }];
    
    [self.patientLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView).offset(0);
        make.trailing.equalTo(self.patientBackView).offset(0);
        make.top.equalTo(self.patientIdLabel.mas_bottom).offset(11);
        make.height.mas_equalTo(1);
    }];
    
    [self.patientPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientBackView).offset(12);
        make.top.equalTo(self.patientLineView2.mas_bottom).offset(11);
    }];
    
    [self.patientPhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.patientPhoneLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.patientPhoneLabel).offset(0);
    }];
}

-(void)initInquirySubView{
    self.inquiryTextView = [[PlaceholderTextView alloc] init];
    self.inquiryTextView.backgroundColor = kBACKGROUND_COLOR;
    self.inquiryTextView.delegate = self;
    self.inquiryTextView.font = [UIFont systemFontOfSize:12];
    self.inquiryTextView.textAlignment = NSTextAlignmentLeft;
    self.inquiryTextView.editable = YES;
    self.inquiryTextView.placeholderColor = ColorWithHexRGB(0xa2a2a2);
    self.inquiryTextView.placeholder = @"请在这里输入您当前的症状。此外，您也可在下方添加您的体质测试结果、症状自查结果或者其他检查检验单据，方便医生对您的情况进行更详细的了解（向张三医生提问，等ta语音回答；超过48小时未答，将按支付路径全款退还）";
    [self.inquiryBackView addSubview:self.inquiryTextView];
    
    [self.inquiryTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inquiryBackView).offset(13);
        make.leading.equalTo(self.inquiryBackView).offset(12);
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.height.mas_equalTo(165);
    }];
    
    self.inquiryCountLabel = [[UILabel alloc] init];
    self.inquiryCountLabel.font = [UIFont systemFontOfSize:12];
    self.inquiryCountLabel.text = @"0/200";
    self.inquiryCountLabel.textColor = ColorWithHexRGB(0xa2a2a2);
    self.inquiryCountLabel.textAlignment = NSTextAlignmentRight;
    [self.inquiryBackView addSubview:self.inquiryCountLabel];
    
    [self.inquiryCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inquiryTextView).offset(-15);
        make.bottom.equalTo(self.inquiryTextView).offset(-15);
        make.width.mas_equalTo(60);
    }];
    
    self.diseaseImageView = [[UIImageView alloc] init];
    [self.diseaseImageView setImage:[UIImage imageNamed:@"question_inquiry_title_image"]];
    [self.inquiryBackView addSubview:self.diseaseImageView];
    
    self.diseaseLabel1 = [[UILabel alloc] init];
    self.diseaseLabel1.font = [UIFont systemFontOfSize:14];
    self.diseaseLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.inquiryBackView addSubview:self.diseaseLabel1];
    
    self.diseaseLabel2 = [[UILabel alloc] init];
    self.diseaseLabel2.font = [UIFont systemFontOfSize:12];
    self.diseaseLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.diseaseLabel2];
    
    self.diseaseButton = [[UIButton alloc] init];
    [self.diseaseButton setBackgroundImage:[UIImage imageNamed:@"question_inquiry_close_button"] forState:UIControlStateNormal];
    [self.diseaseButton addTarget:self action:@selector(diseaseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.inquiryBackView addSubview:self.diseaseButton];
    
    self.jiwangshiLabel1 = [[UILabel alloc] init];
    self.jiwangshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.inquiryBackView addSubview:self.jiwangshiLabel1];
    
    self.jiwangshiLabel2 = [[UILabel alloc] init];
    self.jiwangshiLabel2.font = [UIFont systemFontOfSize:14];
    self.jiwangshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.jiwangshiLabel2];
    
    self.shoushushiLabel1 = [[UILabel alloc] init];
    self.shoushushiLabel1.font = [UIFont systemFontOfSize:14];
    [self.inquiryBackView addSubview:self.shoushushiLabel1];
    
    self.shoushushiLabel2 = [[UILabel alloc] init];
    self.shoushushiLabel2.font = [UIFont systemFontOfSize:14];
    self.shoushushiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.shoushushiLabel2];
    
    self.guomingshiLabel1 = [[UILabel alloc] init];
    self.guomingshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.inquiryBackView addSubview:self.guomingshiLabel1];
    
    self.guomingshiLabel2 = [[UILabel alloc] init];
    self.guomingshiLabel2.font = [UIFont systemFontOfSize:14];
    self.guomingshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.guomingshiLabel2];
    
    self.jiazushiLabel1 = [[UILabel alloc] init];
    self.jiazushiLabel1.font = [UIFont systemFontOfSize:14];
    [self.inquiryBackView addSubview:self.jiazushiLabel1];
    
    self.jiazushiLabel2 = [[UILabel alloc] init];
    self.jiazushiLabel2.font = [UIFont systemFontOfSize:14];
    self.jiazushiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.jiazushiLabel2];
    
    [self.jiwangshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diseaseImageView.mas_trailing).offset(10);
        make.centerY.equalTo(self.diseaseImageView).offset(0);
    }];
    
    [self.jiwangshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.jiwangshiLabel1.mas_trailing).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-130);
        make.centerY.equalTo(self.jiwangshiLabel1).offset(0);
    }];
    
    [self.shoushushiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.shoushushiLabel2.mas_leading).offset(-10);
//        make.centerY.equalTo(self.jiwangshiLabel1).offset(0);
        make.leading.equalTo(self.jiwangshiLabel1).offset(0);
        make.top.equalTo(self.jiwangshiLabel1.mas_bottom).offset(10);
    }];
    
    [self.shoushushiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.diseaseButton.mas_leading).offset(-10);
//        make.centerY.equalTo(self.jiwangshiLabel1).offset(0);
        make.leading.equalTo(self.shoushushiLabel1.mas_trailing).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-130);
        make.centerY.equalTo(self.shoushushiLabel1).offset(0);
    }];
    
    [self.guomingshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.diseaseImageView.mas_trailing).offset(10);
//        make.centerY.equalTo(self.diseaseImageView).offset(8);
        make.leading.equalTo(self.shoushushiLabel1).offset(0);
        make.top.equalTo(self.shoushushiLabel1.mas_bottom).offset(10);
    }];
    
    [self.guomingshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.guomingshiLabel1.mas_trailing).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-130);
        make.centerY.equalTo(self.guomingshiLabel1).offset(0);
    }];
    
    [self.jiazushiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.jiazushiLabel2.mas_leading).offset(-10);
//        make.centerY.equalTo(self.guomingshiLabel1).offset(0);
        make.leading.equalTo(self.guomingshiLabel1).offset(0);
        make.top.equalTo(self.guomingshiLabel2.mas_bottom).offset(10);
    }];
    
    [self.jiazushiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.diseaseButton.mas_leading).offset(-10);
//        make.centerY.equalTo(self.guomingshiLabel1).offset(0);
        make.leading.equalTo(self.jiazushiLabel1.mas_trailing).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-130);
        make.centerY.equalTo(self.jiazushiLabel1).offset(0);
    }];
    
    self.healthImageView = [[UIImageView alloc] init];
    [self.healthImageView setImage:[UIImage imageNamed:@"question_inquiry_title_image"]];
    [self.inquiryBackView addSubview:self.healthImageView];
    
    self.healthLabel1 = [[UILabel alloc] init];
    self.healthLabel1.font = [UIFont systemFontOfSize:14];
    self.healthLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.inquiryBackView addSubview:self.healthLabel1];
    
    self.healthLabel2 = [[UILabel alloc] init];
    self.healthLabel2.font = [UIFont systemFontOfSize:12];
    self.healthLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.healthLabel2];
    
    self.healthButton = [[UIButton alloc] init];
    [self.healthButton setBackgroundImage:[UIImage imageNamed:@"question_inquiry_close_button"] forState:UIControlStateNormal];
    [self.healthButton addTarget:self action:@selector(healthButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.inquiryBackView addSubview:self.healthButton];
    
    self.testImageView = [[UIImageView alloc] init];
    [self.testImageView setImage:[UIImage imageNamed:@"question_inquiry_title_image"]];
    [self.inquiryBackView addSubview:self.testImageView];
    
    self.testLabel1 = [[UILabel alloc] init];
    self.testLabel1.numberOfLines = 0;
    self.testLabel1.font = [UIFont systemFontOfSize:14];
    self.testLabel1.textColor = ColorWithHexRGB(0x646464);
    self.testLabel1.textAlignment = NSTextAlignmentLeft;
    [self.inquiryBackView addSubview:self.testLabel1];
    
    self.testLabel2 = [[UILabel alloc] init];
    self.testLabel2.font = [UIFont systemFontOfSize:12];
    self.testLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.inquiryBackView addSubview:self.testLabel2];
    
    self.testButton = [[UIButton alloc] init];
    [self.testButton setBackgroundImage:[UIImage imageNamed:@"question_inquiry_close_button"] forState:UIControlStateNormal];
    [self.testButton addTarget:self action:@selector(testButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.inquiryBackView addSubview:self.testButton];
    
    [self.diseaseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inquiryBackView).offset(12);
        make.top.equalTo(self.inquiryTextView.mas_bottom).offset(17);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    [self.diseaseLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diseaseImageView.mas_trailing).offset(13);
        make.centerY.equalTo(self.diseaseImageView).offset(0);
    }];
    
    [self.diseaseLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.diseaseLabel1).offset(0);
        make.top.equalTo(self.diseaseLabel1.mas_bottom).offset(5);
    }];
    
    [self.diseaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.centerY.equalTo(self.diseaseImageView).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [self.healthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inquiryBackView).offset(12);
//        make.top.equalTo(self.diseaseLabel2.mas_bottom).offset(15);
        make.top.equalTo(self.jiazushiLabel1.mas_bottom).offset(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    [self.healthLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthImageView.mas_trailing).offset(13);
        make.centerY.equalTo(self.healthImageView).offset(0);
    }];
    
    [self.healthLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthLabel1).offset(0);
        make.top.equalTo(self.healthLabel1.mas_bottom).offset(5);
    }];
    
    [self.healthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.centerY.equalTo(self.healthImageView).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [self.testImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inquiryBackView).offset(12);
        make.top.equalTo(self.healthLabel2.mas_bottom).offset(15);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    [self.testLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.testImageView.mas_trailing).offset(13);
        make.width.mas_equalTo(SCREEN_WIDTH-80);
        make.centerY.equalTo(self.testImageView).offset(0);
    }];
    
    [self.testLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.testLabel1).offset(0);
        make.top.equalTo(self.testLabel1.mas_bottom).offset(5);
    }];
    
    [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.centerY.equalTo(self.testImageView).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    self.inquiryAddButton = [[UIButton alloc] init];
    [self.inquiryAddButton setImage:[UIImage imageNamed:@"quesiton_inquiry_add_button"] forState:UIControlStateNormal];
    [self.inquiryBackView addSubview:self.inquiryAddButton];
    
    [self.inquiryAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.testLabel2.mas_bottom).offset(25);
        make.trailing.equalTo(self.inquiryBackView).offset(-12);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    self.bookButton = [[UIButton alloc] init];
    [self.bookButton setTitle:@"预约" forState:UIControlStateNormal];
    [self.bookButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.bookButton setBackgroundColor:kMAIN_COLOR];
    [self.inquiryBackView addSubview:self.bookButton];
    
    [self.bookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inquiryAddButton.mas_bottom).offset(15);
        make.leading.equalTo(self.inquiryBackView).offset(17);
        make.trailing.equalTo(self.inquiryBackView).offset(-17);
        make.height.mas_equalTo(44);
    }];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.inquiryAddButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bookButton addTarget:self action:@selector(bookButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.patientNameTextField resignFirstResponder];
    [self.patientIdTextField resignFirstResponder];
    [self.patientPhoneTextField resignFirstResponder];
    
    [self.inquiryTextView resignFirstResponder];
}

-(void)clinicAddressButtonClicked{
    DLog(@"clinicAddressButtonClicked");
    
    [self sendClinicAddressListRequest];
}

-(void)clinicTimeButtonClicked{
    DLog(@"clinicTimeButtonClicked");
    
    if (!(self.isAddressSelected == YES)) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请先选择就诊地点！"];
    }else{
        [self sendExpertTimeListRequest];
    }
}

-(void)patientSexButtonClicked{
    DLog(@"patientSexButtonClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"男",@"女",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 3;
    [actionSheet showInView:self.view];
}

-(void)diseaseButtonClicked{
    DLog(@"diseaseButtonClicked");
    self.jiwangshiLabel1.hidden = YES;
    self.jiwangshiLabel2.hidden = YES;
    self.shoushushiLabel1.hidden = YES;
    self.shoushushiLabel2.hidden = YES;
    self.guomingshiLabel1.hidden = YES;
    self.guomingshiLabel2.hidden = YES;
    self.jiazushiLabel1.hidden = YES;
    self.jiazushiLabel2.hidden = YES;
    self.diseaseButton.hidden = YES;
    
    self.diseaseLabel1.hidden = NO;
    self.diseaseLabel2.hidden = NO;
    self.diseaseLabel1.text = @"既往史、过敏史、手术史、家族史";
    self.diseaseLabel2.text = @"（公开提问其他人不可见）";
}

-(void)healthButtonClicked{
    DLog(@"healthButtonClicked");
    
    self.healthAddFlag = NO;
    
    self.healthImageView.hidden = YES;
    self.healthLabel1.hidden = YES;
    self.healthLabel2.hidden = YES;
    self.healthButton.hidden = YES;
}

-(void)testButtonClicked{
    DLog(@"testButtonClicked");
    
    self.testAddFlag = NO;
    
    self.testImageView.hidden = YES;
    self.testLabel1.hidden = YES;
    self.testLabel2.hidden = YES;
    self.testButton.hidden = YES;
}

-(void)addButtonClicked{
    DLog(@"addButtonClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"既往史／手术史／过敏史／家族史",@"健康自查",@"体质测试",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

-(void)bookButtonClicked{
    DLog(@"bookButtonClicked");
    
    if (!(self.isAddressSelected == YES)) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请选择就诊地点！"];
    }else{
        if (!(self.isTimeSelected == YES)) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"请选择就诊时间"];
        }else{
            if ([self.patientPhoneTextField.text isEqualToString:@""]) {
                [AlertUtil showSimpleAlertWithTitle:nil message:@"请到[个人中心－设置－个人信息]中填写手机号码！"];
            }else{
                if ([self.inquiryTextView.text isEqualToString:@""]) {
                    [AlertUtil showSimpleAlertWithTitle:nil message:@"问题描述不能为空！"];
                    [self.inquiryTextView becomeFirstResponder];
                }else if (self.inquiryTextView.text.length > 200){
                    [AlertUtil showSimpleAlertWithTitle:nil message:@"问题描述字数不能超过200！"];
                }else if (self.consultation_money > 0){
                    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                  initWithTitle:@"请选择支付方式"
                                                  delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                  otherButtonTitles:@"支付宝支付", @"微信支付",nil];
                    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                    actionSheet.tag = 2;
                    [actionSheet showInView:self.view];
                }else{
                    [AlertUtil showSimpleAlertWithTitle:nil message:@"问题价格必须大于零！"];
                }
            }
        }
    }
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0){
            DLog(@"既往史／手术史／过敏史／家族史");
            HealthDiseaseHistoryViewController *diseasHistoryVC = [[HealthDiseaseHistoryViewController alloc] init];
            diseasHistoryVC.isEditable = YES;
            diseasHistoryVC.diseaseHistoryId = self.diseaseHistoryId;
            diseasHistoryVC.marryStatus = self.hunfou;
            diseasHistoryVC.nverCount = self.nver;
            diseasHistoryVC.erziCount = self.erzi;
            [self.navigationController pushViewController:diseasHistoryVC animated:YES];
        }else if (buttonIndex == 1){
            DLog(@"健康自查");
            HealthListDetailViewController *selfInspectionListVC = [[HealthListDetailViewController alloc] init];
            selfInspectionListVC.sourceVC = @"QuestionInquiryViewController";
            selfInspectionListVC.healthListDelegate = self;
            [self.navigationController pushViewController:selfInspectionListVC animated:YES];
        }else if (buttonIndex == 2){
            DLog(@"体质测试");
            TestResultListViewController *testListVC = [[TestResultListViewController alloc] init];
            testListVC.sourceVC = @"QuestionInquiryViewController";
            testListVC.testListDelegate = self;
            [self.navigationController pushViewController:testListVC animated:YES];
        }else if (buttonIndex == 3){
            DLog(@"取消");
        }
    }else if (actionSheet.tag == 2){
        if (buttonIndex == 0){
            //支付宝支付
            self.payType = @"1";
            [self sendBookConfirmRequest];
        }else if (buttonIndex == 1){
            //微信支付
            self.payType = @"2";
            [self sendBookConfirmRequest];
        }
    }else if (actionSheet.tag == 3){
        if (buttonIndex == 0){
            self.patientSex = 1;
            [self sendBookInfoDataFilling];
        }else if (buttonIndex == 1){
            self.patientSex = 2;
            [self sendBookInfoDataFilling];
        }
    }
}

#pragma mark HealthListDelegate
-(void)healthListChoosed:(NSString *)hid time:(NSString *)time type:(NSString *)type{
    self.healthAddFlag = YES;
    
    self.healthImageView.hidden = NO;
    self.healthLabel1.hidden = NO;
    self.healthLabel2.hidden = NO;
    self.healthButton.hidden = NO;
    
    self.healthLabel1.text = [NSString stringWithFormat:@"%@ %@结果",time,type];
    self.healthLabel2.text = @"（公开提问其他人不可见）";
    
    self.healthId = hid;
    self.healthResult = self.healthLabel1.text;
}

#pragma mark TestListDelegate
-(void)testListChoosed:(NSString *)tid time:(NSString *)time zhutizhi:(NSString *)zhutizhi piantizhi:(NSString *)piantizhi{
    self.testAddFlag = YES;
    
    self.testImageView.hidden = NO;
    self.testLabel1.hidden = NO;
    self.testLabel2.hidden = NO;
    self.testButton.hidden = NO;
    
    if ([piantizhi isEqualToString:@""]) {
        self.testLabel1.text = [NSString stringWithFormat:@"%@的体质是:%@",time,zhutizhi];
    }else{
        self.testLabel1.text = [NSString stringWithFormat:@"%@的体质是:%@ 偏向%@",time,zhutizhi,piantizhi];
    }
    self.testLabel2.text = @"（公开提问其他人不可见）";
    
    self.testId = tid;
    self.testResult = self.testLabel1.text;
}

#pragma mark ClinicAddressDelegate
-(void)clinicAddressSelected:(NSString *)addressId addressUnit:(NSString *)addressUnit{
    [self.bookClinicAddressPopView removeFromSuperview];
    
    self.isAddressSelected = YES;
    self.clinicId = addressId;
    self.clinicAddress = addressUnit;
    [self.clinicAddressButton setTitle:addressUnit forState:UIControlStateNormal];
}

#pragma mark ClinicTimeDelegate
-(void)clinicTimeSelected:(NSString *)unformatTime formatTime:(NSString *)formatTime{
    [self.bookExpertTimePopView removeFromSuperview];
    
    self.isTimeSelected = YES;
    self.clinicTime = unformatTime;
    [self.clinicTimeButton setTitle:formatTime forState:UIControlStateNormal];
}

#pragma mark UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    self.inquiryCountLabel.text = [NSString stringWithFormat:@"%ld/200",(long)textView.text.length];
    if (textView.text.length < 200) {
        self.inquiryTextView.editable = YES;
    }else{
//        self.inquiryTextView.editable = NO;
        NSString *string = [NSString stringWithFormat:@"当前字数为%lu，字数不能超过200！",(unsigned long)textView.text.length];
        [HudUtil showSimpleTextOnlyHUD:string withDelaySeconds:kHud_DelayTime];
    }
}

#pragma mark Network Request
-(void)sendBookInfoRequest{
    DLog(@"sendBookInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.expertId forKey:@"doctor_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_BOOK_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_BOOK_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self sendBookInfoDataParse];
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
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

-(void)sendBookConfirmRequest{
    DLog(@"sendBookConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"a_user_id"];
    [parameter setValue:self.inquiryTextView.text forKey:@"complain"];
    [parameter setValue:self.payType forKey:@"pay_type"];
    [parameter setValue:self.expertId forKey:@"min_doctor_id"];
    [parameter setValue:[NSString stringWithFormat:@"%.2f",self.consultation_money] forKey:@"money"];
    
    [parameter setValue:self.clinicTime forKey:@"bespoke_date"];
    [parameter setValue:self.clinicId forKey:@"org_name"];
    
    [parameter setValue:self.patientPhoneTextField.text forKey:@"phone"];
    [parameter setValue:self.patientIdTextField.text forKey:@"ID_no"];
    [parameter setValue:[NSString stringWithFormat:@"%d",self.patientAge] forKey:@"age"];
    [parameter setValue:self.patientNameTextField.text forKey:@"name"];
    [parameter setValue:[NSString stringWithFormat:@"%d",self.patientSex] forKey:@"sex"];
    
    [parameter setValue:@"1" forKey:@"qenclosures[0].type"];
    [parameter setValue:self.jiwangshi forKey:@"qenclosures[0].a_history"];
    [parameter setValue:self.shoushushi forKey:@"qenclosures[0].b_history"];
    [parameter setValue:self.guomingshi forKey:@"qenclosures[0].c_history"];
    [parameter setValue:self.jiazushi forKey:@"qenclosures[0].d_history"];
    [parameter setValue:@"" forKey:@"qenclosures[0].obj_id"];
    [parameter setValue:@"" forKey:@"qenclosures[0].jiankang"];
    [parameter setValue:@"" forKey:@"qenclosures[0].enclosure"];
    
    [parameter setValue:@"2" forKey:@"qenclosures[1].type"];
    [parameter setValue:@"" forKey:@"qenclosures[1].a_history"];
    [parameter setValue:@"" forKey:@"qenclosures[1].b_history"];
    [parameter setValue:@"" forKey:@"qenclosures[1].c_history"];
    [parameter setValue:@"" forKey:@"qenclosures[1].d_history"];
    [parameter setValue:@"" forKey:@"qenclosures[1].obj_id"];
    [parameter setValue:@"" forKey:@"qenclosures[1].jiankang"];
    [parameter setValue:self.testResult forKey:@"qenclosures[1].enclosure"];
    
    [parameter setValue:@"3" forKey:@"qenclosures[2].type"];
    [parameter setValue:self.jiwangshi forKey:@"qenclosures[2].a_history"];
    [parameter setValue:self.shoushushi forKey:@"qenclosures[2].b_history"];
    [parameter setValue:self.guomingshi forKey:@"qenclosures[2].c_history"];
    [parameter setValue:self.jiazushi forKey:@"qenclosures[2].d_history"];
    [parameter setValue:self.healthId forKey:@"qenclosures[2].obj_id"];
    [parameter setValue:self.healthResult forKey:@"qenclosures[2].jiankang"];
    [parameter setValue:@"" forKey:@"qenclosures[2].enclosure"];
    
    DLog(@"%@%@",kServerAddressPay,kJZK_BOOK_CONFIRM);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_BOOK_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_BOOK_CONFIRM);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if ([self.payType isEqualToString:@"1"]) {
                [self paymentInfoAliPayDataParse];
            }else if ([self.payType isEqualToString:@"2"]){
                [self paymentInfoWechatPayDataParse];
            }
        }else{
            DLog(@"%@",self.message2);
            [HudUtil showSimpleTextOnlyHUD:self.message2 withDelaySeconds:kHud_DelayTime];
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

-(void)sendClinicAddressListRequest{
    DLog(@"sendClinicAddressListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.expertId forKey:@"doctor_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_BOOK_CLINIC_ADDRESS_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self bookClinicAddressDataParse];
        }else{
            DLog(@"%ld",(long)self.code3);
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

-(void)sendExpertTimeListRequest{
    DLog(@"sendExpertTimeListRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.expertId forKey:@"doctor_id"];
    [parameter setValue:self.clinicId forKey:@"aid"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_BOOK_EXPERT_TIME_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            [self bookExpertTimeDataParse];
        }else{
            DLog(@"%ld",(long)self.code4);
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

#pragma mark Data Parse
-(void)sendBookInfoDataParse{
    self.doctor_id = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_id"]];
    self.heand_url = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"heand_url"]];
    self.doctor_name = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_name"]];
    self.titleName = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"title_name"]];
    self.consultation_money = [[[self.data objectForKey:@"doctorInfo"] objectForKey:@"money"] doubleValue];
    self.doctor_descr = [NullUtil judgeStringNull:[[self.data objectForKey:@"doctorInfo"] objectForKey:@"doctor_descr"]];
    
    if (![[self.data objectForKey:@"userInfo"] isKindOfClass:[NSNull class]]) {
        self.diseaseHistoryId = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"ids"]];
        self.jiwangshi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"a_history"]];
        self.shoushushi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"b_history"]];
        self.guomingshi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"c_history"]];
        self.jiazushi = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"d_history"]];
        
        self.patientId = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"user_id"]];
        self.patientName = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"real_name"]];
        self.patientSex = [[[self.data objectForKey:@"userInfo"] objectForKey:@"user_sex"] intValue];
        self.patientIdNo = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"ID_number"]];
        self.patientPhone = [NullUtil judgeStringNull:[[self.data objectForKey:@"userInfo"] objectForKey:@"phone"]];
    }
    
    [self sendBookInfoDataFilling];
}

-(void)paymentInfoAliPayDataParse{
    self.paymentInfomation = [self.data2 objectForKey:@"payinfo"];
    
    NSString *appScheme = @"alipaytest";
    
    [[AlipaySDK defaultService] payOrder:self.paymentInfomation fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        DLog(@"resultDic-->%@",resultDic);
        self.alipayMomo = [resultDic objectForKey:@"memo"];
        self.alipayResult = [resultDic objectForKey:@"result"];
        self.alipayResultStatus = [resultDic objectForKey:@"resultStatus"];
        
        if ([self.alipayResultStatus integerValue] == 9000) {
            //支付成功
            [HudUtil showSimpleTextOnlyHUD:@"支付成功" withDelaySeconds:kHud_DelayTime];
            
            OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
            orderListVC.sourceVC = @"BookInfoViewController";
            orderListVC.orderType = 0;
            [self.navigationController pushViewController:orderListVC animated:YES];
        }else if ([self.alipayResultStatus integerValue] == 8000){
            //支付结果确认中
            [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
            
            OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
            orderListVC.sourceVC = @"BookInfoViewController";
            orderListVC.orderType = 0;
            [self.navigationController pushViewController:orderListVC animated:YES];
        }else{
            //支付失败
            [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
            
            OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
            orderListVC.sourceVC = @"BookInfoViewController";
            orderListVC.orderType = 0;
            [self.navigationController pushViewController:orderListVC animated:YES];
        }
    }];
}

-(void)paymentInfoWechatPayDataParse{
    self.payinfo = [self.data2 objectForKey:@"payinfo"];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPayBookInfoViewController" object:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"WXPayBookInfoViewController" forKey:kJZK_weixinpayType];
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
    OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
    orderListVC.sourceVC = @"BookInfoViewController";
    orderListVC.orderType = 0;
    [self.navigationController pushViewController:orderListVC animated:YES];
}

-(void)bookClinicAddressDataParse{
    self.addressArray = [BookClinicAddressData mj_objectArrayWithKeyValuesArray:self.data3];
    [self.addressIdArray removeAllObjects];
    [self.addressUnitArray removeAllObjects];
    for (BookClinicAddressData *bookClinicAddressData in self.addressArray) {
        [self.addressIdArray addObject:[NullUtil judgeStringNull:bookClinicAddressData.aid]];
        [self.addressUnitArray addObject:[NullUtil judgeStringNull:bookClinicAddressData.org_name]];
    }
    
    self.bookClinicAddressPopView = [[BookClinicAddressPopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.bookClinicAddressPopView initViewWithIdArray:self.addressIdArray addressUnitArray:self.addressUnitArray];
    self.bookClinicAddressPopView.clinicAddressDelegate = self;
    [self.view addSubview:self.bookClinicAddressPopView];
}

-(void)bookExpertTimeDataParse{
    self.timeArray = [BookExpertTimeData mj_objectArrayWithKeyValuesArray:self.data4];
    [self.timeUnformatArray removeAllObjects];
    [self.timeFormatArray removeAllObjects];
    [self.timePeriodArray removeAllObjects];
    [self.timeFullFlagArray removeAllObjects];
    for (BookExpertTimeData *bookExpertTimeData in self.timeArray) {
        [self.timeUnformatArray addObject:[NullUtil judgeStringNull:bookExpertTimeData.dates]];
        [self.timeFormatArray addObject:[NullUtil judgeStringNull:bookExpertTimeData.dateSty]];
        [self.timePeriodArray addObject:[NSString stringWithFormat:@"%d",bookExpertTimeData.upOrdown]];
        [self.timeFullFlagArray addObject:[NSString stringWithFormat:@"%d",bookExpertTimeData.is_man]];
    }
    
    self.bookExpertTimePopView = [[BookExpertTimePopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.bookExpertTimePopView initViewWithTimeUnformatArray:self.timeUnformatArray timeFormatArray:self.timeFormatArray timePeriodArray:self.timePeriodArray timeFullFlagArray:self.timeFullFlagArray];
    self.bookExpertTimePopView.clinicTimeDelegate = self;
    [self.view addSubview:self.bookExpertTimePopView];
}

#pragma mark Data Filling
-(void)sendBookInfoDataFilling{
    [self.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.heand_url] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.expertNameLabel.text = self.doctor_name;
    self.expertTitleLabel.text = self.titleName;
    self.expertMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f元",self.consultation_money];
    self.expertIntroductionLabel.text = self.doctor_descr;
    
    self.patientNameLabel.text = @"姓名：";
    self.patientNameTextField.text = self.patientName;
    if (self.patientSex == 1) {
        [self.patientSexButton setTitle:@"男" forState:UIControlStateNormal];
    }else if (self.patientSex == 2){
        [self.patientSexButton setTitle:@"女 " forState:UIControlStateNormal];
    }
    self.patientIdLabel.text = @"身份证号：";
    self.patientIdTextField.text = self.patientIdNo;
    [self calculateAgeAccordingIdNo:self.patientIdTextField.text];
    self.patientPhoneLabel.text = @"电话号码：";
    self.patientPhoneTextField.text = self.patientPhone;
    
    self.patientNameTextField.userInteractionEnabled = NO;
    self.patientSexButton.userInteractionEnabled = NO;
    self.patientIdTextField.userInteractionEnabled = NO;
    self.patientPhoneTextField.userInteractionEnabled = NO;
    
    if (![[self.data objectForKey:@"userInfo"] isKindOfClass:[NSNull class]]) {
        self.diseaseLabel1.hidden = YES;
        self.diseaseLabel2.hidden = YES;
        
        self.jiwangshiLabel1.hidden = NO;
        self.jiwangshiLabel2.hidden = NO;
        self.shoushushiLabel1.hidden = NO;
        self.shoushushiLabel2.hidden = NO;
        self.guomingshiLabel1.hidden = NO;
        self.guomingshiLabel2.hidden = NO;
        self.jiazushiLabel1.hidden = NO;
        self.jiazushiLabel2.hidden = NO;
        self.diseaseButton.hidden = NO;
        
        self.jiwangshiLabel1.text = @"既往史：";
        self.jiwangshiLabel2.text = [self.jiwangshi isEqualToString:@""] ? @"无" : self.jiwangshi;
        self.shoushushiLabel1.text = @"手术史：";
        self.shoushushiLabel2.text = [self.shoushushi isEqualToString:@""] ? @"无" : self.shoushushi;
        self.guomingshiLabel1.text = @"过敏史：";
        self.guomingshiLabel2.text = [self.guomingshi isEqualToString:@""] ? @"无" : self.guomingshi;
        self.jiazushiLabel1.text = @"家族史：";
        self.jiazushiLabel2.text = [self.jiazushi isEqualToString:@""] ? @"无" : self.jiazushi;
    }else{
        self.jiwangshiLabel1.hidden = YES;
        self.jiwangshiLabel2.hidden = YES;
        self.shoushushiLabel1.hidden = YES;
        self.shoushushiLabel2.hidden = YES;
        self.guomingshiLabel1.hidden = YES;
        self.guomingshiLabel2.hidden = YES;
        self.jiazushiLabel1.hidden = YES;
        self.jiazushiLabel2.hidden = YES;
        
        self.diseaseLabel1.hidden = NO;
        self.diseaseLabel2.hidden = NO;
        
        self.diseaseLabel1.text = @"既往史、过敏史、手术史、家族史";
        self.diseaseLabel2.text = @"（公开提问其他人不可见）";
    }
    
    if (self.healthAddFlag == NO) {
        self.healthImageView.hidden = YES;
        self.healthLabel1.hidden = YES;
        self.healthLabel2.hidden = YES;
        self.healthButton.hidden = YES;
    }
    
    if (self.testAddFlag == NO) {
        self.testImageView.hidden = YES;
        self.testLabel1.hidden = YES;
        self.testLabel2.hidden = YES;
        self.testButton.hidden = YES;
    }
}

-(void)calculateAgeAccordingIdNo:(NSString *)idNo{
    int birthYear = 0;
    int birthMonth = 0;
    int birthDay = 0;
    if ([VerifyUtil iDCardNumberCheck:idNo]){
        if ([idNo length] == 15) {
            birthYear = [[idNo substringWithRange:NSMakeRange(6, 2)] intValue] +1900;
            birthMonth = [[idNo substringWithRange:NSMakeRange(8, 2)] intValue];
            birthDay = [[idNo substringWithRange:NSMakeRange(10, 2)] intValue];
        }else if ([idNo length] == 18){
            birthYear = [[idNo substringWithRange:NSMakeRange(6, 4)] intValue];
            birthMonth = [[idNo substringWithRange:NSMakeRange(10, 2)] intValue];
            birthDay = [[idNo substringWithRange:NSMakeRange(12, 2)] intValue];
        }
        
        int currentYear = [[DateUtil getCurrentYear] intValue];
        int currentMonth = [[DateUtil getCurrentMonth] intValue];
        int currentDay = [[DateUtil getCurrentDay] intValue];
        
        int age = 0;
        if (currentMonth > birthMonth) {
            age = currentYear - birthYear;
        }else if(currentMonth < birthMonth){
            age = currentYear - birthYear - 1;
        }else if (currentMonth == birthMonth){
            if (currentDay > birthDay) {
                age = currentYear - birthYear;
            }else if (currentDay < birthDay){
                age = currentYear - birthYear - 1;
            }else if (currentDay == birthDay){
                age = currentYear - birthYear;
            }
        }
        
        self.patientAge = age;
        self.patientAgeLabel.text = [NSString stringWithFormat:@"%d岁",age];
    }
//    else{
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的身份证号码！"];
//    }
}

@end
