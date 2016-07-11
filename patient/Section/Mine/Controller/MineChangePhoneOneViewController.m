//
//  MineChangePhoneOneViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineChangePhoneOneViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"
#import "MineChangePhoneTwoViewController.h"

@interface MineChangePhoneOneViewController ()

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

@end

@implementation MineChangePhoneOneViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineChangePhoneOneViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineChangePhoneOneViewController"];
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
    self.title = @"验证码登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
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
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.font = [UIFont systemFontOfSize:12];
    self.phoneLabel.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.phoneLabel];
    
    self.promptLabel = [[UILabel alloc] init];
    self.promptLabel.font = [UIFont systemFontOfSize:14];
    self.promptLabel.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.promptLabel];
    
    self.codeTextField = [[UITextField alloc] init];
    [self.scrollView addSubview:self.codeTextField];
    
    self.codeLineView = [[UIView alloc] init];
    self.codeLineView.backgroundColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.codeLineView];
    
    self.resendLabel = [[UILabel alloc] init];
    self.resendLabel.font = [UIFont systemFontOfSize:14];
    self.resendLabel.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.resendLabel];
    
    self.resendButton = [[UIButton alloc] init];
    [self.resendButton setFont:[UIFont systemFontOfSize:14]];
    [self.resendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.resendButton addTarget:self action:@selector(resendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.resendButton];
    
    self.completeButton = [[UIButton alloc] init];
    [self.completeButton setFont:[UIFont systemFontOfSize:16]];
    [self.completeButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.completeButton setBackgroundColor:kMAIN_COLOR];
    [self.completeButton addTarget:self action:@selector(completeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.completeButton];
    
    self.explainLabel1 = [[UILabel alloc] init];
    self.explainLabel1.font = [UIFont systemFontOfSize:11];
    self.explainLabel1.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.explainLabel1];
    
    self.explainLabel2 = [[UILabel alloc] init];
    self.explainLabel2.font = [UIFont systemFontOfSize:11];
    self.explainLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.explainLabel2];
    
    self.explainLabel3_1 = [[UILabel alloc] init];
    self.explainLabel3_1.font = [UIFont systemFontOfSize:11];
    self.explainLabel3_1.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.explainLabel3_1];
    
    self.explainLabel3_2 = [[UILabel alloc] init];
    self.explainLabel3_2.font = [UIFont systemFontOfSize:11];
    self.explainLabel3_2.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.explainLabel3_2];
    
    self.explainLabel3_3 = [[UILabel alloc] init];
    self.explainLabel3_3.font = [UIFont systemFontOfSize:11];
    self.explainLabel3_3.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.explainLabel3_3];
    
    self.explainLabel3_4 = [[UILabel alloc] init];
    self.explainLabel3_4.font = [UIFont systemFontOfSize:11];
    self.explainLabel3_4.textColor = [UIColor redColor];
    [self.scrollView addSubview:self.explainLabel3_4];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.scrollView).offset(30);
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(10);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.promptLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.codeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(43);
//        make.trailing.equalTo(self.scrollView).offset(-43);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-86);
        make.height.mas_equalTo(1);
    }];
    
    [self.resendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(-50);
        make.top.equalTo(self.codeLineView.mas_bottom).offset(10);
    }];
    
    [self.resendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.resendLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.resendLabel).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(20);
//        make.trailing.equalTo(self.scrollView).offset(-20);
        make.top.equalTo(self.resendLabel.mas_bottom).offset(45);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(45);
    }];
    
    [self.explainLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.completeButton).offset(0);
        make.top.equalTo(self.completeButton.mas_bottom).offset(15);
    }];
    
    [self.explainLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.explainLabel1).offset(0);
        make.top.equalTo(self.explainLabel1.mas_bottom).offset(15);
    }];
    
    [self.explainLabel3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.explainLabel2).offset(0);
        make.top.equalTo(self.explainLabel2.mas_bottom).offset(15);
    }];
    
    [self.explainLabel3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.explainLabel3_1.mas_trailing).offset(2);
        make.centerY.equalTo(self.explainLabel3_1).offset(0);
    }];
    
    [self.explainLabel3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.explainLabel3_2.mas_trailing).offset(2);
        make.centerY.equalTo(self.explainLabel3_2).offset(0);
    }];
    
    [self.explainLabel3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.explainLabel3_3.mas_trailing).offset(2);
        make.centerY.equalTo(self.explainLabel3_3).offset(0);
    }];
    
    [self changePhoneDataFilling];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.codeTextField resignFirstResponder];
}

-(void)resendButtonClicked{
    [self sendGetCaptchaRequest];
}

-(void)completeButtonClicked{
    if ([self.codeTextField.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"验证码不能为空！"];
    }else{
        [self sendCommitCaptchaRequest];
    }
}

#pragma mark Network Request
-(void)sendGetCaptchaRequest{
    DLog(@"sendGetCaptchaRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    if ([self.soureVC isEqualToString:@"MineAccoutSecurityViewController"]) {
        [parameter setValue:self.OldPhoneString forKey:@"phone"];
    }else if ([self.soureVC isEqualToString:@"MineChangePhoneTwoViewController"]){
        [parameter setValue:self.NewPhoneString forKey:@"phone"];
    }
    
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_LOGIN_GET_CATPCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"验证码发送成功！" withDelaySeconds:kHud_DelayTime];
        }else{
            DLog(@"%ld",(long)self.code1);
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

-(void)sendCommitCaptchaRequest{
    DLog(@"sendCommitCaptchaRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    if ([self.soureVC isEqualToString:@"MineAccoutSecurityViewController"]) {
        [parameter setValue:self.OldPhoneString forKey:@"phone"];
    }else if ([self.soureVC isEqualToString:@"MineChangePhoneTwoViewController"]){
        [parameter setValue:self.NewPhoneString forKey:@"phone"];
    }
    
    [parameter setValue:self.codeTextField.text forKey:@"code"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CHANGE_PHONE_INFORMATION_TWO] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if ([self.soureVC isEqualToString:@"MineAccoutSecurityViewController"]) {
                MineChangePhoneTwoViewController *changePhoneTwoVC = [[MineChangePhoneTwoViewController alloc] init];
                changePhoneTwoVC.sourceVC = @"MineChangePhoneOneViewController";
                [self.navigationController pushViewController:changePhoneTwoVC animated:YES];
            }else if ([self.soureVC isEqualToString:@"MineChangePhoneTwoViewController"]){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
           
        }else{
            DLog(@"%ld",(long)self.code2);
            DLog(@"%@",self.message2);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message2];
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

#pragma mark Data Filling
-(void)changePhoneDataFilling{
    if ([self.soureVC isEqualToString:@"MineAccoutSecurityViewController"]) {
        self.phoneLabel.text = [NSString stringWithFormat:@"+86%@",self.OldPhoneString];
    }else if ([self.soureVC isEqualToString:@"MineChangePhoneTwoViewController"]){
        self.phoneLabel.text = [NSString stringWithFormat:@"+86%@",self.NewPhoneString];
    }
    
    self.promptLabel.text = @"已发送验证码到上面的手机";
    self.resendLabel.text = @"未收到验证码？";
    [self.resendButton setTitle:@"重发短信" forState:UIControlStateNormal];
    if ([self.soureVC isEqualToString:@"MineAccoutSecurityViewController"]) {
        [self.completeButton setTitle:@"下一步" forState:UIControlStateNormal];
    }else if ([self.soureVC isEqualToString:@"MineChangePhoneTwoViewController"]){
        [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    self.explainLabel1.text = @"说明：";
    self.explainLabel2.text = @"1、为了您的帐户安全，本次登录需要验证短信验证码。";
    self.explainLabel3_1.text = @"2、任何向您所要";
    self.explainLabel3_2.text = @"“短信验证码”";
    self.explainLabel3_3.text = @"的都是骗子，";
    self.explainLabel3_4.text = @"千万别给！";
}

@end
