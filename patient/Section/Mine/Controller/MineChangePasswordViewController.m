//
//  MineChangePasswordViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/25.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineChangePasswordViewController.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "AdaptionUtil.h"
#import "EncyptionUtil.h"
#import "AnalyticUtil.h"

@interface MineChangePasswordViewController (){
    int timeCount;
    NSThread *thread;
}

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

@end

@implementation MineChangePasswordViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineChangePasswordViewController"];
    
    if (thread != nil) {
        [thread cancel];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineChangePasswordViewController"];
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"修改密码";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 90)];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initSubView1];
    [self.scrollView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 20+90+15, SCREEN_WIDTH, 90)];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initSubView2];
    [self.scrollView addSubview:self.backView2];
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20+90+15+90+30, SCREEN_WIDTH-30, 44)];
    [self.confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_normal"] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundImage:[UIImage imageNamed:@"info_treatment_paynow_selected"] forState:UIControlStateHighlighted];
    [self.confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.confirmButton];
}

-(void)initSubView1{
    self.textField1_1 = [[UITextField alloc] init];
    self.textField1_1.placeholder = @"请输入手机号";
    [self.backView1 addSubview:self.textField1_1];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.backView1 addSubview:self.lineView1];
    
    self.textField1_2 = [[UITextField alloc] init];
    self.textField1_2.placeholder = @"请输入验证码";
    [self.backView1 addSubview:self.textField1_2];
    
    self.captchaButton = [[UIButton alloc] init];
    self.captchaButton.layer.cornerRadius = 5;
    [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.captchaButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.captchaButton setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_normal"] forState:UIControlStateNormal];
    [self.captchaButton addTarget:self action:@selector(captchaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView1 addSubview:self.captchaButton];
    
    [self.textField1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(15);
        make.top.equalTo(self.backView1).offset(7);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textField1_1).offset(0);
        make.top.equalTo(self.textField1_1).offset(30+7);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(1);
    }];
    
    [self.textField1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView1).offset(0);
        make.top.equalTo(self.lineView1).offset(1+7);
        make.width.mas_equalTo(SCREEN_WIDTH-15-80-15);
        make.height.mas_equalTo(30);
    }];
    
    [self.captchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-15);
        make.centerY.equalTo(self.textField1_2).offset(0);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(30);
    }];
}

-(void)initSubView2{
    self.textField2_1 = [[UITextField alloc] init];
    self.textField2_1.placeholder = @"请输入新密码";
    [self.backView2 addSubview:self.textField2_1];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.backView2 addSubview:self.lineView2];
    
    self.textField2_2 = [[UITextField alloc] init];
    self.textField2_2.placeholder = @"请再次输入新密码";
    [self.backView2 addSubview:self.textField2_2];
    
    [self.textField2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(15);
        make.top.equalTo(self.backView2).offset(7);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.textField2_1).offset(0);
        make.top.equalTo(self.textField2_1).offset(30+7);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(1);
    }];
    
    [self.textField2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lineView2).offset(0);
        make.top.equalTo(self.lineView2).offset(1+7);
        make.width.mas_equalTo(SCREEN_WIDTH-15);
        make.height.mas_equalTo(30);
    }];
}

-(void)initRecognizer{
    kAddNotification(@selector(keyboardWillShow), UIKeyboardWillChangeFrameNotification);
    kAddNotification(@selector(keyboardWillHide), UIKeyboardWillHideNotification);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
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
    [self.textField2_1 resignFirstResponder];
    [self.textField2_2 resignFirstResponder];
}

-(void)captchaButtonClicked{
    if ([self.textField1_1.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"手机号不能为空！"];
    }else{
        [self getCaptchaRequest];
        
        [self.captchaButton setEnabled:NO];
        
        thread= [[NSThread alloc]initWithTarget:self selector:@selector(beginCountDown) object:nil];
        [thread start];
    }
}

-(void)beginCountDown{
    timeCount = 59;
    while (timeCount > 0 && !thread.isCancelled) {
        [self performSelectorOnMainThread:@selector(updateCaptchaButton) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:1];
        timeCount--;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.captchaButton setEnabled:YES];
        
        [self.captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.captchaButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.captchaButton setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_normal"] forState:UIControlStateNormal];
    });
}

- (void)updateCaptchaButton{
    NSString *timeCountString = [NSString stringWithFormat:@"已发送(%d)", timeCount];
    self.captchaButton.titleLabel.text = timeCountString;
    [self.captchaButton setTitle:timeCountString forState:UIControlStateNormal];
}

-(void)confirmButtonClicked{
    if ([self.textField2_1.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"新密码不能为空！"];
    }else if (![self.textField2_1.text isEqualToString:self.textField2_2.text]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"新密码请保持一致！"];
    }else{
        [self sendChangePasswordRequest];
    }
}

#pragma mark Network Request
-(void)getCaptchaRequest{
    DLog(@"getCaptchaRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.textField1_1.text forKey:@"phone"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_PASSWORD_RESET_CAPTCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"验证码已发送！" withDelaySeconds:kHud_DelayTime];
        }else{
            DLog(@"%ld",(long)self.code);
            DLog(@"%@",self.message);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendChangePasswordRequest{
    DLog(@"getCaptchaRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.textField1_1.text forKey:@"phone"];
    [parameter setValue:self.textField1_2.text forKey:@"code"];
    [parameter setValue:[EncyptionUtil encrypt_md5:self.textField2_2.text] forKey:@"newPwd"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_PASSWORD_RESET_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"密码修改成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code2);
            DLog(@"%@",self.message2);
            [HudUtil showSimpleTextOnlyHUD:self.message2 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse

@end
