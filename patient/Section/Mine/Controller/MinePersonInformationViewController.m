//
//  MinePersonInformationViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MinePersonInformationViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "LoginViewController.h"

@interface MinePersonInformationViewController ()<UITextViewDelegate>

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

@property (strong,nonatomic)NSString *user_id;
@property (strong,nonatomic)NSString *user_name;
@property (strong,nonatomic)NSString *real_name;
@property (strong,nonatomic)NSString *ID_number;
@property (strong,nonatomic)NSString *ID_medical;
@property (strong,nonatomic)NSString *user_age;
@property (assign,nonatomic)NSInteger user_sex;
@property (strong,nonatomic)NSString *user_sex_fix;
@property (strong,nonatomic)NSString *heand_url;


@end

@implementation MinePersonInformationViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MinePersonInformationViewController"];
    
    [self sendPersonInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MinePersonInformationViewController"];
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
    self.title = @"个人信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kWHITE_COLOR;
    if ([AdaptionUtil isIphoneFour]) {
        self.scrollView.contentSize = CGSizeMake(0, 1.5*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneFive]){
        self.scrollView.contentSize = CGSizeMake(0, 1.3*SCREEN_HEIGHT);
    }else if ([AdaptionUtil isIphoneSix] || [AdaptionUtil isIphoneSixPlus]){
        self.scrollView.contentSize = CGSizeMake(0, 1.2*SCREEN_HEIGHT);
    }
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    [self initScrollSubView];
    [self.view addSubview:self.scrollView];
}

-(void)initScrollSubView{
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320-45)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self.scrollView addSubview:self.backView1];
    
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
    self.textField1_4.delegate = self;
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
    
    //    self.textField1_6 = [[UITextField alloc] init];
    //    self.textField1_6.placeholder = @"请输入您的年龄";
    //    [self.backView1 addSubview:self.textField1_6];
    self.label1_6Fix = [[UILabel alloc] init];
    [self.backView1 addSubview:self.label1_6Fix];
    
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
    
    //    [self.textField1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.equalTo(self.label1_6).offset(100);
    //        make.centerY.equalTo(self.label1_6).offset(0);
    //        make.width.mas_equalTo(SCREEN_WIDTH-100-15);
    //        make.height.mas_equalTo(30);
    //    }];
    [self.label1_6Fix mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)initRecognizer{
    kAddNotification(@selector(keyboardWillShow), UIKeyboardWillChangeFrameNotification);
    kAddNotification(@selector(keyboardWillHide), UIKeyboardWillHideNotification);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark UITextViewDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    DLog(@"textFieldDidBeginEditing");
    
    int birthYear = 0;
    int birthMonth = 0;
    int birthDay = 0;
    if ([VerifyUtil iDCardNumberCheck:self.textField1_3.text]){
        if ([self.textField1_3.text length] == 15) {
            birthYear = [[self.textField1_3.text substringWithRange:NSMakeRange(6, 2)] intValue] +1900;
            birthMonth = [[self.textField1_3.text substringWithRange:NSMakeRange(8, 2)] intValue];
            birthDay = [[self.textField1_3.text substringWithRange:NSMakeRange(10, 2)] intValue];
        }else if ([self.textField1_3.text length] == 18){
            birthYear = [[self.textField1_3.text substringWithRange:NSMakeRange(6, 4)] intValue];
            birthMonth = [[self.textField1_3.text substringWithRange:NSMakeRange(10, 2)] intValue];
            birthDay = [[self.textField1_3.text substringWithRange:NSMakeRange(12, 2)] intValue];
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
        
        self.label1_6Fix.text = [NSString stringWithFormat:@"%d",age];
    }else{
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的身份证号码！"];
    }
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
    //    [self.textField1_6 resignFirstResponder];
}

-(void)button1_7_1Clicked{
    self.user_sex_fix = @"男";
    self.user_sex = 1;
    [self.button1_7_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button1_7_1 setTitleColor: kMAIN_COLOR forState:UIControlStateNormal];
    [self.button1_7_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
    [self.button1_7_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button1_7_2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
}

-(void)button1_7_2Clicked{
    self.user_sex_fix = @"女";
    self.user_sex = 2;
    [self.button1_7_1 setTitle:@"男" forState:UIControlStateNormal];
    [self.button1_7_1 setTitleColor: [UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1_7_1 setBackgroundImage:[UIImage imageNamed:@"info_treatment_unselected_button"] forState:UIControlStateNormal];
    [self.button1_7_2 setTitle:@"女" forState:UIControlStateNormal];
    [self.button1_7_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
    [self.button1_7_2 setBackgroundImage:[UIImage imageNamed:@"info_treatment_selected_button"] forState:UIControlStateNormal];
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
    //    else if ([self.label1_6Fix.text isEqualToString:@""]) {
    //        [AlertUtil showSimpleAlertWithTitle:nil message:@"年龄不能为空！"];
    //    }
    else if ([self.user_sex_fix isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"性别不能为空！"];
    }else{
        [self commitPersonInfoRequest];
    }
}

#pragma mark UITextViewDelegate

#pragma mark Network Request
-(void)sendPersonInfoRequest{
    DLog(@"sendPersonInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_INFORMATION_FIX] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self personInfoDataParse];
        }else{
            DLog(@"%@",self.message1);
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

-(void)commitPersonInfoRequest{
    DLog(@"commitPersonInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.textField1_1.text forKey:@"user_name"];
    [parameter setValue:self.textField1_2.text forKey:@"real_name"];
    [parameter setValue:self.ID_number forKey:@"ID_number"];
    [parameter setValue:self.ID_medical forKey:@"ID_medical"];
    if (![self.textField1_3.text isEqualToString:self.ID_number]) {
        [parameter setValue:self.textField1_3.text forKey:@"newIDNumber"];
    }
    
    if (![self.textField1_4.text isEqualToString:self.ID_medical]) {
        [parameter setValue:self.textField1_4.text forKey:@"newIDMedical"];
    }
    
    [parameter setValue:self.label1_6Fix.text forKey:@"user_age"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.user_sex] forKey:@"user_sex"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_SETTING_INFOMATION_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"保存成功" withDelaySeconds:kHud_DelayTime];
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%ld",(long)self.user_sex] forKey:kJZK_userSex];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code2);
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

#pragma mark Data Parse
-(void)personInfoDataParse{
    self.user_id = [NullUtil judgeStringNull:[self.data1 objectForKey:@"user_id"]];
    self.user_name = [NullUtil judgeStringNull:[self.data1 objectForKey:@"user_name"]];
    self.ID_number = [NullUtil judgeStringNull:[self.data1 objectForKey:@"ID_number"]];
    self.ID_medical = [NullUtil judgeStringNull:[self.data1 objectForKey:@"ID_medical"]];
    self.user_age = [NullUtil judgeStringNull:[self.data1 objectForKey:@"user_age"]];
    self.user_sex = [[self.data1 objectForKey:@"user_sex"] integerValue];
    self.heand_url = [NullUtil judgeStringNull:[self.data1 objectForKey:@"heand_url"]];
    self.real_name = [NullUtil judgeStringNull:[self.data1 objectForKey:@"real_name"]];
    
    [self personInfoDataFilling];
}

#pragma mark Data Filling
-(void)personInfoDataFilling{
    self.textField1_1.text = self.user_name;
    self.textField1_2.text = self.real_name;
    self.textField1_3.text = self.ID_number;
    self.textField1_4.text = self.ID_medical;
    self.label1_6Fix.text = self.user_age;
    
    if (self.user_sex == 1) {
        [self button1_7_1Clicked];
    }else if (self.user_sex == 2){
        [self button1_7_2Clicked];
    }
}

@end
