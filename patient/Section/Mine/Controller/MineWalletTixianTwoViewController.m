//
//  MineWalletTixianTwoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletTixianTwoViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "AdaptionUtil.h"
#import "LoginViewController.h"

@interface MineWalletTixianTwoViewController ()<UITextViewDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)int timeCount;
@property (strong,nonatomic)NSThread *thread;

@end

@implementation MineWalletTixianTwoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineWalletTixianTwoViewController"];
    
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(beginCountUp) object:nil];
    [self.thread start];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineWalletTixianTwoViewController"];
    
    if (self.thread != nil) {
        [self.thread cancel];
    }
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
    self.title = @"提现确认";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = kBACKGROUND_COLOR;
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
    self.promptLabel1 = [[UILabel alloc] init];
    self.promptLabel1.font = [UIFont systemFontOfSize:14];
    self.promptLabel1.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.promptLabel1];
    
    self.phoneLabel1 = [[UILabel alloc] init];
//    self.phoneLabel1.font = [UIFont systemFontOfSize:13];
//    self.phoneLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneLabel1];
    
    self.phoneLabel2 = [[UILabel alloc] init];
//    self.phoneLabel2.font = [UIFont systemFontOfSize:13];
//    self.phoneLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneLabel2];
    
    self.phoneLabel3 = [[UILabel alloc] init];
//    self.phoneLabel3.font = [UIFont systemFontOfSize:13];
//    self.phoneLabel3.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.phoneLabel3];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.scrollView addSubview:self.timeLabel];
    
    self.promptLabel2 = [[UILabel alloc] init];
    self.promptLabel2.font = [UIFont systemFontOfSize:14];
    self.promptLabel2.textColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.promptLabel2];
    
//    self.codeTextField1 = [[UITextField alloc] init];
//    self.codeTextField1.backgroundColor = kWHITE_COLOR;
//    self.codeTextField1.keyboardType = UIKeyboardTypeNumberPad;
//    [self.scrollView addSubview:self.codeTextField1];
//    
//    self.codeTextField2 = [[UITextField alloc] init];
//    self.codeTextField2.backgroundColor = kWHITE_COLOR;
//    self.codeTextField2.keyboardType = UIKeyboardTypeNumberPad;
//    [self.scrollView addSubview:self.codeTextField2];
//    
//    self.codeTextField3 = [[UITextField alloc] init];
//    self.codeTextField3.backgroundColor = kWHITE_COLOR;
//    self.codeTextField3.keyboardType = UIKeyboardTypeNumberPad;
//    [self.scrollView addSubview:self.codeTextField3];
//    
//    self.codeTextField4 = [[UITextField alloc] init];
//    self.codeTextField4.backgroundColor = kWHITE_COLOR;
//    self.codeTextField4.keyboardType = UIKeyboardTypeNumberPad;
//    [self.scrollView addSubview:self.codeTextField4];
    
    self.codeTextField = [[UITextField alloc] init];
    [self.scrollView addSubview:self.codeTextField];
    
    self.codeLineView = [[UIView alloc] init];
    self.codeLineView.backgroundColor = ColorWithHexRGB(0x646464);
    [self.scrollView addSubview:self.codeLineView];
    
    self.completeButton = [[UIButton alloc] init];
    [self.completeButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [self.completeButton setBackgroundColor:kMAIN_COLOR];
    [self.completeButton addTarget:self action:@selector(completeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.completeButton];
    
    [self.promptLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.scrollView).offset(35);
    }];
    
    [self.phoneLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.phoneLabel2.mas_leading).offset(-2);
        make.centerY.equalTo(self.phoneLabel2).offset(0);
    }];
    
    [self.phoneLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.promptLabel1.mas_bottom).offset(35);
    }];
    
    [self.phoneLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.phoneLabel2.mas_trailing).offset(2);
        make.centerY.equalTo(self.phoneLabel2).offset(0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.phoneLabel2.mas_bottom).offset(15);
    }];
    
    [self.promptLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15);
    }];
    
//    [self.codeTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.scrollView).offset((SCREEN_WIDTH-230)/2);
//        make.top.equalTo(self.promptLabel2.mas_bottom).offset(23);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [self.codeTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.codeTextField1.mas_trailing).offset(10);
//        make.centerY.equalTo(self.codeTextField1).offset(0);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [self.codeTextField3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.codeTextField2.mas_trailing).offset(10);
//        make.centerY.equalTo(self.codeTextField2).offset(0);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [self.codeTextField4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.codeTextField3.mas_trailing).offset(10);
//        make.centerY.equalTo(self.codeTextField3).offset(0);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView).offset(0);
        make.top.equalTo(self.promptLabel2.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.codeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(20);
        //        make.trailing.equalTo(self.scrollView).offset(-43);
        make.top.equalTo(self.codeTextField.mas_bottom).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(1);
    }];
    
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.scrollView).offset(20);
        //        make.trailing.equalTo(self.scrollView).offset(-20);
        make.top.equalTo(self.codeLineView.mas_bottom).offset(45);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(45);
    }];
    
    [self mineTixianDataFilling];
}

-(void)initRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [self.scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [self.codeTextField resignFirstResponder];
}

-(void)beginCountUp{
    self.timeCount = 1;
    while (self.timeCount > 0 && !self.thread.isCancelled && self.timeCount < 60) {
        [self performSelectorOnMainThread:@selector(updateTimeLabel) withObject:nil waitUntilDone:NO];
        [NSThread sleepForTimeInterval:1];
        self.timeCount++;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [AlertUtil showSimpleAlertWithTitle:nil message:@"验证码已过期，请重新发起提现！"];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)updateTimeLabel{
    NSString *timeCountString = [NSString stringWithFormat:@"已发送(%d秒)", self.timeCount];
    self.timeLabel.text = timeCountString;
}

-(void)completeButtonClicked{
    if ([self.codeTextField.text isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"验证码不能为空！"];
    }else{
        [self sendMineTixianRequest3];
    }
}

#pragma mark UITextViewDelegate

#pragma mark Network Request
-(void)sendMineTixianRequest3{
    DLog(@"sendMineTixianRequest3");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.tixianPhone forKey:@"phone"];
    [parameter setValue:self.codeTextField.text forKey:@"code"];
    [parameter setValue:@"1" forKey:@"type"];
    
    DLog(@"%@%@",kServerAddress,kJZK_MINE_WALLET_TIXIAN_THREE);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_WALLET_TIXIAN_THREE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"提现成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            DLog(@"%ld",(long)self.code);
            DLog(@"%@",self.message);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message];
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

#pragma mark Data Filling
-(void)mineTixianDataFilling{
    self.promptLabel1.text = @"验证码已经发送至您的手机";
    self.phoneLabel1.text = [self.tixianPhone substringWithRange:NSMakeRange(0, 3)];
    self.phoneLabel2.text = @"****";
    self.phoneLabel3.text = [self.tixianPhone substringWithRange:NSMakeRange(7, 4)];
    self.promptLabel2.text = @"请在下方输入您收到的验证码";
    [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
}

@end
