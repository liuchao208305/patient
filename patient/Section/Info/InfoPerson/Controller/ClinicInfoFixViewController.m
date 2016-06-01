//
//  ClinicInfoFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/14.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicInfoFixViewController.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "TreatmentInfoViewController.h"
#import "ClinicDoctorData.h"
#import "AdaptionUtil.h"

@interface ClinicInfoFixViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2_1;
@property (assign,nonatomic)NSInteger code2_1;
@property (strong,nonatomic)NSString *message2_1;
@property (strong,nonatomic)NSMutableDictionary *data2_1;
@property (assign,nonatomic)NSError *error2_1;

@property (strong,nonatomic)NSMutableDictionary *result2_2;
@property (assign,nonatomic)NSInteger code2_2;
@property (strong,nonatomic)NSString *message2_2;
@property (strong,nonatomic)NSMutableDictionary *data2_2;
@property (assign,nonatomic)NSError *error2_2;

@property (strong,nonatomic)NSMutableDictionary *result2_3;
@property (assign,nonatomic)NSInteger code2_3;
@property (strong,nonatomic)NSString *message2_3;
@property (strong,nonatomic)NSMutableDictionary *data2_3;
@property (assign,nonatomic)NSError *error2_3;

@property (strong,nonatomic)NSMutableDictionary *result2_4;
@property (assign,nonatomic)NSInteger code2_4;
@property (strong,nonatomic)NSString *message2_4;
@property (strong,nonatomic)NSMutableDictionary *data2_4;
@property (assign,nonatomic)NSError *error2_4;

@property (strong,nonatomic)NSString *clinicImage;
@property (strong,nonatomic)NSString *clinicAdress;
@property (strong,nonatomic)NSString *clinicComment;

@property (strong,nonatomic)NSString *expertImage;
@property (strong,nonatomic)NSString *expertName;
@property (strong,nonatomic)NSString *expertTitle;
@property (strong,nonatomic)NSString *expertGroup;
@property (assign,nonatomic)double formerMoney;
@property (assign,nonatomic)double couponMoney;
@property (assign,nonatomic)double latterMoney;

@property (strong,nonatomic)NSString *defaultDoctorId;
@property (strong,nonatomic)NSString *doctorId;

@property (strong,nonatomic)NSMutableArray *doctorArray;
@property (strong,nonatomic)NSMutableArray *doctorIdArray;
@property (strong,nonatomic)NSMutableArray *doctorImageArray;
@property (strong,nonatomic)NSMutableArray *doctorNameArray;
@property (strong,nonatomic)NSMutableArray *doctorDiseaseArray;

@property (strong,nonatomic)NSString *appointmentUpTime;
@property (strong,nonatomic)NSString *appointmentDownTime;

@property (strong,nonatomic)NSString *forenoonBookStatus1;
@property (strong,nonatomic)NSString *afternoonBookStatus1;

@property (strong,nonatomic)NSString *forenoonBookStatus2;
@property (strong,nonatomic)NSString *afternoonBookStatus2;

@property (strong,nonatomic)NSString *forenoonBookStatus3;
@property (strong,nonatomic)NSString *afternoonBookStatus3;

@property (strong,nonatomic)NSString *forenoonBookStatus4;
@property (strong,nonatomic)NSString *afternoonBookStatus4;

@property (assign,nonatomic)NSInteger currentHour;
@property (assign,nonatomic)BOOL isAfterNoon;

@end

@implementation ClinicInfoFixViewController

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
    
    self.currentHour = [[[DateUtil getCurrentTime] substringWithRange:NSMakeRange(11, 2)] integerValue];
    if (self.currentHour>0 && self.currentHour<12) {
        self.isAfterNoon = NO;
    }else if (self.currentHour>12 && self.currentHour<24){
        self.isAfterNoon = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"ClinicInfoFixViewController"];
    
    [self sendClinicDoctorRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"ClinicInfoFixViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.doctorArray = [NSMutableArray array];
    self.doctorIdArray = [NSMutableArray array];
    self.doctorImageArray = [NSMutableArray array];
    self.doctorNameArray = [NSMutableArray array];
    self.doctorDiseaseArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = self.clinicName;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title = self.clinicName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.9*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.6*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix]){
        self.scrollView.contentSize = CGSizeMake(0, 1.4*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.25*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 168+60)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initBackView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 168+60+10, SCREEN_WIDTH, 50+1+150)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initBackView2];
    [self.scrollView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 168+60+10+50+1+150+10, SCREEN_WIDTH, 50+1+175)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initBackView3];
    [self.scrollView addSubview:self.backView3];
    
    self.backView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 168+60+10+50+1+150+10+50+1+175+10, SCREEN_WIDTH, 154)];
    self.backView4.backgroundColor = kWHITE_COLOR;
    [self initBackView4];
    [self.scrollView addSubview:self.backView4];
}

-(void)initBackView1{
    self.clinicImageView = [[UIImageView alloc] init];
    [self.clinicImageView setImage:[UIImage imageNamed:@"default_image_big"]];
    [self.backView1 addSubview:self.clinicImageView];
    
    self.addressImageView = [[UIImageView alloc] init];
    [self.addressImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.addressImageView];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"test";
    [self.backView1 addSubview:self.addressLabel];
    
    self.starImageView1 = [[UIImageView alloc] init];
    [self.starImageView1 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.starImageView1];
    
    self.starImageView2 = [[UIImageView alloc] init];
    [self.starImageView2 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.starImageView2];
    
    self.starImageView3 = [[UIImageView alloc] init];
    [self.starImageView3 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.starImageView3];
    
    self.starImageView4 = [[UIImageView alloc] init];
    [self.starImageView4 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.starImageView4];
    
    self.starImageView5 = [[UIImageView alloc] init];
    [self.starImageView5 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.starImageView5];
    
    [self.clinicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1).offset(0);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(168);
    }];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clinicImageView).offset(168+8);
        make.leading.equalTo(self.backView1).offset(12);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.addressImageView).offset(15+6);
        make.centerY.equalTo(self.addressImageView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-12-15-6);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.addressImageView).offset(15+6);
        make.top.equalTo(self.addressLabel).offset(15+10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView1).offset(15+5);
        make.centerY.equalTo(self.starImageView1).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView2).offset(15+5);
        make.centerY.equalTo(self.starImageView2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView3).offset(15+5);
        make.centerY.equalTo(self.starImageView3).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView4).offset(15+5);
        make.centerY.equalTo(self.starImageView4).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
}

-(void)initBackView2{
    self.expertTitleImageView = [[UIImageView alloc] init];
//    [self.expertTitleImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView2 addSubview:self.expertTitleImageView];
    
    self.expertTitleLabel = [[UILabel alloc] init];
//    self.expertTitleLabel.text = @"test";
    [self.backView2 addSubview:self.expertTitleLabel];
    
    self.expertLineView = [[UIView alloc] init];
    self.expertLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.expertLineView];
    
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 39;
//    [self.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView2 addSubview:self.expertImageView];
    
    self.expertLabel1 = [[UILabel alloc] init];
//    self.expertLabel1.text = @"test";
    [self.backView2 addSubview:self.expertLabel1];
    
    self.expertLabel2 = [[UILabel alloc] init];
//    self.expertLabel2.text = @"test";
    [self.backView2 addSubview:self.expertLabel2];
    
    self.expertLabel3 = [[UILabel alloc] init];
//    self.expertLabel3.text = @"test";
    [self.backView2 addSubview:self.expertLabel3];
    
    self.moneyLabel1 = [[UILabel alloc] init];
    self.moneyLabel1.textColor = ColorWithHexRGB(0x909090);
//    self.moneyLabel1.text = @"test";
    self.moneyLabel1.textAlignment = NSTextAlignmentRight;
    [self.backView2 addSubview:self.moneyLabel1];
    
    self.moneyLabel2 = [[UILabel alloc] init];
    self.moneyLabel2.textColor = [UIColor redColor];
//    self.moneyLabel2.text = @"test";
    self.moneyLabel2.textAlignment = NSTextAlignmentRight;
    [self.backView2 addSubview:self.moneyLabel2];
    
    [self.expertTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12);
        make.top.equalTo(self.backView2).offset(16);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertTitleImageView).offset(15+6);
        make.centerY.equalTo(self.expertTitleImageView).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(0);
        make.trailing.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12);
        make.top.equalTo(self.expertLineView).offset(12);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(78);
    }];
    
    [self.expertLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView).offset(78+10);
        make.top.equalTo(self.expertLineView).offset(26);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        [self.expertLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.expertLabel1).offset(60+10);
            make.centerY.equalTo(self.expertLabel1).offset(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
    }else if ([AdaptionUtil isIphoneFive] || [AdaptionUtil isIphoneSixPlus]){
        [self.expertLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.expertLabel1).offset(100+10);
            make.centerY.equalTo(self.expertLabel1).offset(0);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
    }
    
    [self.expertLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertLabel1).offset(0);
        make.top.equalTo(self.expertLabel1).offset(15+22);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView2).offset(-10);
        make.centerY.equalTo(self.expertLabel2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView2).offset(-10);
        make.centerY.equalTo(self.expertLabel3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
    }];
    
    
}

-(void)initBackView3{
    self.doctorTitleImageView = [[UIImageView alloc] init];
    [self.doctorTitleImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView3 addSubview:self.doctorTitleImageView];
    
    self.doctorTitleLabel = [[UILabel alloc] init];
    self.doctorTitleLabel.text = @"test";
    [self.backView3 addSubview:self.doctorTitleLabel];
    
    self.doctorLineView = [[UIView alloc] init];
    self.doctorLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.doctorLineView];
    
    self.doctorBackView = [[UIView alloc] init];
    self.doctorBackView.backgroundColor = kWHITE_COLOR;
//    [self initDoctorScrollView];
    [self.backView3 addSubview:self.doctorBackView];
    
    [self.doctorTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(12);
        make.top.equalTo(self.backView3).offset(16);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.doctorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.doctorTitleImageView).offset(15+6);
        make.centerY.equalTo(self.doctorTitleImageView).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    [self.doctorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.backView3).offset(50);
        make.height.mas_equalTo(1);
    }];
    
    [self.doctorBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(0);
        make.trailing.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.doctorLineView).offset(1);
        make.bottom.equalTo(self.backView3).offset(0);
    }];
}

-(void)initDoctorScrollView{
    self.doctorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    
    self.doctorScrollView.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    self.doctorScrollView.userInteractionEnabled = YES;
    self.doctorScrollView.directionalLockEnabled = YES;
    self.doctorScrollView.pagingEnabled = NO;
    self.doctorScrollView.bounces = NO;
    self.doctorScrollView.showsHorizontalScrollIndicator = NO;
    self.doctorScrollView.showsVerticalScrollIndicator = NO;
    
    [self.doctorBackView addSubview:self.doctorScrollView];
    
//    for (int i = 0; i<10; i++) {
//        ClinicDoctorView *doctorView = [[ClinicDoctorView alloc] init];
//        doctorView.tag = i;
//        doctorView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-69*3)/4+i*69, 16, 69, 150);
//        [doctorView.doctorImage setImage:[UIImage imageNamed:@"default_image_small"]];
//        doctorView.doctorName.text = @"test";
//        doctorView.doctorDomain.text = @"test";
//        [self.doctorScrollView addSubview:doctorView];
//        
//        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doctorViewClicked:)];
//        [doctorView addGestureRecognizer:recognizer];
//    }
//    
//    self.doctorScrollView.contentSize = CGSizeMake(10*(27+69)+27, 0);
    
    for (int i = 0; i<self.doctorArray.count; i++) {
        self.doctorView = [[ClinicDoctorView alloc] init];
        self.doctorView.tag = i;
        self.doctorView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-69*3)/4+i*69, 16, 69, 150);
        
//        self.doctorView.doctorImage.layer.cornerRadius = 69/2;
        [self.doctorView.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.doctorImageArray[i]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        if (self.defaultDoctorId == self.doctorIdArray[i]) {
            self.doctorId = self.defaultDoctorId;
            self.doctorView.doctorImage.layer.borderWidth = 2;
            self.doctorView.doctorImage.layer.borderColor = kMAIN_COLOR.CGColor;
        }
        
        if (self.doctorId == self.doctorIdArray[i]) {
            self.doctorId = self.doctorId;
            self.doctorView.doctorImage.layer.borderWidth = 2;
            self.doctorView.doctorImage.layer.borderColor = kMAIN_COLOR.CGColor;
        }

        self.doctorView.doctorName.text = self.doctorNameArray[i];
        //            self.doctorView.doctorDomain.text = self.doctorDiseaseArray[i];
        [self.doctorScrollView addSubview:self.doctorView];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doctorViewClicked:)];
        [self.doctorView addGestureRecognizer:recognizer];
    }
    
    self.doctorScrollView.contentSize = CGSizeMake(self.doctorArray.count*(27+69)+27, 0);
    
}

-(void)initBackView4{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:[DateUtil getFirstDate], [DateUtil getSecondDate], [DateUtil getThirdDate],[DateUtil getFourthDate],nil];
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:13] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:0];
        [self.backView4 addSubview:self.segmentControl];
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:0];
        [self.backView4 addSubview:self.segmentControl];
    }
    self.segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 1)];
    self.segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.backView4 addSubview:self.segmentBottomLineView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 154-43)];
    self.backView.backgroundColor = kBACKGROUND_COLOR;
    [self.backView4 addSubview:self.backView];
    
    //默认相关配置(请求网络、数据解析、绘制画面、填充数据)
}

/*==================================================================================================*/
-(void)initSubBackView1{
    self.backUpView1 = [[UIView alloc] init];
    self.backUpView1.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView1];
    
    self.backDownView1 = [[UIView alloc] init];
    self.backDownView1.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView1];
    
    [self.backUpView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView1];
}

-(void)initSubView1{
    self.label1_1 = [[UILabel alloc] init];
//        self.label1_1.text = @"上午";
    [self.backUpView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
//        self.label1_2.text = @"预计";
    [self.backUpView1 addSubview:self.label1_2];
    
    self.label1_3  = [[UILabel alloc] init];
//        self.label1_3.text = @"08:00-12:00";
    [self.backUpView1 addSubview:self.label1_3];
    
    self.couponButton1_1 = [[UIButton alloc] init];
    //    self.couponButton1_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView1 addSubview:self.couponButton1_1];
    
    self.button1_1  = [[UIButton alloc] init];
    //    [self.button1_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    self.button1_1.tag = 1000+1;
    [self.backUpView1 addSubview:self.button1_1];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView1).offset(10);
        make.centerY.equalTo(self.backUpView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(50+10);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(50+10);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(100+10);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView1).offset(-10);
        make.centerY.equalTo(self.backUpView1).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label1_4 = [[UILabel alloc] init];
    //    self.label1_4.text = @"下午";
    [self.backDownView1 addSubview:self.label1_4];
    
    self.label1_5 = [[UILabel alloc] init];
    //    self.label1_5.text = @"预计";
    [self.backDownView1 addSubview:self.label1_5];
    
    self.label1_6  = [[UILabel alloc] init];
    //    self.label1_6.text = @"14:00-18:00";
    [self.backDownView1 addSubview:self.label1_6];
    
    self.couponButton1_2 = [[UIButton alloc] init];
    //    self.couponButton1_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView1 addSubview:self.couponButton1_2];
    
    self.button1_2  = [[UIButton alloc] init];
    //    [self.button1_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    self.button1_2.tag = 1000+2;
    [self.backDownView1 addSubview:self.button1_2];
    
    [self.label1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView1).offset(10);
        make.centerY.equalTo(self.backDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_4).offset(50+10);
        make.centerY.equalTo(self.label1_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_5).offset(50+10);
        make.centerY.equalTo(self.label1_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_6).offset(100+10);
        make.centerY.equalTo(self.label1_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView1).offset(-10);
        make.centerY.equalTo(self.backDownView1).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initSubBackView2{
    self.backUpView2 = [[UIView alloc] init];
    self.backUpView2.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView2];
    
    self.backDownView2 = [[UIView alloc] init];
    self.backDownView2.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView2];
    
    [self.backUpView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView2];
}

-(void)initSubView2{
    self.label2_1 = [[UILabel alloc] init];
//    self.label2_1.text = @"2_1";
    [self.backUpView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
//    self.label2_2.text = @"2_2";
    [self.backUpView2 addSubview:self.label2_2];
    
    self.label2_3  = [[UILabel alloc] init];
//    self.label2_3.text = @"2_3";
    [self.backUpView2 addSubview:self.label2_3];
    
    self.couponButton2_1 = [[UIButton alloc] init];
    //    self.couponButton2_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView2 addSubview:self.couponButton2_1];
    
    self.button2_1  = [[UIButton alloc] init];
    //    [self.button2_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    self.button2_1.tag = 1000+3;
    [self.backUpView2 addSubview:self.button2_1];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView2).offset(10);
        make.centerY.equalTo(self.backUpView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(50+10);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(50+10);
        make.centerY.equalTo(self.label2_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_3).offset(100+10);
        make.centerY.equalTo(self.label2_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView2).offset(-10);
        make.centerY.equalTo(self.backUpView2).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label2_4 = [[UILabel alloc] init];
//    self.label2_4.text = @"2_4";
    [self.backDownView2 addSubview:self.label2_4];
    
    self.label2_5 = [[UILabel alloc] init];
//    self.label2_5.text = @"2_5";
    [self.backDownView2 addSubview:self.label2_5];
    
    self.label2_6  = [[UILabel alloc] init];
//    self.label2_6.text = @"2_6";
    [self.backDownView2 addSubview:self.label2_6];
    
    self.couponButton2_2 = [[UIButton alloc] init];
    //    self.couponButton2_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView2 addSubview:self.couponButton2_2];
    
    self.button2_2  = [[UIButton alloc] init];
    //    [self.button2_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    self.button2_2.tag = 1000+4;
    [self.backDownView2 addSubview:self.button2_2];
    
    [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView2).offset(10);
        make.centerY.equalTo(self.backDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_4).offset(50+10);
        make.centerY.equalTo(self.label2_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_5).offset(50+10);
        make.centerY.equalTo(self.label2_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_6).offset(100+10);
        make.centerY.equalTo(self.label2_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView2).offset(-10);
        make.centerY.equalTo(self.backDownView2).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initSubBackView3{
    self.backUpView3 = [[UIView alloc] init];
    self.backUpView3.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView3];
    
    self.backDownView3 = [[UIView alloc] init];
    self.backDownView3.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView3];
    
    [self.backUpView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView3];
}

-(void)initSubView3{
    self.label3_1 = [[UILabel alloc] init];
    //    self.label3_1.text = @"3_1";
    [self.backUpView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    //    self.label3_2.text = @"3_2";
    [self.backUpView3 addSubview:self.label3_2];
    
    self.label3_3  = [[UILabel alloc] init];
    //    self.label3_3.text = @"3_3";
    [self.backUpView3 addSubview:self.label3_3];
    
    self.couponButton3_1 = [[UIButton alloc] init];
    //    self.couponButton3_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView3 addSubview:self.couponButton3_1];
    
    self.button3_1  = [[UIButton alloc] init];
    //    [self.button3_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    self.button3_1.tag = 1000+5;
    [self.backUpView3 addSubview:self.button3_1];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView3).offset(10);
        make.centerY.equalTo(self.backUpView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(50+10);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(50+10);
        make.centerY.equalTo(self.label3_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_3).offset(100+10);
        make.centerY.equalTo(self.label3_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView3).offset(-10);
        make.centerY.equalTo(self.backUpView3).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label3_4 = [[UILabel alloc] init];
    //    self.label3_4.text = @"3_4";
    [self.backDownView3 addSubview:self.label3_4];
    
    self.label3_5 = [[UILabel alloc] init];
    //    self.label3_5.text = @"3_5";
    [self.backDownView3 addSubview:self.label3_5];
    
    self.label3_6  = [[UILabel alloc] init];
    //    self.label3_6.text = @"3_6";
    [self.backDownView3 addSubview:self.label3_6];
    
    self.couponButton3_2 = [[UIButton alloc] init];
    //    self.couponButton3_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView3 addSubview:self.couponButton3_2];
    
    self.button3_2  = [[UIButton alloc] init];
    //    [self.button3_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    self.button3_2.tag = 1000+6;
    [self.backDownView3 addSubview:self.button3_2];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView3).offset(10);
        make.centerY.equalTo(self.backDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_4).offset(50+10);
        make.centerY.equalTo(self.label3_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_5).offset(50+10);
        make.centerY.equalTo(self.label3_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_6).offset(100+10);
        make.centerY.equalTo(self.label3_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView3).offset(-10);
        make.centerY.equalTo(self.backDownView3).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initSubBackView4{
    self.backUpView4 = [[UIView alloc] init];
    self.backUpView4.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView4];
    
    self.backDownView4 = [[UIView alloc] init];
    self.backDownView4.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView4];
    
    [self.backUpView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView4];
}

-(void)initSubView4{
    self.label4_1 = [[UILabel alloc] init];
    //    self.label4_1.text = @"4_1";
    [self.backUpView4 addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
    //    self.label4_2.text = @"4_2";
    [self.backUpView4 addSubview:self.label4_2];
    
    self.label4_3  = [[UILabel alloc] init];
    //    self.label4_3.text = @"4_3";
    [self.backUpView4 addSubview:self.label4_3];
    
    self.couponButton4_1 = [[UIButton alloc] init];
    //    self.couponButton4_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView4 addSubview:self.couponButton4_1];
    
    self.button4_1  = [[UIButton alloc] init];
    //    [self.button4_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    self.button4_1.tag = 1000+7;
    [self.backUpView4 addSubview:self.button4_1];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView4).offset(10);
        make.centerY.equalTo(self.backUpView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_1).offset(50+10);
        make.centerY.equalTo(self.label4_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_2).offset(50+10);
        make.centerY.equalTo(self.label4_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_3).offset(100+10);
        make.centerY.equalTo(self.label4_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView4).offset(-10);
        make.centerY.equalTo(self.backUpView4).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label4_4 = [[UILabel alloc] init];
    //    self.label4_4.text = @"4_4";
    [self.backDownView4 addSubview:self.label4_4];
    
    self.label4_5 = [[UILabel alloc] init];
    //    self.label4_5.text = @"4_5";
    [self.backDownView4 addSubview:self.label4_5];
    
    self.label4_6  = [[UILabel alloc] init];
    //    self.label4_6.text = @"4_6";
    [self.backDownView4 addSubview:self.label4_6];
    
    self.couponButton4_2 = [[UIButton alloc] init];
    //    self.couponButton4_2.backgroundColor = ColorWithHexRGB(0xC36743);
    [self.backDownView4 addSubview:self.couponButton4_2];
    
    self.button4_2  = [[UIButton alloc] init];
    //    [self.button4_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    self.button4_2.tag = 1000+8;
    [self.backDownView4 addSubview:self.button4_2];
    
    [self.label4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView4).offset(10);
        make.centerY.equalTo(self.backDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_4).offset(50+10);
        make.centerY.equalTo(self.label4_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_5).offset(50+10);
        make.centerY.equalTo(self.label4_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_6).offset(100+10);
        make.centerY.equalTo(self.label4_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView4).offset(-10);
        make.centerY.equalTo(self.backDownView4).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)doctorViewClicked:(UIGestureRecognizer *)sender{
    NSLog(@"%ld",sender.view.tag);
//    for (int i = 0; i<self.doctorArray.count; i++) {
//        self.doctorView = [[ClinicDoctorView alloc] init];
//        self.doctorView.tag = i;
//        self.doctorView.frame = CGRectMake((i+1)*(SCREEN_WIDTH-69*3)/4+i*69, 16, 69, 150);
//        
//        if (sender.view.tag == i) {
//            self.doctorView.doctorImage.layer.borderWidth = 2;
//            self.doctorView.doctorImage.layer.borderColor = kMAIN_COLOR.CGColor;
//        }
//        
//        [self.doctorScrollView addSubview:self.doctorView];
//    }
    [self initDoctorScrollView2:sender.view.tag];
}

-(void)initDoctorScrollView2:(NSInteger)number{
    self.doctorScrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    
    self.doctorScrollView2.contentSize = CGSizeMake(2*SCREEN_WIDTH, 0);
    self.doctorScrollView2.userInteractionEnabled = YES;
    self.doctorScrollView2.directionalLockEnabled = YES;
    self.doctorScrollView2.pagingEnabled = NO;
    self.doctorScrollView2.bounces = NO;
    self.doctorScrollView2.showsHorizontalScrollIndicator = NO;
    self.doctorScrollView2.showsVerticalScrollIndicator = NO;
    
    [self.doctorBackView addSubview:self.doctorScrollView2];
    
    for (int i = 0; i<self.doctorArray.count; i++) {
        self.doctorView2 = [[ClinicDoctorView alloc] init];
        self.doctorView2.tag = i;
        self.doctorView2.frame = CGRectMake((i+1)*(SCREEN_WIDTH-69*3)/4+i*69, 16, 69, 150);
        
        [self.doctorView2.doctorImage sd_setImageWithURL:[NSURL URLWithString:self.doctorImageArray[i]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        if (number == i) {
            self.doctorId = self.doctorIdArray[i];
            self.doctorView2.doctorImage.layer.borderWidth = 2;
            self.doctorView2.doctorImage.layer.borderColor = kMAIN_COLOR.CGColor;
            [self sendClinicScheduleRequest1];
        }
        
        self.doctorView2.doctorName.text = self.doctorNameArray[i];
        //            self.doctorView.doctorDomain.text = self.doctorDiseaseArray[i];
        [self.doctorScrollView2 addSubview:self.doctorView2];
        
        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doctorViewClicked:)];
        [self.doctorView2 addGestureRecognizer:recognizer];
    }
    
    self.doctorScrollView2.contentSize = CGSizeMake(self.doctorArray.count*(27+69)+27, 0);
    
}

-(void)reservationButton1_1Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    treatVC.appointmentTime = [DateUtil getFirstTime];
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton1_2Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getFirstTime];
    }else{
        treatVC.appointmentTime = [DateUtil getFirstTimeFix];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton2_1Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getFirstTimeFix];
    }else{
        treatVC.appointmentTime = [DateUtil getSecondTime];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton2_2Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getSecondTime];
    }else{
        treatVC.appointmentTime = [DateUtil getSecondTimeFix];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton3_1Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getSecondTimeFix];
    }else{
        treatVC.appointmentTime = [DateUtil getThirdTime];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton3_2Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getThirdTime];
    }else{
        treatVC.appointmentTime = [DateUtil getThirdTimeFix];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton4_1Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getThirdTimeFix];
    }else{
        treatVC.appointmentTime = [DateUtil getFourthTime];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

-(void)reservationButton4_2Clicked{
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.doctorId;
    
    if (self.isAfterNoon) {
        treatVC.appointmentTime = [DateUtil getFourthTime];
    }else{
        treatVC.appointmentTime = [DateUtil getFourthTimeFix];
    }
    
    [self.navigationController pushViewController:treatVC animated:YES];
}

#pragma mark Network Request
-(void)sendClinicDoctorRequest{
    DLog(@"sendClinicDoctorRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.clinicId forKey:@"outpatId"];
    [parameter setValue:self.expertId forKey:@"doctorId"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_DOCTOR_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self clinicDoctorDataParse];
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

-(void)sendClinicScheduleRequest1{
    DLog(@"sendClinicScheduleRequest1");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.doctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getFirstTime] forKey:@"date"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2_1 = (NSMutableDictionary *)responseObject;
        
        self.code2_1 = [[self.result2_1 objectForKey:@"code"] integerValue];
        self.message2_1 = [self.result2_1 objectForKey:@"message"];
        self.data2_1 = [self.result2_1 objectForKey:@"data"];
        
        if (self.code2_1 == kSUCCESS) {
            [self clinicScheduleDataParse1];
        }else{
            DLog(@"%ld",(long)self.code2_1);
            DLog(@"%@",self.message2_1);
            [HudUtil showSimpleTextOnlyHUD:self.message2_1 withDelaySeconds:kHud_DelayTime];
        }
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendClinicScheduleRequest2{
    DLog(@"sendClinicScheduleRequest2");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.doctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getSecondTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2_2 = (NSMutableDictionary *)responseObject;
        
        self.code2_2 = [[self.result2_2 objectForKey:@"code"] integerValue];
        self.message2_2 = [self.result2_2 objectForKey:@"message"];
        self.data2_2 = [self.result2_2 objectForKey:@"data"];
        
        if (self.code2_2 == kSUCCESS) {
            [self clinicScheduleDataParse2];
        }else{
            DLog(@"%@",self.message2_2);
            [HudUtil showSimpleTextOnlyHUD:self.message2_2 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendClinicScheduleRequest3{
    DLog(@"sendClinicScheduleRequest3");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.doctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getThirdTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2_3 = (NSMutableDictionary *)responseObject;
        
        self.code2_3 = [[self.result2_3 objectForKey:@"code"] integerValue];
        self.message2_3 = [self.result2_3 objectForKey:@"message"];
        self.data2_3 = [self.result2_3 objectForKey:@"data"];
        
        if (self.code2_3 == kSUCCESS) {
            [self clinicScheduleDataParse3];
        }else{
            DLog(@"%@",self.message2_3);
            [HudUtil showSimpleTextOnlyHUD:self.message2_3 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendClinicScheduleRequest4{
    DLog(@"sendClinicScheduleRequest4");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.doctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getFourthTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2_4 = (NSMutableDictionary *)responseObject;
        
        self.code2_4 = [[self.result2_4 objectForKey:@"code"] integerValue];
        self.message2_4 = [self.result2_4 objectForKey:@"message"];
        self.data2_4 = [self.result2_4 objectForKey:@"data"];
        
        if (self.code2_4 == kSUCCESS) {
            [self clinicScheduleDataParse4];
        }else{
            DLog(@"%@",self.message2_4);
            [HudUtil showSimpleTextOnlyHUD:self.message2_4 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)clinicDoctorDataParse{
    self.clinicImage = [[self.data objectForKey:@"outpats"] objectForKey:@"coverUrl"];
    self.clinicAdress = [[self.data objectForKey:@"outpats"] objectForKey:@"address"];
    self.clinicComment = [[self.data objectForKey:@"outpats"] objectForKey:@"commonResult"];
    self.couponMoney = [[[self.data objectForKey:@"outpats"] objectForKey:@"money"] doubleValue];
    
    self.expertImage = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"heandUrl"];
    self.expertName = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"doctorName"];
    self.expertTitle = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"zhicheng"];
    if (![[self.data objectForKey:@"zhuanjia"] objectForKey:@"orgName"]) {
        self.expertGroup = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"orgName"];
    }
    self.formerMoney = [[[self.data objectForKey:@"zhuanjia"] objectForKey:@"serviceMoney"] doubleValue];
    self.latterMoney = self.formerMoney - self.couponMoney;
    
    self.defaultDoctorId = [self.data objectForKey:@"default_doctorId"];
    DLog(@"%@",self.defaultDoctorId);
    
    self.doctorArray = [ClinicDoctorData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"doctors"]];
    for (ClinicDoctorData *clinicDoctorData in self.doctorArray) {
        [self.doctorIdArray addObject:[NullUtil judgeStringNull:clinicDoctorData.doctor_id]];
        [self.doctorImageArray addObject:[NullUtil judgeStringNull:clinicDoctorData.heandUrl]];
        [self.doctorNameArray addObject:[NullUtil judgeStringNull:clinicDoctorData.doctor_name]];
//        [self.doctorDiseaseArray addObject:[NullUtil judgeStringNull:clinicDoctorData.cook_wx]];
    }
    
    self.appointmentUpTime = [[self.data objectForKey:@"outpats"] objectForKey:@"up_date"];
    self.appointmentDownTime = [[self.data objectForKey:@"outpats"] objectForKey:@"down_date"];
    
    [self clinicDoctorDataFilling];
    
    if (self.doctorArray.count > 0) {
        [self initBackView4];
        [self initSubBackView1];
        [self sendClinicScheduleRequest1];
    }else{
        [AlertUtil showSimpleAlertWithTitle:nil message:@"此门诊暂时没有门诊医生！"];
    }
}

-(void)clinicScheduleDataParse1{
    self.forenoonBookStatus1 = [self.data2_1 objectForKey:@"up"];
    self.afternoonBookStatus1 = [self.data2_1 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus1-->%@afternoonBookStatus1-->%@",self.forenoonBookStatus1,self.afternoonBookStatus1);
    
    [self clinicScheduleDataFilling1];
}

-(void)clinicScheduleDataParse2{
    self.forenoonBookStatus2 = [self.data2_2 objectForKey:@"up"];
    self.afternoonBookStatus2 = [self.data2_2 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus2-->%@afternoonBookStatus2-->%@",self.forenoonBookStatus2,self.afternoonBookStatus2);
    
    [self clinicScheduleDataFilling2];
}

-(void)clinicScheduleDataParse3{
    self.forenoonBookStatus3 = [self.data2_3 objectForKey:@"up"];
    self.afternoonBookStatus3 = [self.data2_3 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus3-->%@afternoonBookStatus3-->%@",self.forenoonBookStatus3,self.afternoonBookStatus3);
    
    [self clinicScheduleDataFilling3];
}

-(void)clinicScheduleDataParse4{
    self.forenoonBookStatus4 = [self.data2_4 objectForKey:@"up"];
    self.afternoonBookStatus4 = [self.data2_4 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus4-->%@afternoonBookStatus4-->%@",self.forenoonBookStatus4,self.afternoonBookStatus4);
    
    [self clinicScheduleDataFilling4];
}

#pragma mark Data Filling
-(void)clinicDoctorDataFilling{
    [self.clinicImageView sd_setImageWithURL:[NSURL URLWithString:self.clinicImage] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
    [self.addressImageView setImage:[UIImage imageNamed:@"info_clinic_clinic_title_image"]];
    self.addressLabel.text = self.clinicAdress;
    
    if ([self.clinicComment integerValue] == 0) {
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>0 && [self.clinicComment integerValue]<11){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>10 && [self.clinicComment integerValue]<21){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>20 && [self.clinicComment integerValue]<31){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>30 && [self.clinicComment integerValue]<41){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>40 && [self.clinicComment integerValue]<51){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>50 && [self.clinicComment integerValue]<61){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>60 && [self.clinicComment integerValue]<71){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>70 && [self.clinicComment integerValue]<81){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
    }else if ([self.clinicComment integerValue]>80 && [self.clinicComment integerValue]<91){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
    }else if ([self.clinicComment integerValue]>90 && [self.clinicComment integerValue]<101){
        [self.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        [self.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
    }
    
    [self.expertTitleImageView setImage:[UIImage imageNamed:@"info_clinic_expert_title_image"]];
    self.expertTitleLabel.text = @"特需服务专家";
    [self.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    self.expertLabel1.text = self.expertName;
    self.expertLabel2.text = self.expertTitle;
    self.expertLabel3.text = self.expertGroup;
//    self.moneyLabel1.text = [NSString stringWithFormat:@"¥ %ld",(long)self.formerMoney];
    
    NSString *oldPrice = [NSString stringWithFormat:@"¥ %.2f",self.formerMoney];
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:ColorWithHexRGB(0x909090) range:NSMakeRange(2, length-2)];
    [self.moneyLabel1 setAttributedText:attri];
    
    self.moneyLabel2.text = [NSString stringWithFormat:@"%.2f",self.latterMoney];
    
    [self.doctorTitleImageView setImage:[UIImage imageNamed:@"info_clinic_doctor_title_image"]];
    self.doctorTitleLabel.text = @"线下门诊医生";
    [self initDoctorScrollView];
}

-(void)clinicScheduleDataFilling1{
    self.label1_1.text = @"上午";
    self.label1_2.text = @"预计";
    self.label1_3.text = self.appointmentUpTime;
    
//    if (self.isAfterNoon) {
//        [self.button1_1 setTitle:@"预约" forState:UIControlStateNormal];
//        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
//        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
//    }else{
//        if ([self.forenoonBookStatus1 integerValue] == 0) {
//            [self.button1_1 setTitle:@"预约" forState:UIControlStateNormal];
//            [self.button1_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
//            [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//            //        self.button1_1.tag = 1000+1;
//            [self.button1_1 addTarget:self action:@selector(reservationButton1_1Clicked) forControlEvents:UIControlEventTouchUpInside];
//        }else if ([self.forenoonBookStatus1 integerValue] == 1){
//            [self.button1_1 setTitle:@"已约满" forState:UIControlStateNormal];
//            [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
//            [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
//        }else if ([self.forenoonBookStatus1 integerValue] == 2){
//            [self.button1_1 setTitle:@"未排班" forState:UIControlStateNormal];
//            [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
//            [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
//        }else if ([self.forenoonBookStatus1 integerValue] == 3){
//            [self.button1_1 setTitle:@"已请假" forState:UIControlStateNormal];
//            [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
//            [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
//        }
//    }
    
    if ([self.forenoonBookStatus1 integerValue] == 0) {
        [self.button1_1 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button1_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
        //        self.button1_1.tag = 1000+1;
        [self.button1_1 addTarget:self action:@selector(reservationButton1_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.forenoonBookStatus1 integerValue] == 1){
        [self.button1_1 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus1 integerValue] == 2){
        [self.button1_1 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus1 integerValue] == 3){
        [self.button1_1 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus1 integerValue] == 4){
        [self.button1_1 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
    
    self.label1_4.text = @"下午";
    self.label1_5.text = @"预计";
    self.label1_6.text = self.appointmentDownTime;
    if ([self.afternoonBookStatus1 integerValue] == 0) {
        [self.button1_2 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button1_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button1_2.tag = 1000+2;
        [self.button1_2 addTarget:self action:@selector(reservationButton1_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.afternoonBookStatus1 integerValue] == 1){
        [self.button1_2 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus1 integerValue] == 2){
        [self.button1_2 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus1 integerValue] == 3){
        [self.button1_2 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
}

-(void)clinicScheduleDataFilling2{
    self.label2_1.text = @"上午";
    self.label2_2.text = @"预计";
    self.label2_3.text = self.appointmentUpTime;
    if ([self.forenoonBookStatus2 integerValue] == 0) {
        [self.button2_1 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button2_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button2_1.tag = 1000+3;
        [self.button2_1 addTarget:self action:@selector(reservationButton2_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.forenoonBookStatus2 integerValue] == 1){
        [self.button2_1 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus2 integerValue] == 2){
        [self.button2_1 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus2 integerValue] == 3){
        [self.button2_1 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
    
    self.label2_4.text = @"下午";
    self.label2_5.text = @"预计";
    self.label2_6.text = self.appointmentDownTime;
    if ([self.afternoonBookStatus2 integerValue] == 0) {
        [self.button2_2 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button2_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button2_2.tag = 1000+4;
        [self.button2_2 addTarget:self action:@selector(reservationButton2_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.afternoonBookStatus2 integerValue] == 1){
        [self.button2_2 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus2 integerValue] == 2){
        [self.button2_2 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus2 integerValue] == 3){
        [self.button2_2 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
}

-(void)clinicScheduleDataFilling3{
    self.label3_1.text = @"上午";
    self.label3_2.text = @"预计";
    self.label3_3.text = self.appointmentUpTime;
    if ([self.forenoonBookStatus3 integerValue] == 0) {
        [self.button3_1 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button3_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button3_1.tag = 1000+5;
        [self.button3_1 addTarget:self action:@selector(reservationButton3_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.forenoonBookStatus3 integerValue] == 1){
        [self.button3_1 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button3_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus3 integerValue] == 2){
        [self.button3_1 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button3_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus3 integerValue] == 3){
        [self.button3_1 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button3_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
    
    self.label3_4.text = @"下午";
    self.label3_5.text = @"预计";
    self.label3_6.text = self.appointmentDownTime;
    if ([self.afternoonBookStatus3 integerValue] == 0) {
        [self.button3_2 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button3_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button3_2.tag = 1000+6;
        [self.button3_2 addTarget:self action:@selector(reservationButton3_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.afternoonBookStatus3 integerValue] == 1){
        [self.button3_2 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button3_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus3 integerValue] == 2){
        [self.button3_2 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button3_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus3 integerValue] == 3){
        [self.button3_2 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button3_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button3_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
}

-(void)clinicScheduleDataFilling4{
    self.label4_1.text = @"上午";
    self.label4_2.text = @"预计";
    self.label4_3.text = self.appointmentUpTime;
    if ([self.forenoonBookStatus4 integerValue] == 0) {
        [self.button4_1 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button4_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button4_1.tag = 1000+7;
        [self.button4_1 addTarget:self action:@selector(reservationButton4_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.forenoonBookStatus4 integerValue] == 1){
        [self.button4_1 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button4_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus4 integerValue] == 2){
        [self.button4_1 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button4_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.forenoonBookStatus4 integerValue] == 3){
        [self.button4_1 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button4_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
    
    self.label4_4.text = @"下午";
    self.label4_5.text = @"预计";
    self.label4_6.text = self.appointmentDownTime;
    if ([self.afternoonBookStatus4 integerValue] == 0) {
        [self.button4_2 setTitle:@"预约" forState:UIControlStateNormal];
        [self.button4_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
//        self.button4_2.tag = 1000+8;
        [self.button4_2 addTarget:self action:@selector(reservationButton4_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    }else if ([self.afternoonBookStatus4 integerValue] == 1){
        [self.button4_2 setTitle:@"已约满" forState:UIControlStateNormal];
        [self.button4_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus4 integerValue] == 2){
        [self.button4_2 setTitle:@"未排班" forState:UIControlStateNormal];
        [self.button4_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }else if ([self.afternoonBookStatus4 integerValue] == 3){
        [self.button4_2 setTitle:@"已请假" forState:UIControlStateNormal];
        [self.button4_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.button4_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    }
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        [self initSubBackView1];
        [self sendClinicScheduleRequest1];
    }else if (selection == 1){
        [self initSubBackView2];
        [self sendClinicScheduleRequest2];
    }else if (selection == 2){
        [self initSubBackView3];
        [self sendClinicScheduleRequest3];
    }else if (selection == 3){
        [self initSubBackView4];
        [self sendClinicScheduleRequest4];
    }
}

@end
