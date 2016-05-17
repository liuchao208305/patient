//
//  ReservationListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ReservationListViewController.h"
#import "TreatmentDetailViewController.h"
#import "HudUtil.h"
#import "CouponCheckViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface ReservationListViewController ()<CouponDelegate,UIActionSheetDelegate,WXApiDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger paymentType;

@property (strong,nonatomic)NSString *orderNumber;
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

@implementation ReservationListViewController

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
    
    [self reservationListDataFilling];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"ReservationListViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"ReservationListViewController"];
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
    label.text = @"预约单确认";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回首页" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
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
    
    self.onlineButton = [[UIButton alloc] init];
    [self.onlineButton addTarget:self action:@selector(onlineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.onlineButton];
    
    self.offlineButton = [[UIButton alloc] init];
    [self.offlineButton addTarget:self action:@selector(offlineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.offlineButton];
    
    [self.onlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3).offset(36+48);
        make.centerX.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(44);
    }];
    
    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.onlineButton).offset(10+44);
        make.centerX.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(44);
    }];
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
    self.expertLabel = [[UILabel alloc] init];
    self.expertLabel.text = @"test";
    [self.backView1 addSubview:self.expertLabel];
    
    self.doctorLabel = [[UILabel alloc] init];
    self.doctorLabel.text = @"test";
    [self.backView1 addSubview:self.doctorLabel];
    
    self.clinicLabel = [[UILabel alloc] init];
    self.clinicLabel.text = @"test";
    [self.backView1 addSubview:self.clinicLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"test";
    [self.backView1 addSubview:self.addressLabel];
    
    self.moneyLabel1 = [[UILabel alloc] init];
    self.moneyLabel1.text = @"test";
    [self.backView1 addSubview:self.moneyLabel1];
    
    self.moneyLabel2  = [[UILabel alloc] init];
    self.moneyLabel2.text = @"test";
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
        make.top.equalTo(self.doctorLabel).offset(15+5);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-25);
        make.top.equalTo(self.clinicLabel).offset(15+5);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.expertLabel).offset(0);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.doctorLabel).offset(0);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
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
    self.timeLabel.text = @"test";
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
    self.label1_1.text = @"test";
    [self.backView2 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"test";
    [self.backView2 addSubview:self.label1_2];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"test";
    [self.backView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"test";
    [self.backView2 addSubview:self.label2_2];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.text = @"test";
    [self.backView2 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"test";
    [self.backView2 addSubview:self.label3_2];
    
    self.label4_1 = [[UILabel alloc] init];
    self.label4_1.text = @"test";
    [self.backView2 addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
    self.label4_2.text = @"test";
    [self.backView2 addSubview:self.label4_2];
    
    self.label4_3 = [[UILabel alloc] init];
    self.label4_3.text = @"test";
    [self.backView2 addSubview:self.label4_3];
    
    self.label4_4 = [[UILabel alloc] init];
    self.label4_4.text = @"test";
    [self.backView2 addSubview:self.label4_4];
    
    self.label5_1 = [[UILabel alloc] init];
    self.label5_1.text = @"test";
    [self.backView2 addSubview:self.label5_1];
    
    self.label5_2 = [[UILabel alloc] init];
    self.label5_2.text = @"test";
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
        make.width.mas_equalTo(200);
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
//    self.label6_1.text = @"test";
    [self.backView3 addSubview:self.label6_1];
    
    self.label6_2 = [[UILabel alloc] init];
//    self.label6_2.text = @"test";
    [self.backView3 addSubview:self.label6_2];
    
    [self.label6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(12);
        make.centerY.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.label6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label6_1).offset(50+20);
        make.centerY.equalTo(self.label6_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)rightButtonClicked{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)backView3Clicked{
    CouponCheckViewController *couponCheckVC = [[CouponCheckViewController alloc] init];
    couponCheckVC.treatmentMoney = self.publicLatterMoney;
    couponCheckVC.couponDelegate = self;
    [self.navigationController pushViewController:couponCheckVC animated:YES];
}

-(void)onlineButtonClicked{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择支付方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"支付宝支付", @"微信支付",@"银联支付",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)offlineButtonClicked{
    self.paymentType = 1;
    [self sendPaymentInfoRequest];
}

-(void)pushTreatmentDetailViewController{
    TreatmentDetailViewController *detailVC = [[TreatmentDetailViewController alloc] init];
    
    detailVC.expertId = self.expertId;
    detailVC.clinicId = self.clinicId;
    detailVC.doctorId = self.doctorId;
    
    detailVC.publicDoctorImage = self.publicDoctorImage;
    detailVC.publicDoctorImage = self.publicDoctorImage;
    detailVC.publicExpertName = self.publicExpertName;
    detailVC.publicDoctorName = self.publicDoctorName;
    detailVC.publicClinicName = self.publicClinicName;
    detailVC.publicClinicAddress = self.publicClinicAddress;
    detailVC.publicFormerMoney = self.publicFormerMoney;
    detailVC.publicLatterMoney = self.publicLatterMoney;
    detailVC.publicAppiontmentTime = self.publicAppiontmentTime;
    
    detailVC.publicPatientName = self.publicPatientName;
    detailVC.publicPatientId = self.publicPatientId;
    detailVC.publicPatientMobile = self.publicPatientMobile;
    detailVC.publicPatientAge = self.publicPatientAge;
    detailVC.publicPatientSex = self.publicPatientSex;
    detailVC.publicPatientSymptom = self.publicPatientSymptom;
//
    detailVC.publicCouponId = self.publicCouponId;
    detailVC.publicCouponName = self.label6_2.text;
    
    detailVC.orderNumber = self.orderNumber;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark CouponDelegate
-(void)couponSelected:(CouponData *)couponData{
    self.publicCouponId = couponData.conpouId;
    self.label6_2.text = couponData.conpouName;
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        //支付宝支付
        self.paymentType = 2;
        [self sendPaymentInfoRequest];
    }else if (buttonIndex == 1){
        //微信支付
        self.paymentType = 3;
        [self sendPaymentInfoRequest];
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂未开通，敬请期待！"];
    }else if(buttonIndex == 2){
//        self.paymentType =4;
//        [self sendPaymentInfoRequest];
        [AlertUtil showSimpleAlertWithTitle:nil message:@"暂未开通，敬请期待！"];
    }else if (buttonIndex == 3){
        //取消
    }
}

#pragma mark Network Request
-(void)sendPaymentInfoRequest{
    DLog(@"sendPaymentInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.doctorId forKey:@"min_doctor_id"];
    [parameter setValue:self.expertId forKey:@"max_doctor_id"];
    [parameter setValue:self.appointmentTime forKey:@"bespoke_date"];
    [parameter setValue:self.publicPatientName forKey:@"name"];
    [parameter setValue:self.clinicId forKey:@"outpatId"];
    [parameter setValue:self.publicPatientId forKey:@"ID_no"];
    [parameter setValue:self.publicPatientMobile forKey:@"phone"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.publicPatientSexFix] forKey:@"sex"];
    [parameter setValue:self.publicPatientAge forKey:@"age"];
    [parameter setValue:self.publicPatientSymptom forKey:@"symptom_ids"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.paymentType] forKey:@"pay_type"];
    [parameter setValue:self.publicCouponId forKey:@"coupon_id"];
    [parameter setValue:[NSString stringWithFormat:@"%f",self.publicLatterMoney] forKey:@"price"];
    
//    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
//    [parameter setValue:@"6b84e90af32911e59833780cb87fb47f" forKey:@"min_doctor_id"];
//    [parameter setValue:@"234565765645645" forKey:@"max_doctor_id"];
//    [parameter setValue:@"2016-04-22 13:02:20" forKey:@"bespoke_date"];
//    [parameter setValue:@"刘超" forKey:@"name"];
//    [parameter setValue:@"9072fdeaf31a11e59833780cb87fb47f" forKey:@"outpatId"];
//    [parameter setValue:@"500233199412157810" forKey:@"ID_no"];
//    [parameter setValue:@"13826654854" forKey:@"phone"];
//    [parameter setValue:@"2" forKey:@"sex"];
//    [parameter setValue:@"22" forKey:@"age"];
//    [parameter setValue:@"2" forKey:@"pay_type"];
//    [parameter setValue:@"5.100000" forKey:@"price"];
    
    DLog(@"%@%@",kServerAddressPay,kJZK_TREATMENT_CONFIRM_INFORMATION);
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_TREATMENT_CONFIRM_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            if (self.paymentType == 1) {
                [self paymentInfoOfflineDataParse];
            }else if (self.paymentType == 2){
                [self paymentInfoAliPayDataParse];
            }else if (self.paymentType == 3){
                [self paymentInfoWechatPayDataParse];
            }else if (self.paymentType == 4){
                [self paymentInfoUnionPayDataParse];
            }
        }else{
            DLog(@"%@",self.message);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)paymentInfoOfflineDataParse{
    self.orderNumber = [self.data objectForKey:@"orderNo"];
    
    [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
    
    [self pushTreatmentDetailViewController];
}

-(void)paymentInfoAliPayDataParse{
    self.orderNumber = [self.data objectForKey:@"orderNo"];
    self.paymentInfomation = [self.data objectForKey:@"payinfo"];
    
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
        
        [self pushTreatmentDetailViewController];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

-(void)paymentInfoWechatPayDataParse{
    DLog(@"paymentInfoWechatPayDataParse");
    self.payinfo = [self.data objectForKey:@"payinfo"];
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
    DLog(@"test");
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
-(void)reservationListDataFilling{
    [self.expertImage sd_setImageWithURL:[NSURL URLWithString:self.publicExpertImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    [self.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.publicDoctorImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.expertLabel.text = self.publicExpertName;
    self.doctorLabel.text = self.publicDoctorName;
    self.clinicLabel.text = self.publicClinicName;
    self.addressLabel.text = self.publicClinicAddress;
    self.moneyLabel1.text = [NSString stringWithFormat:@"¥ %.0f",self.publicFormerMoney];
    self.moneyLabel2.text = [NSString stringWithFormat:@"%.0f",self.publicLatterMoney];
    [self.timeImage setImage:[UIImage imageNamed:@"info_treatment_shijian_image"]];
    self.timeLabel.text = self.publicAppiontmentTime;
    
    self.label1_1.text = @"姓名：";
    self.label1_2.text = self.publicPatientName;
    self.label2_1.text = @"身份证号：";
    self.label2_2.text = self.publicPatientId;
    self.label3_1.text = @"手机号：";
    self.label3_2.text = self.publicPatientMobile;
    self.label4_1.text = @"年龄：";
    self.label4_2.text = self.publicPatientAge;
    self.label4_3.text = @"性别：";
    self.label4_4.text = self.publicPatientSex;
    self.label5_1.text = @"症状：";
    self.label5_2.text = self.publicPatientSymptom;
    self.label6_1.text = @"优惠券：";
    self.label6_2.text = @"无可用优惠券";
    
//    [self.onlineButton setTitle:[NSString stringWithFormat:@"立即支付  ¥ %.0f",self.publicLatterMoney] forState:UIControlStateNormal];
    [self.onlineButton setTitle:[NSString stringWithFormat:@"立即支付"] forState:UIControlStateNormal];
    [self.onlineButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.onlineButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_online_normal"] forState:UIControlStateNormal];
    [self.onlineButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_online_selected"] forState:UIControlStateHighlighted];
    
    [self.offlineButton setTitle:@"线下支付" forState:UIControlStateNormal];
    [self.offlineButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.offlineButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_offline_normal"] forState:UIControlStateNormal];
    [self.offlineButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_offline_selected"] forState:UIControlStateHighlighted];
}

@end
