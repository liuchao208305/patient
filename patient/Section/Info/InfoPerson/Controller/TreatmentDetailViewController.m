//
//  TreatmentDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TreatmentDetailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "CouponCheckViewController.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "LoginViewController.h"
#import "AdaptionUtil.h"

@interface TreatmentDetailViewController ()<CouponDelegate,UIActionSheetDelegate,UIAlertViewDelegate,WXApiDelegate>

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
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

/*================================================*/
@property (strong,nonatomic)NSString *fixExpertImage;
@property (strong,nonatomic)NSString *fixDoctorImage;
@property (strong,nonatomic)NSString *fixExpertName;
@property (strong,nonatomic)NSString *fixDoctorName;
@property (strong,nonatomic)NSString *fixClinicName;
@property (strong,nonatomic)NSString *fixClinicAddress;
@property (assign,nonatomic)double fixFormerMoney;
@property (assign,nonatomic)double fixCouponMoney;
@property (assign,nonatomic)double fixLatterMoney;
@property (strong,nonatomic)NSString *fixAppiontmentTime;

@property (strong,nonatomic)NSString *fixPatientName;
@property (strong,nonatomic)NSString *fixPatientId;
@property (strong,nonatomic)NSString *fixPatientMobile;
@property (assign,nonatomic)NSInteger fixPatientAge;
@property (strong,nonatomic)NSString *fixPatientSex;
@property (assign,nonatomic)NSInteger fixPatientSexFix;
@property (strong,nonatomic)NSString *fixPatientSymptom;

@property (strong,nonatomic)NSString *fixCouponId;
@property (strong,nonatomic)NSString *fixCouponName;

@property (strong,nonatomic)NSString *fixNewCouponId;
@property (strong,nonatomic)NSString *fixNewCouponName;
/*================================================*/

@property (strong,nonatomic)NSString *treatmentId;
@property (strong,nonatomic)NSString *treatmentNumber;
@property (strong,nonatomic)NSString *treatmentTime;
@property (assign,nonatomic)NSInteger treatmentStatusCode;

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

@property (assign,nonatomic)NSInteger payStatusCode;
@property (strong,nonatomic)NSString *qrcodeImageString;

@end

@implementation TreatmentDetailViewController

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
    
    [self sendTreatmentDetailRequest];
//    [self treatmentDetailDataFilling];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"TreatmentDetailViewController"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"TreatmentDetailViewController"];
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
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"就诊单详情";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"就诊单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    if (!self.isFromOrderListVC) {
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonClicked)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }else{
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消该订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked)];
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.35*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initBackView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10, SCREEN_WIDTH, 230)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initBackView2];
    [self.scrollView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10+230+10, SCREEN_WIDTH, 48)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initBackView3];
    [self.scrollView addSubview:self.backView3];
    
    self.backView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView3Clicked)];
    [self.backView3 addGestureRecognizer:tap];
    
    self.backView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10+230+10+48+1, SCREEN_WIDTH, 48)];
    self.backView4.backgroundColor = kWHITE_COLOR;
    [self initBackView4];
    [self.scrollView addSubview:self.backView4];
    
    if ([AdaptionUtil isIphoneFour]) {
        self.backView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10+230+10+48+1+48+1, SCREEN_WIDTH, 1.4*SCREEN_HEIGHT-(150+10+230+10+48+1+48+1))];
    }else{
        self.backView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10+230+10+48+1+48+1, SCREEN_WIDTH, 1.2*SCREEN_HEIGHT-(150+10+230+10+48+1+48+1))];
    }
    self.backView5.backgroundColor = kWHITE_COLOR;
    [self initBackView5];
    [self.scrollView addSubview:self.backView5];
}

-(void)initBackView1{
    self.imageBackView = [[UIView alloc] init];
    self.imageBackView.backgroundColor = kWHITE_COLOR;
    [self.backView1 addSubview:self.imageBackView];
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(115);
    }];
    /*=======================================================================*/
    self.expertImage = [[UIImageView alloc] init];
//    [self.expertImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.expertImage];
    
    self.doctorImage = [[UIImageView alloc] init];
//    [self.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.doctorImage];
    
    [self.expertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorImage).offset(-4);
        make.centerY.equalTo(self.doctorImage).offset(-22);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    [self.doctorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.imageBackView).offset(-12);
        make.bottom.equalTo(self.imageBackView).offset(-24);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    /*=======================================================================*/
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        self.expertLabel = [[UILabel alloc] init];
        self.expertLabel.font = [UIFont systemFontOfSize:13];
//        self.expertLabel.text = @"test";
        [self.backView1 addSubview:self.expertLabel];
        
        self.doctorLabel = [[UILabel alloc] init];
        self.doctorLabel.font = [UIFont systemFontOfSize:13];
//        self.doctorLabel.text = @"test";
        [self.backView1 addSubview:self.doctorLabel];
        
        self.clinicLabel = [[UILabel alloc] init];
        self.clinicLabel.font = [UIFont systemFontOfSize:13];
        self.clinicLabel.numberOfLines = 0;
//        self.clinicLabel.text = @"test";
        [self.backView1 addSubview:self.clinicLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.font = [UIFont systemFontOfSize:13];
        self.addressLabel.numberOfLines = 0;
//        self.addressLabel.text = @"test";
        [self.backView1 addSubview:self.addressLabel];
        
        self.moneyLabel1 = [[UILabel alloc] init];
        self.moneyLabel1.font = [UIFont systemFontOfSize:13];
        self.moneyLabel1.textColor = ColorWithHexRGB(0x909090);
        self.moneyLabel1.textAlignment = NSTextAlignmentRight;
//        self.moneyLabel1.text = @"test";
        [self.backView1 addSubview:self.moneyLabel1];
        
        self.moneyLabel2  = [[UILabel alloc] init];
        self.moneyLabel2.textColor = [UIColor redColor];
        self.moneyLabel2.font = [UIFont systemFontOfSize:13];
        self.moneyLabel2.textAlignment = NSTextAlignmentRight;
//        self.moneyLabel2.text = @"test";
        [self.backView1 addSubview:self.moneyLabel2];
        
        [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.top.equalTo(self.backView1).offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
        }];
        
        [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.top.equalTo(self.expertLabel).offset(15+5);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
            
        }];
        
        [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.trailing.equalTo(self.backView1).offset(-12);
            make.top.equalTo(self.doctorLabel).offset(15+5);
//            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(15);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.trailing.equalTo(self.backView1).offset(-12);
            make.top.equalTo(self.clinicLabel).offset(15);
            //            make.width.mas_equalTo(300);
            //            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.expertLabel).offset(0);
            make.trailing.equalTo(self.backView1).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.doctorLabel).offset(0);
            make.trailing.equalTo(self.backView1).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.expertLabel = [[UILabel alloc] init];
//        self.expertLabel.text = @"test";
        [self.backView1 addSubview:self.expertLabel];
        
        self.doctorLabel = [[UILabel alloc] init];
//        self.doctorLabel.text = @"test";
        [self.backView1 addSubview:self.doctorLabel];
        
        self.clinicLabel = [[UILabel alloc] init];
//        self.clinicLabel.text = @"test";
        self.clinicLabel.font = [UIFont systemFontOfSize:15];
        self.clinicLabel.numberOfLines = 0;
        [self.backView1 addSubview:self.clinicLabel];
        
        self.addressLabel = [[UILabel alloc] init];
//        self.addressLabel.text = @"test";
        self.addressLabel.font = [UIFont systemFontOfSize:15];
        self.addressLabel.numberOfLines = 0;
        [self.backView1 addSubview:self.addressLabel];
        
        self.moneyLabel1 = [[UILabel alloc] init];
        self.moneyLabel1.textColor = ColorWithHexRGB(0x909090);
//        self.moneyLabel1.text = @"test";
        [self.backView1 addSubview:self.moneyLabel1];
        
        self.moneyLabel2  = [[UILabel alloc] init];
        self.moneyLabel2.textColor = [UIColor redColor];
//        self.moneyLabel2.text = @"test";
        [self.backView1 addSubview:self.moneyLabel2];
        
        [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.top.equalTo(self.backView1).offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
        }];
        
        [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.top.equalTo(self.expertLabel).offset(15+5);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(15);
            
        }];
        
        [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.trailing.equalTo(self.backView1).offset(-10);
            make.top.equalTo(self.doctorLabel).offset(15+5);
//            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(15);
        }];
        
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageBackView).offset(90);
            make.trailing.equalTo(self.backView1).offset(-25);
            make.top.equalTo(self.clinicLabel).offset(15+5);
//            make.width.mas_equalTo(300);
//            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.expertLabel).offset(0);
            make.trailing.equalTo(self.backView1).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
        
        [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.doctorLabel).offset(0);
            make.trailing.equalTo(self.backView1).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(15);
        }];
    }
    /*=======================================================================*/
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).offset(115);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.timeImage = [[UIImageView alloc] init];
    //    [self.timeImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.timeImage];
    
    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.text = @"test";
    [self.backView1 addSubview:self.timeLabel];
    
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.timeLabel).offset(-200-5);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView2{
    self.label1_1 = [[UILabel alloc] init];
//    self.label1_1.text = @"test";
    [self.backView2 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
//    self.label1_2.text = @"test";
    [self.backView2 addSubview:self.label1_2];
    
    self.label2_1 = [[UILabel alloc] init];
//    self.label2_1.text = @"test";
    [self.backView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
//    self.label2_2.text = @"test";
    [self.backView2 addSubview:self.label2_2];
    
    self.label3_1 = [[UILabel alloc] init];
//    self.label3_1.text = @"test";
    [self.backView2 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
//    self.label3_2.text = @"test";
    [self.backView2 addSubview:self.label3_2];
    
    self.label4_1 = [[UILabel alloc] init];
//    self.label4_1.text = @"test";
    [self.backView2 addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
//    self.label4_2.text = @"test";
    [self.backView2 addSubview:self.label4_2];
    
    self.label4_3 = [[UILabel alloc] init];
//    self.label4_3.text = @"test";
    [self.backView2 addSubview:self.label4_3];
    
    self.label4_4 = [[UILabel alloc] init];
//    self.label4_4.text = @"test";
    [self.backView2 addSubview:self.label4_4];
    
    self.label5_1 = [[UILabel alloc] init];
//    self.label5_1.text = @"test";
    [self.backView2 addSubview:self.label5_1];
    
    self.label5_2 = [[UILabel alloc] init];
//    self.label5_2.text = @"test";
    [self.backView2 addSubview:self.label5_2];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12);
        make.top.equalTo(self.backView2).offset(16);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12+80+17);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(0);
        make.top.equalTo(self.label1_1).offset(15+32);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(0);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(0);
        make.top.equalTo(self.label2_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(0);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(0);
        make.top.equalTo(self.label3_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(0);
        make.centerY.equalTo(self.label4_1).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(12);
        make.centerY.equalTo(self.label4_2).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_3).offset(60+17);
        make.centerY.equalTo(self.label4_3).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_1).offset(0);
        make.top.equalTo(self.label4_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_2).offset(0);
        make.centerY.equalTo(self.label5_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView3{
    self.label6_1 = [[UILabel alloc] init];
    self.label6_1.text = @"暂无";
    [self.backView3 addSubview:self.label6_1];
    
    self.label6_2 = [[UILabel alloc] init];
    self.label6_2.text = @"暂无";
    [self.backView3 addSubview:self.label6_2];
    
    [self.label6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(12);
        make.centerY.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.label6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label6_1).offset(80+20);
        make.centerY.equalTo(self.label6_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
}

-(void)initBackView4{
    self.label7_1 = [[UILabel alloc] init];
    self.label7_1.text = @"暂无";
    [self.backView4 addSubview:self.label7_1];
    
    self.label7_2 = [[UILabel alloc] init];
    self.label7_2.text = @"暂无";
    [self.backView4 addSubview:self.label7_2];
    
    self.payNowButton = [[UIButton alloc] init];
//    self.payNowButton.backgroundColor = kBLACK_COLOR;
    [self.payNowButton addTarget:self action:@selector(payNowButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView4 addSubview:self.payNowButton];
    
    [self.label7_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView4).offset(12);
        make.centerY.equalTo(self.backView4).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.label7_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label7_1).offset(80+20);
        make.centerY.equalTo(self.label7_1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.payNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView4).offset(-10);
        make.centerY.equalTo(self.backView4).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(33);
    }];
}

-(void)initBackView5{
    self.qrcodeImage = [[UIImageView alloc] init];
    [self.qrcodeImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView5 addSubview:self.qrcodeImage];
    
    self.qrcodeLabel = [[UILabel alloc] init];
    self.qrcodeLabel.text = @"暂无";
    self.qrcodeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView5 addSubview:self.qrcodeLabel];
    
    [self.qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView5).offset(0);
        make.top.equalTo(self.backView5).offset(29);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    
    [self.qrcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qrcodeImage).offset(0);
        make.top.equalTo(self.qrcodeImage).offset(90+10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)doneButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)cancelButtonClicked{
    DLog(@"cancelButtonClicked");
//    [self sendCancelTreatmentRequest];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要取消吗？" message:@"" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    [alert show];
}

-(void)backView3Clicked{
    DLog(@"backView3Clicked");
    CouponCheckViewController *couponCheckVC = [[CouponCheckViewController alloc] init];
    couponCheckVC.treatmentMoney = self.publicLatterMoney;
    couponCheckVC.couponDelegate = self;
    [self.navigationController pushViewController:couponCheckVC animated:YES];
}

-(void)payNowButtonClicked{
    DLog(@"payNowButtonClicked");
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"请选择支付方式"
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"支付宝支付", @"微信支付",@"银联支付",nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    [actionSheet showInView:self.view];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择支付方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"支付宝支付", @"微信支付",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark CouponDelegate
-(void)couponSelected:(CouponData *)couponData{
    self.publicNewCouponId = couponData.conpouId;
    self.label6_2.text = couponData.conpouName;
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        //支付宝支付
        self.paymentType = 2;
        [self sendPayNowInfoRequest];
    }else if (buttonIndex == 1){
        //微信支付
        self.paymentType = 3;
        [self sendPayNowInfoRequest];
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂未开通，敬请期待！"];
    }else if (buttonIndex == 2){
        //取消
    }
//    else if(buttonIndex == 2){
//        //        self.paymentType =4;
//        //        [self sendPaymentInfoRequest];
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂未开通，敬请期待！"];
//    }else if (buttonIndex == 3){
//        //取消
//    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1){
        [self sendCancelTreatmentRequest];
    }
}

#pragma mark Network Request
-(void)sendTreatmentDetailRequest{
    DLog(@"sendTreatmentDetailRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.orderNumber forKey:@"orderNo"];
    
    DLog(@"%@%@",kServerAddress,kJZK_TREATMENT_DETAIL_INFORMATION);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TREATMENT_DETAIL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self treatmentDetailDataParse];
        }else{
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

-(void)sendCancelTreatmentRequest{
    DLog(@"sendCancelTreatmentRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.treatmentId forKey:@"conID"];
    
    DLog(@"%@%@",kServerAddress,kJZK_TREATMENT_CANCEL_INFORMATION);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_TREATMENT_CANCEL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"取消成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
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

-(void)sendPayNowInfoRequest{
    DLog(@"sendPayNowInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.orderNumber forKey:@"order_no"];
    [parameter setValue:self.treatmentId forKey:@"consult_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.paymentType] forKey:@"pay_type"];
    [parameter setValue:self.publicNewCouponId forKey:@"coupon_id"];
    [parameter setValue:self.publicCouponId forKey:@"oldtext"];
    [parameter setValue:[NSString stringWithFormat:@"%.2f",self.fixLatterMoney] forKey:@"price"];
    
    DLog(@"%@%@",kServerAddressPay,kJZK_TREATMENT_DETAIL_INFORMATION_PAYNOW);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_TREATMENT_DETAIL_INFORMATION_PAYNOW] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if (self.paymentType == 1) {
                
            }else if (self.paymentType == 2){
                [self paymentInfoAliPayDataParse];
            }else if (self.paymentType == 3){
                [self paymentInfoWechatPayDataParse];
            }else if (self.paymentType == 4){
                [self paymentInfoUnionPayDataParse];
            }
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

#pragma mark Data Parse
-(void)treatmentDetailDataParse{
    /*=================================================================================*/
    self.fixExpertImage = [NullUtil judgeStringNull:[self.data objectForKey:@"maxHeand"]];
    self.fixDoctorImage = [NullUtil judgeStringNull:[self.data objectForKey:@"minHeand"]];
    self.fixExpertName = [NullUtil judgeStringNull:[self.data objectForKey:@"maxDoctorName"]];
    self.fixDoctorName = [NullUtil judgeStringNull:[self.data objectForKey:@"minDoctorName"]];
    self.fixClinicName = [NullUtil judgeStringNull:[self.data objectForKey:@"outpat_name"]];
    self.fixClinicAddress = [NullUtil judgeStringNull:[self.data objectForKey:@"address"]];
    self.fixFormerMoney = [[self.data objectForKey:@"maxMoney"] doubleValue];
    self.fixLatterMoney = [[self.data objectForKey:@"price"] doubleValue];
    self.fixAppiontmentTime = [NullUtil judgeStringNull:[self.data objectForKey:@"bespoke_date"]];
    
    self.fixPatientName = [NullUtil judgeStringNull:[self.data objectForKey:@"userName"]];
    self.fixPatientId = [NullUtil judgeStringNull:[self.data objectForKey:@"ID_no"]];
    self.fixPatientMobile = [NullUtil judgeStringNull:[self.data objectForKey:@"phone"]];
    self.fixPatientAge = [[self.data objectForKey:@"age"] integerValue];
    self.fixPatientSexFix = [[self.data objectForKey:@"sex"] integerValue];
    self.fixPatientSymptom = [NullUtil judgeStringNull:[self.data objectForKey:@"symptom_ids"]];
    
    self.fixCouponName = [NullUtil judgeStringNull:[self.data objectForKey:@"conpou_name"]];
    /*=================================================================================*/
    
    self.treatmentId = [NullUtil judgeStringNull:[self.data objectForKey:@"consult_id"]];
    self.treatmentNumber = [NullUtil judgeStringNull:[self.data objectForKey:@"order_no"]];
    self.treatmentTime = [NullUtil judgeStringNull:[self.data objectForKey:@"create_date"]];
    self.treatmentStatusCode = [[self.data objectForKey:@"status"] integerValue];
    
    self.payStatusCode = [[self.data objectForKey:@"pay_status"] integerValue];
    self.qrcodeImageString = [NullUtil judgeStringNull:[self.data objectForKey:@"code_url"]];
    
    [self treatmentDetailFixDataFilling];
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
            
            self.label7_2.text = @"已支付";
            self.payNowButton.hidden = YES;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([self.alipayResultStatus integerValue] == 8000){
            //支付结果确认中
            [HudUtil showSimpleTextOnlyHUD:@"支付结果确认中" withDelaySeconds:kHud_DelayTime];
        }else{
            //支付失败
            [HudUtil showSimpleTextOnlyHUD:@"支付失败" withDelaySeconds:kHud_DelayTime];
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
}

-(void)onResp:(BaseResp *)resp{
    NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
    
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)paymentInfoUnionPayDataParse{
    
}

#pragma mark Data Filling
//-(void)treatmentDetailDataFilling{
//    [self.expertImage sd_setImageWithURL:[NSURL URLWithString:self.publicExpertImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
//    [self.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.publicDoctorImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
//    self.expertLabel.text = self.publicExpertName;
//    self.doctorLabel.text = self.publicDoctorName;
//    self.clinicLabel.text = self.publicClinicName;
//    self.addressLabel.text = self.publicClinicAddress;
//    self.moneyLabel1.text = [NSString stringWithFormat:@"¥ %.0f",self.publicFormerMoney];
//    self.moneyLabel2.text = [NSString stringWithFormat:@"%.0f",self.publicLatterMoney];
//    [self.timeImage setImage:[UIImage imageNamed:@"info_treatment_shijian_image"]];
//    self.timeLabel.text = self.publicAppiontmentTime;
//    
//    self.label1_1.text = @"姓名：";
//    self.label1_2.text = self.publicPatientName;
//    self.label2_1.text = @"身份证号：";
//    self.label2_2.text = self.publicPatientId;
//    self.label3_1.text = @"手机号：";
//    self.label3_2.text = self.publicPatientMobile;
//    self.label4_1.text = @"年龄：";
//    self.label4_2.text = self.publicPatientAge;
//    self.label4_3.text = @"性别：";
//    self.label4_4.text = self.publicPatientSex;
//    self.label5_1.text = @"症状：";
//    self.label5_2.text = self.publicPatientSymptom;
//    
//    self.label6_1.text = @"优惠券";
//    self.label6_2.text = self.publicCouponName;
//    
//    self.label7_1.text = @"支付情况";
//}

-(void)treatmentDetailFixDataFilling{
    /*===========================================================================*/
    [self.expertImage sd_setImageWithURL:[NSURL URLWithString:self.fixExpertImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    [self.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.fixDoctorImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.expertLabel.text = [NSString stringWithFormat:@"特需专家：%@",self.fixExpertName];
    self.doctorLabel.text = [NSString stringWithFormat:@"门诊医生：%@",self.fixDoctorName];
    self.clinicLabel.text = [NSString stringWithFormat:@"门诊地址：%@",self.fixClinicName];
    self.addressLabel.text = [NSString stringWithFormat:@"                   %@",self.fixClinicAddress];
//    self.moneyLabel1.text = [NSString stringWithFormat:@"¥ %.2f",self.fixFormerMoney];
    
    NSString *oldPrice = [NSString stringWithFormat:@"¥ %.2f",self.fixFormerMoney];
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:ColorWithHexRGB(0x909090) range:NSMakeRange(2, length-2)];
    [self.moneyLabel1 setAttributedText:attri];
    
    if (self.fixLatterMoney < 0) {
        self.moneyLabel2.text = @"0";
    }else{
        self.moneyLabel2.text = [NSString stringWithFormat:@"¥ %.2f",self.fixLatterMoney];
    }
    
    [self.timeImage setImage:[UIImage imageNamed:@"info_treatment_shijian_image"]];
    self.timeLabel.text = self.fixAppiontmentTime;
    
    self.label1_1.text = @"姓名：";
    self.label1_2.text = self.fixPatientName;
    self.label2_1.text = @"身份证号：";
    self.label2_2.text = self.fixPatientId;
    self.label3_1.text = @"手机号：";
    self.label3_2.text = self.fixPatientMobile;
    self.label4_1.text = @"年龄：";
    self.label4_2.text = [NSString stringWithFormat:@"%ld",(long)self.fixPatientAge];
    self.label4_3.text = @"性别：";
    self.label4_4.text = self.fixPatientSexFix == 1 ? @"男" : @"女";
    self.label5_1.text = @"症状：";
    self.label5_2.text = [self.fixPatientSymptom isEqualToString:@""] ? @"无可疑症状" : self.fixPatientSymptom;
    
    self.label6_1.text = @"优惠券";
    self.label6_2.text = [self.fixCouponName isEqualToString:@""] ? @"无可用优惠券" : self.fixCouponName;
    
    self.label7_1.text = @"支付情况";
    /*===========================================================================*/
    if (self.payStatusCode == 0) {
        //未支付
        self.label7_2.text = @"未支付";
        [self.payNowButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [self.payNowButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.payNowButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_normal"] forState:UIControlStateNormal];
        [self.payNowButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_selected"] forState:UIControlStateHighlighted];
    }else if (self.payStatusCode == 1){
        //已支付
        self.label7_2.text = @"已支付";
        self.payNowButton.hidden = YES;
    }
    
    [self.qrcodeImage sd_setImageWithURL:[NSURL URLWithString:self.qrcodeImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.qrcodeLabel.text = @"就诊时出示二维码扫一扫";
}

@end
