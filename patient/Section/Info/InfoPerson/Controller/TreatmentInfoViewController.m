//
//  TreatmentInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TreatmentInfoViewController.h"
#import "ReservationListViewController.h"
#import "DateUtil.h"
#import "NetworkUtil.h"
#import "CommonUtil.h"
#import "LoginViewController.h"
#import "HudUtil.h"
#import "ContactCheckViewController.h"

@interface TreatmentInfoViewController ()<UITextFieldDelegate,ContactDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *expertImageString;
@property (strong,nonatomic)NSString *doctorImageString;
@property (strong,nonatomic)NSString *expertName;
@property (strong,nonatomic)NSString *doctorName;
@property (strong,nonatomic)NSString *clinicName;
@property (strong,nonatomic)NSString *clinicAddress;
@property (assign,nonatomic)double formerMoney;
@property (assign,nonatomic)double couponMoney;
@property (assign,nonatomic)double latterMoney;
@property (strong,nonatomic)NSString *appiontmentTime1;
@property (strong,nonatomic)NSString *appiontmentTime2;

@property (strong,nonatomic)NSString *patientSex;
@property (strong,nonatomic)NSString *patientSymptom;

@end

@implementation TreatmentInfoViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
//    [self sendTreatmentInfoRequest];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    DLog(@"%@",self.expertId);
//    DLog(@"%@",self.clinicId);
//    DLog(@"%@",self.doctorId);
//    DLog(@"%@",[DateUtil getFirstTime]);
//    DLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token]);
    if ([CommonUtil judgeIsLoginSuccess] == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
    [self sendTreatmentInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    label.text = @"填写就诊信息";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
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
    
//    self.backView = [[UIView alloc] init];
//    self.backView.backgroundColor = kBACKGROUND_COLOR;
//    [self.scrollView addSubview:self.backView];
    
//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.scrollView).offset(0);
//        make.leading.equalTo(self.scrollView).offset(0);
//        make.trailing.equalTo(self.scrollView).offset(0);
//        make.bottom.equalTo(self.scrollView).offset(0);
//    }];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initBackView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 150+10, SCREEN_WIDTH, SCREEN_HEIGHT*1.5-150-10)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initBackView2];
    [self.scrollView addSubview:self.backView2];
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
    [self.expertImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.expertImage];
    
    self.doctorImage = [[UIImageView alloc] init];
    [self.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
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
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"test";
    [self.backView1 addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView).offset(1+10);
        make.trailing.equalTo(self.backView1).offset(-10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView2{
    self.commonLabel = [[UILabel alloc] init];
    self.commonLabel.text = @"test";
    [self.backView2 addSubview:self.commonLabel];
    
    [self.commonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(10);
        make.top.equalTo(self.backView2).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    self.contactView = [[UIView alloc] init];
    [self.backView2 addSubview:self.contactView];
    
    [self.contactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commonLabel).offset(0);
        make.trailing.equalTo(self.backView2).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];

    self.contactImage = [[UIImageView alloc] init];
    [self.contactImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contactView addSubview:self.contactImage];
    
    self.contactLabel  = [[UILabel alloc] init];
    self.contactLabel.text = @"test";
    [self.contactView addSubview:self.contactLabel];

    [self.contactImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contactView).offset(0);
        make.centerY.equalTo(self.contactView).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contactImage).offset(15+5);
        make.centerY.equalTo(self.contactImage).offset(0);
        make.trailing.equalTo(self.contactView).offset(0);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView1];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.commonLabel).offset(0);
        make.top.equalTo(self.commonLabel).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"test";
    [self.backView2 addSubview:self.label1];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView1).offset(0);
        make.top.equalTo(self.lineView1).offset(1+10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    
    self.textfield1 = [[UITextField alloc] init];
//    self.textfield1.placeholder = @"test";
    self.textfield1.delegate = self;
    [self.backView2 addSubview:self.textfield1];
    
    [self.textfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(70+5);
        make.centerY.equalTo(self.label1).offset(0);
        make.trailing.equalTo(self.backView2).offset(-10);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView2];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(0);
        make.top.equalTo(self.label1).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"test";
    [self.backView2 addSubview:self.label2];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView2).offset(0);
        make.top.equalTo(self.lineView2).offset(1+10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    
    self.textfield2 = [[UITextField alloc] init];
//    self.textfield2.placeholder = @"test";
    self.textfield2.delegate = self;
    [self.backView2 addSubview:self.textfield2];
    
    [self.textfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2).offset(70+5);
        make.centerY.equalTo(self.label2).offset(0);
        make.trailing.equalTo(self.backView2).offset(-10);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView3];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2).offset(0);
        make.top.equalTo(self.label2).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"test";
    [self.backView2 addSubview:self.label3];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView3).offset(0);
        make.top.equalTo(self.lineView3).offset(1+10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    
    self.textfield3 = [[UITextField alloc] init];
//    self.textfield3.placeholder = @"test";
    self.textfield3.delegate = self;
    [self.backView2 addSubview:self.textfield3];
    
    [self.textfield3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3).offset(70+5);
        make.centerY.equalTo(self.label3).offset(0);
        make.trailing.equalTo(self.backView2).offset(-10);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    
    self.lineView4 = [[UIView alloc] init];
    self.lineView4.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView4];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3).offset(0);
        make.top.equalTo(self.label3).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.text = @"test";
    [self.backView2 addSubview:self.label4];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView4).offset(0);
        make.top.equalTo(self.lineView4).offset(1+10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    
    self.textfield4 = [[UITextField alloc] init];
//    self.textfield4.placeholder = @"test";
    self.textfield4.delegate = self;
    [self.backView2 addSubview:self.textfield4];
    
    [self.textfield4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4).offset(70+5);
        make.centerY.equalTo(self.label4).offset(0);
        make.trailing.equalTo(self.backView2).offset(-10);
        make.height.mas_equalTo(15);
    }];
/*=======================================================================*/
    self.lineView5 = [[UIView alloc] init];
    self.lineView5.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView5];
    
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4).offset(0);
        make.top.equalTo(self.label4).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label5 = [[UILabel alloc] init];
    self.label5.text = @"test";
    [self.backView2 addSubview:self.label5];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView5).offset(0);
        make.top.equalTo(self.lineView5).offset(1+10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(15);
    }];
    
    self.button5_1 = [[UIButton alloc] init];
    [self.button5_1 addTarget:self action:@selector(button5_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView2 addSubview:self.button5_1];
    
    self.button5_2 = [[UIButton alloc] init];
    [self.button5_2 addTarget:self action:@selector(button5_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView2 addSubview:self.button5_2];
    
    [self.button5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.button5_2).offset(-90-10);
        make.centerY.equalTo(self.label5).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    
    [self.button5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView2).offset(-10);
        make.centerY.equalTo(self.label5).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    
    if (self.isContactChecked) {
        
    }else{
        [self.button5_1 setTitle:@"男" forState:UIControlStateNormal];
        [self.button5_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button5_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
        [self.button5_2 setTitle:@"女" forState:UIControlStateNormal];
        [self.button5_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button5_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    }
/*=======================================================================*/
    self.lineView6 = [[UIView alloc] init];
    self.lineView6.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView6];
    
    [self.lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label5).offset(0);
        make.top.equalTo(self.label5).offset(15+10);
        make.trailing.equalTo(self.backView2).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    self.label6 = [[UILabel alloc] init];
    self.label6.text = @"test";
    [self.backView2 addSubview:self.label6];
    
    [self.label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView6).offset(0);
        make.top.equalTo(self.lineView6).offset(1+10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];

    /*=======================================================================*/
    self.button6_1 = [[UIButton alloc] init];
    [self.button6_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_1];
    
    self.button6_2 = [[UIButton alloc] init];
    [self.button6_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_2];
    
    self.button6_3 = [[UIButton alloc] init];
    [self.button6_3 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_3];
    
    [self.button6_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(10);
        make.top.equalTo(self.label6).offset(15+10);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_1).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_2).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_2).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    /*=======================================================================*/
    self.button6_4 = [[UIButton alloc] init];
    [self.button6_4 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_4];
    
    self.button6_5 = [[UIButton alloc] init];
    [self.button6_5 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_5];
    
    self.button6_6 = [[UIButton alloc] init];
    [self.button6_6 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_6];
    
    [self.button6_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_1).offset(0);
        make.top.equalTo(self.button6_1).offset(35+10);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_4).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_4).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_5).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_5).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    /*=======================================================================*/
    self.button6_7 = [[UIButton alloc] init];
    [self.button6_7 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_7];
    
    self.button6_8 = [[UIButton alloc] init];
    [self.button6_8 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_8];
    
    self.button6_9 = [[UIButton alloc] init];
    [self.button6_9 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button6_9];
    
    [self.button6_7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_4).offset(0);
        make.top.equalTo(self.button6_4).offset(35+10);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_7).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_7).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
    
    [self.button6_9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button6_8).offset((SCREEN_WIDTH-40)/3+10);
        make.centerY.equalTo(self.button6_8).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-40)/3);
        make.height.mas_equalTo(35);
    }];
/*=======================================================================*/
    self.confirmButton = [[UIButton alloc] init];
//    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_confirm_normal"] forState:UIControlStateNormal];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView2 addSubview:self.confirmButton];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button6_8).offset(35+60);
        make.centerX.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-60*2);
        make.height.mas_equalTo(44);
    }];
}

-(void)initRecognizer{
    self.contactView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contactViewClicked)];
    [self.contactView addGestureRecognizer:tap];
}

#pragma mark Target Action
-(void)contactViewClicked{
    ContactCheckViewController *contactCheckVC = [[ContactCheckViewController alloc] init];
    contactCheckVC.contactDelegate = self;
    [self.navigationController pushViewController:contactCheckVC animated:YES];
}

-(void)button5_1Clicked{
    self.patientSex = @"男";
    [self.button5_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button5_1 setTitleColor: kMAIN_COLOR forState:UIControlStateNormal];
    [self.button5_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
    [self.button5_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button5_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button5_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
}

-(void)button5_2Clicked{
    self.patientSex = @"女";
    [self.button5_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button5_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button5_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button5_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button5_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [self.button5_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
}

-(void)confirmButtonClicked{
    self.hidesBottomBarWhenPushed = YES;
    ReservationListViewController *reservationVC = [[ReservationListViewController alloc] init];
    
    reservationVC.expertId = self.expertId;
    reservationVC.clinicId = self.clinicId;
    reservationVC.doctorId = self.doctorId;
    reservationVC.appointmentTime = self.appointmentTime;
    
    reservationVC.publicDoctorImage = self.expertImageString;
    reservationVC.publicDoctorImage = self.doctorImageString;
    reservationVC.publicExpertName = self.expertName;
    reservationVC.publicDoctorName = self.doctorName;
    reservationVC.publicClinicName = self.clinicName;
    reservationVC.publicClinicAddress = self.clinicAddress;
    reservationVC.publicFormerMoney = self.formerMoney;
    reservationVC.publicLatterMoney = self.latterMoney;
    reservationVC.publicAppiontmentTime = self.timeLabel.text;
    
    reservationVC.publicPatientName = self.textfield1.text;
    reservationVC.publicPatientId = self.textfield2.text;
    reservationVC.publicPatientMobile = self.textfield3.text;
    reservationVC.publicPatientAge = self.textfield4.text;
    reservationVC.publicPatientSex = self.patientSex;
    reservationVC.publicPatientSymptom = self.patientSymptom;
    
    [self.navigationController pushViewController:reservationVC animated:YES];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textfield1 resignFirstResponder];
    [self.textfield2 resignFirstResponder];
    [self.textfield3 resignFirstResponder];
    [self.textfield4 resignFirstResponder];
    return YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark ContactDelegate
-(void)contactSelected:(ContactData *)contactData{
    self.isContactChecked = YES;
    
    self.textfield1.text = contactData.real_name;
    self.textfield2.text = contactData.id_number;
    self.textfield3.text = contactData.phone;
    self.textfield4.text = [NSString stringWithFormat:@"%ld",(long)contactData.age];
    if (contactData.sex == 0) {
        self.patientSex = @"男";
        [self.button5_1 setTitle:@"男" forState:UIControlStateNormal];
        [self.button5_1 setTitleColor: kMAIN_COLOR forState:UIControlStateNormal];
        [self.button5_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
        [self.button5_2 setTitle:@"女" forState:UIControlStateNormal];
        [self.button5_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button5_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    }else{
        self.patientSex = @"女";
        [self.button5_1 setTitle:@"男" forState:UIControlStateNormal];
        [self.button5_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button5_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
        [self.button5_2 setTitle:@"女" forState:UIControlStateNormal];
        [self.button5_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button5_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
    }
}

#pragma mark Network Request
-(void)sendTreatmentInfoRequest{
    DLog(@"sendTreatmentInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.expertId forKey:@"max_doctor_id"];
    [parameter setValue:self.clinicId forKey:@"outpatId"];
    [parameter setValue:self.doctorId forKey:@"min_doctor_id"];
#warning 此处应该根据上个页面所点按钮匹配相应时间
//    [parameter setValue:[DateUtil getFirstTime] forKey:@"bespoke_date"];
    [parameter setValue:self.appointmentTime forKey:@"bespoke_date"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TREATMENT_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self treatmentInfoDataParse];
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
-(void)treatmentInfoDataParse{
    self.expertImageString = [[self.data objectForKey:@"infos"] objectForKey:@"maxHeadUrl"];
    self.doctorImageString = [[self.data objectForKey:@"infos"] objectForKey:@"minHeadUrl"];
    self.expertName = [[self.data objectForKey:@"infos"] objectForKey:@"maxDoctorName"];
    self.doctorName = [[self.data objectForKey:@"infos"] objectForKey:@"minDoctorName"];
    self.clinicName = [[self.data objectForKey:@"infos"] objectForKey:@"outpatName"];
    self.clinicAddress = [[self.data objectForKey:@"infos"] objectForKey:@"address"];
    self.formerMoney = [[[self.data objectForKey:@"infos"] objectForKey:@"money"] doubleValue];
    self.couponMoney = [[[self.data objectForKey:@"infos"] objectForKey:@"favorable_money"] doubleValue];
    self.latterMoney = self.formerMoney - self.couponMoney;
    self.appiontmentTime1 = [[self.data objectForKey:@"infos"] objectForKey:@"dates"];
    self.appiontmentTime2 = [[self.data objectForKey:@"infos"] objectForKey:@"upOrdown"];
    
    [self treatmentInfoDataFilling];
}

#pragma mark Data Filling
-(void)treatmentInfoDataFilling{
    [self.expertImage sd_setImageWithURL:[NSURL URLWithString:self.expertImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    [self.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.doctorImageString] placeholderImage:[UIImage imageNamed:@"defalut_image_small"]];
    self.expertLabel.text = [NSString stringWithFormat:@"特需专家：%@",self.expertName];
    self.doctorLabel.text = [NSString stringWithFormat:@"门诊医生：%@",self.doctorName];
    self.clinicLabel.text = [NSString stringWithFormat:@"门诊地址：%@",self.clinicName];
    self.addressLabel.text = self.clinicAddress;
    self.moneyLabel1.text = [NSString stringWithFormat:@"%.0f",self.formerMoney];
    self.moneyLabel2.text = [NSString stringWithFormat:@"%.0f",self.latterMoney];
    if ([self.appiontmentTime2 intValue] == 1) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@  上午",self.appiontmentTime1];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%@  下午",self.appiontmentTime1];
    }
    
    self.commonLabel.text = @"请输入您的就诊信息：";
    [self.contactImage setImage:[UIImage imageNamed:@"info_treatment_lianxiren_image"]];
    self.contactLabel.text = @"常用联系人";
    self.label1.text = @"姓名";
    self.label2.text = @"身份证";
    self.label3.text = @"手机号码";
    self.label4.text = @"年龄";
    self.label5.text = @"性别";
    self.label6.text = @"症状";
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_confirm_normal"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_confirm_selected"] forState:UIControlStateHighlighted];
}

@end
