//
//  MineSettingViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineSettingViewController.h"
#import "AdaptionUtil.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "CommonUtil.h"
#import "AnalyticUtil.h"
#import "VerifyUtil.h"
#import "LoginViewController.h"
#import "AgreementViewController.h"
#import "BaseTabBarController.h"
#import "MineChangePasswordViewController.h"
#import "MineAboutUsViewController.h"
#import "MineCustomServiceViewController.h"

@interface MineSettingViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *patientSex;
@property (assign,nonatomic)NSInteger patientSexFix;

@end

@implementation MineSettingViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineSettingViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self mineSettingDataFilling];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineSettingViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.patientSex = @"";
    self.patientSexFix = 0;
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"个人设置";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"个人设置";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, 320-45+10+44+10+180+30+50+30);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320-45)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initSubView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 320-45+10, SCREEN_WIDTH, 44)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initSubView2];
    [self.scrollView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 320-45+10+44+10, SCREEN_WIDTH, 180)];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initSubView3];
    [self.scrollView addSubview:self.backView3];
    
    self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 320-45+10+44+10+180+30, SCREEN_WIDTH-60, 50)];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forState:UIControlStateHighlighted];
    [self.saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.saveButton];
}

-(void)initSubView1{
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"昵称";
    [self.backView1 addSubview:self.label1_1];
    
    self.textField1_1 = [[UITextField alloc] init];
    self.textField1_1.placeholder = @"请输入您的昵称";
    [self.backView1 addSubview:self.textField1_1];
    
    self.lineView1_1 = [[UIView alloc] init];
    self.lineView1_1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"姓名";
    [self.backView1 addSubview:self.label1_2];
    
    self.textField1_2 = [[UITextField alloc] init];
    self.textField1_2.placeholder = @"请输入您的姓名";
    [self.backView1 addSubview:self.textField1_2];
    
    self.lineView1_2 = [[UIView alloc] init];
    self.lineView1_2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1_2];
    
    self.label1_3 = [[UILabel alloc] init];
    self.label1_3.text = @"身份证号码";
    [self.backView1 addSubview:self.label1_3];
    
    self.textField1_3 = [[UITextField alloc] init];
    self.textField1_3.placeholder = @"请输入您的身份证号码";
    [self.backView1 addSubview:self.textField1_3];
    
    self.lineView1_3 = [[UIView alloc] init];
    self.lineView1_3.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1_3];
    
    self.label1_4 = [[UILabel alloc] init];
    self.label1_4.text = @"社保账号";
    [self.backView1 addSubview:self.label1_4];
    
    self.textField1_4 = [[UITextField alloc] init];
    self.textField1_4.placeholder = @"请输入您的社保账号";
    [self.backView1 addSubview:self.textField1_4];
    
    self.lineView1_4 = [[UIView alloc] init];
    self.lineView1_4.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1_4];
    
//    self.label1_5 = [[UILabel alloc] init];
//    self.label1_5.text = @"手机号码";
//    [self.backView1 addSubview:self.label1_5];
    
//    self.textField1_5 = [[UITextField alloc] init];
//    self.textField1_5.placeholder = @"请输入您的手机号码";
//    [self.backView1 addSubview:self.textField1_5];
    
//    self.lineView1_5 = [[UIView alloc] init];
//    self.lineView1_5.backgroundColor = kBACKGROUND_COLOR;
//    [self.backView1 addSubview:self.lineView1_5];
    
    self.label1_6 = [[UILabel alloc] init];
    self.label1_6.text = @"年龄";
    [self.backView1 addSubview:self.label1_6];
    
    self.textField1_6 = [[UITextField alloc] init];
    self.textField1_6.placeholder = @"请输入您的年龄";
    [self.backView1 addSubview:self.textField1_6];
    
    self.lineView1_6 = [[UIView alloc] init];
    self.lineView1_6.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1_6];
    
    self.label1_7 = [[UILabel alloc] init];
    self.label1_7.text = @"性别";
    [self.backView1 addSubview:self.label1_7];
    
    self.button1_7_1 = [[UIButton alloc] init];
    [self.button1_7_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button1_7_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button1_7_1 addTarget:self action:@selector(button1_7_1Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView1 addSubview:self.button1_7_1];
    
    self.button1_7_2 = [[UIButton alloc] init];
    [self.button1_7_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button1_7_2 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button1_7_2 addTarget:self action:@selector(button1_7_2Clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView1 addSubview:self.button1_7_2];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.backView1).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textField1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(100);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_1).offset(15+15);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.lineView1_1).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textField1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(100);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_2).offset(15+15);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.lineView1_2).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textField1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(100);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_3).offset(15+15);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.lineView1_3).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textField1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_4).offset(100);
        make.centerY.equalTo(self.label1_4).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_4).offset(15+15);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
//    [self.label1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.backView1).offset(15);
//        make.top.equalTo(self.lineView1_4).offset(1+15);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(15);
//    }];
    
//    [self.textField1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.label1_5).offset(100);
//        make.centerY.equalTo(self.label1_5).offset(0);
//        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
//        make.height.mas_equalTo(30);
//    }];
    
//    [self.lineView1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.label1_5).offset(15+15);
//        make.leading.equalTo(self.backView1).offset(0);
//        make.trailing.equalTo(self.backView1).offset(0);
//        make.height.mas_equalTo(1);
//    }];
    
    [self.label1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.lineView1_4).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.textField1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_6).offset(100);
        make.centerY.equalTo(self.label1_6).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_6).offset(15+15);
        make.leading.equalTo(self.backView1).offset(0);
        make.trailing.equalTo(self.backView1).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.label1_7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.lineView1_6).offset(1+15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.button1_7_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_7).offset(100);
        make.centerY.equalTo(self.label1_7).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-100-15-15-10)/2);
        make.height.mas_equalTo(30);
    }];
    
    [self.button1_7_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-15);
        make.centerY.equalTo(self.button1_7_1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-100-15-15-10)/2);
        make.height.mas_equalTo(30);
    }];
}

-(void)initSubView2{
    self.subBackView2_1 = [[UIView alloc] init];
    [self.backView2 addSubview:self.subBackView2_1];
    
    [self.subBackView2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(0);
        make.trailing.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(0);
        make.bottom.equalTo(self.backView2).offset(0);
    }];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"修改密码";
    [self.subBackView2_1 addSubview:self.label2_1];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subBackView2_1).offset(15);
        make.centerY.equalTo(self.subBackView2_1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
}

-(void)initSubView3{
    self.subBackView3_1 = [[UIView alloc] init];
    [self.backView3 addSubview:self.subBackView3_1];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.text = @"服务条款";
    [self.subBackView3_1 addSubview:self.label3_1];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subBackView3_1).offset(15);
        make.centerY.equalTo(self.subBackView3_1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(15);
    }];
    
    self.lineView3_1 = [[UIView alloc] init];
    self.lineView3_1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.lineView3_1];
    
    self.subBackView3_2 = [[UIView alloc] init];
    [self.backView3 addSubview:self.subBackView3_2];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"联系客服";
    [self.subBackView3_2 addSubview:self.label3_2];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subBackView3_2).offset(15);
        make.centerY.equalTo(self.subBackView3_2).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(15);
    }];
    
    self.lineView3_2 = [[UIView alloc] init];
    self.lineView3_2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.lineView3_2];
    
    self.subBackView3_3 = [[UIView alloc] init];
    [self.backView3 addSubview:self.subBackView3_3];
    
    self.label3_3 = [[UILabel alloc] init];
    self.label3_3.text = @"关于我们";
    [self.subBackView3_3 addSubview:self.label3_3];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subBackView3_3).offset(15);
        make.centerY.equalTo(self.subBackView3_3).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(15);
    }];
    
    self.lineView3_3 = [[UIView alloc] init];
    self.lineView3_3.backgroundColor = kBACKGROUND_COLOR;
    [self.backView3 addSubview:self.lineView3_3];
    
    self.subBackView3_4 = [[UIView alloc] init];
    [self.backView3 addSubview:self.subBackView3_4];
    
    self.label3_4 = [[UILabel alloc] init];
    self.label3_4.text = @"退出登录";
    [self.subBackView3_4 addSubview:self.label3_4];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subBackView3_4).offset(15);
        make.centerY.equalTo(self.subBackView3_4).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(15);
    }];
/*====================================================================================*/
    [self.subBackView3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [self.lineView3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subBackView3_1).offset(44);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    [self.subBackView3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3_1).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [self.lineView3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subBackView3_2).offset(44);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    [self.subBackView3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3_2).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
    
    [self.lineView3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subBackView3_3).offset(44);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    [self.subBackView3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3_3).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(44);
    }];
}

-(void)initRecognizer{
    kAddNotification(@selector(keyboardWillShow), UIKeyboardWillChangeFrameNotification);
    kAddNotification(@selector(keyboardWillHide), UIKeyboardWillHideNotification);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
    
    self.subBackView2_1.userInteractionEnabled = YES;
    UITapGestureRecognizer *subBackView2_1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subBackView2_1Clicked)];
    [self.subBackView2_1 addGestureRecognizer:subBackView2_1Tap];
    
    self.subBackView3_1.userInteractionEnabled = YES;
    UITapGestureRecognizer *subBackView3_1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subBackView3_1Clicked)];
    [self.subBackView3_1 addGestureRecognizer:subBackView3_1Tap];
    
    self.subBackView3_2.userInteractionEnabled = YES;
    UITapGestureRecognizer *subBackView3_2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subBackView3_2Clicked)];
    [self.subBackView3_2 addGestureRecognizer:subBackView3_2Tap];
    
    self.subBackView3_3.userInteractionEnabled = YES;
    UITapGestureRecognizer *subBackView3_3Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subBackView3_3Clicked)];
    [self.subBackView3_3 addGestureRecognizer:subBackView3_3Tap];
    
    self.subBackView3_4.userInteractionEnabled = YES;
    UITapGestureRecognizer *subBackView3_4Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subBackView3_4Clicked)];
    [self.subBackView3_4 addGestureRecognizer:subBackView3_4Tap];
}

#pragma mark Target Action
- (void)keyboardWillShow{
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentOffset = CGPointMake(0, 50);
    }
}

- (void)keyboardWillHide{
    self.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.textField1_1 resignFirstResponder];
    [self.textField1_2 resignFirstResponder];
    [self.textField1_3 resignFirstResponder];
    [self.textField1_4 resignFirstResponder];
    [self.textField1_5 resignFirstResponder];
    [self.textField1_6 resignFirstResponder];
}

-(void)button1_7_1Clicked{
    self.patientSex = @"男";
    self.patientSexFix = 1;
    [self.button1_7_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button1_7_1 setTitleColor: kMAIN_COLOR forState:UIControlStateNormal];
    [self.button1_7_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
    [self.button1_7_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button1_7_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
}

-(void)button1_7_2Clicked{
    self.patientSex = @"女";
    self.patientSexFix = 2;
    [self.button1_7_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button1_7_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button1_7_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button1_7_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [self.button1_7_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
}

-(void)subBackView2_1Clicked{
    DLog(@"subBackView2_1Clicked");
    MineChangePasswordViewController *changePwdVC = [[MineChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:changePwdVC animated:YES];
}

-(void)subBackView3_1Clicked{
    DLog(@"subBackView3_1Clicked");
    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
    agreementVC.urlStr = @"http://101.68.79.26:83/jiuzhekan_http/service/jiuzhekanServiceDetail.html";
    agreementVC.titleStr = @"服务条款";
    [self.navigationController pushViewController:agreementVC animated:YES];
}

-(void)subBackView3_2Clicked{
    DLog(@"subBackView3_2Clicked");
//    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
//    agreementVC.urlStr = @"http://www.jiuzhekan.com/agreement.html";
//    agreementVC.titleStr = @"联系客服";
//    [self.navigationController pushViewController:agreementVC animated:YES];
    MineCustomServiceViewController *customServiceVC = [[MineCustomServiceViewController alloc] init];
    [self.navigationController pushViewController:customServiceVC animated:YES];
}

-(void)subBackView3_3Clicked{
    DLog(@"subBackView3_3Clicked");
//    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
//    agreementVC.urlStr = @"http://www.jiuzhekan.com/agreement.html";
//    agreementVC.titleStr = @"关于我们";
//    [self.navigationController pushViewController:agreementVC animated:YES];
    MineAboutUsViewController *mineAboutUsVC = [[MineAboutUsViewController alloc] init];
    [self.navigationController pushViewController:mineAboutUsVC animated:YES];
}

-(void)subBackView3_4Clicked{
    DLog(@"subBackView3_4Clicked");
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:kJZK_token];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window addSubview:rootVC.view];
    [self.window makeKeyAndVisible];
}

-(void)saveButtonClicked{
    DLog(@"saveButtonClicked");
    if ([self.textField1_1.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"昵称不能为空！"];
    }else if ([self.textField1_2.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"姓名不能为空！"];
    }
    else if (![VerifyUtil iDCardNumberCheck:self.textField1_3.text]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的身份证号码！"];
    }
//    else if (![VerifyUtil iDCardNumberCheck:self.textField1_4.text]) {
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的社保号码！"];
//    }
//    else if ([self.textField1_3.text isEqualToString:@""]) {
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"身份证号码不能为空！"];
//    }
//    else if ([self.textField1_4.text isEqualToString:@""]) {
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"社保号码不能为空！"];
//    }
    else if ([self.textField1_6.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"年龄不能为空！"];
    }else if ([self.patientSex isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"性别不能为空！"];
    }else{
        [self sendMineSettingRequest];
    }
}

#pragma mark Network Request
-(void)sendMineSettingRequest{
    DLog(@"sendMineSettingRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.textField1_1.text forKey:@"user_name"];
    [parameter setValue:self.textField1_2.text forKey:@"real_name"];
    [parameter setValue:self.publicIdNumber forKey:@"ID_number"];
    [parameter setValue:self.publicSsNumber forKey:@"ID_medical"];
    [parameter setValue:self.textField1_3.text forKey:@"newIDNumber"];
    [parameter setValue:self.textField1_4.text forKey:@"newIDMedical"];
    [parameter setValue:self.textField1_6.text forKey:@"user_age"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.patientSexFix] forKey:@"user_sex"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_SETTING_INFOMATION_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"保存成功" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code);
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

#pragma mark Data Parse

#pragma mark Data Filling
-(void)mineSettingDataFilling{
    self.textField1_1.text = self.publicUserName;
    self.textField1_2.text = self.publicRealName;
    self.textField1_3.text = self.publicIdNumber;
    self.textField1_4.text = self.publicSsNumber;
    self.textField1_6.text = self.publicUserAge;
    
    if (self.publicUserSex == 1) {
        [self button1_7_1Clicked];
    }else if (self.publicUserSex == 2){
        [self button1_7_2Clicked];
    }
}

@end
