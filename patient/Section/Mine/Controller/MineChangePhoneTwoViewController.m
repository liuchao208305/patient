//
//  MineChangePhoneTwoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineChangePhoneTwoViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"
#import "MineChangePhoneOneViewController.h"
#import "MineAccoutSecurityViewController.h"

@interface MineChangePhoneTwoViewController ()

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

@implementation MineChangePhoneTwoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineChangePhoneTwoViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineChangePhoneTwoViewController"];
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
    self.title = @"新手机号码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    if ([self.sourceVC isEqualToString:@"MineAccoutSecurityViewController"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
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
    self.phoneTextField = [[UITextField alloc] init];
    [self.scrollView addSubview:self.phoneTextField];
    
    self.phoneLineView = [[UIView alloc] init];
    self.phoneLineView.backgroundColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneLineView];
    
    self.commitButton = [[UIButton alloc] init];
    [self.commitButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.commitButton setBackgroundColor:kMAIN_COLOR];
    [self.commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.commitButton];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(40);
        make.leading.equalTo(self.scrollView).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(30);
    }];
    
    [self.phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(8);
        make.leading.equalTo(self.scrollView).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(1);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLineView.mas_bottom).offset(40);
        make.leading.equalTo(self.scrollView).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(45);
    }];
    
    [self newPhoneDataFilling];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.phoneTextField resignFirstResponder];
}

-(void)backButtonClicked{
    DLog(@"backButtonClicked");
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitButtonClicked{
    if ([self.phoneTextField.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"手机号码不能为空！"];
    }else{
        [self sendChangePhoneRequest];
    }
}

#pragma mark Network Request
-(void)sendChangePhoneRequest{
    DLog(@"sendChangePhoneRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.phoneTextField.text forKey:@"phone"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CHANGE_PHONE_INFORMATION_ONE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self sendGetCaptchaRequest];
        }else{
            DLog(@"%ld",(long)self.code1);
            DLog(@"%@",self.message1);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message1];
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

-(void)sendGetCaptchaRequest{
    DLog(@"sendGetCaptchaRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.phoneTextField.text forKey:@"phone"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_LOGIN_GET_CATPCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"验证码发送成功！" withDelaySeconds:kHud_DelayTime];
            
            MineChangePhoneOneViewController *changePhoneOneVC = [[MineChangePhoneOneViewController alloc] init];
            changePhoneOneVC.soureVC = @"MineChangePhoneTwoViewController";
            changePhoneOneVC.NewPhoneString = self.phoneTextField.text;
            [self.navigationController pushViewController:changePhoneOneVC animated:YES];
        }else{
            DLog(@"%ld",(long)self.code2);
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

#pragma mark Data Filling
-(void)newPhoneDataFilling{
    self.phoneTextField.placeholder = @"请输入新的手机号码";
    [self.commitButton setTitle:@"下一步" forState:UIControlStateNormal];
}

@end
