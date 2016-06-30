//
//  LoginViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//
#import "LoginViewController.h"
#import "YJSegmentedControl.h"
#import "AdaptionUtil.h"
#import "AgreementViewController.h"
#import "NetworkUtil.h"
#import "LoginRequestDelegate.h"
#import "EncyptionUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "AlertUtil.h"
#import "VerifyUtil.h"
#import "BaseTabBarController.h"
#import "JPUSHService.h"

@interface LoginViewController ()<UIScrollViewDelegate,YJSegmentedControlDelegate,UIAlertViewDelegate,LoginDelegate>{
    UIScrollView *scrollView;
    
    UIView *whiteBackView;
    UIView *segmentBottomLineView;
    //快速登录
    UIView *firstBackView1;
    UITextField *firstTextField1;
    UIButton *firstButton1;
    UIView *firstTFBottomLineView1;
    UITextField *secondTextField1;
    UIView *secondBackView1;
    //已有帐号登录
    UIView *firstBackView2;
    UITextField *firstTextField2;
    UIView *firstTFBottomLineView2;
    UITextField *secondTextField2;
    UIView *secondBackView2;
    //第三方登录
    UIView *backView;
    UIImageView *imageView1;
    UILabel *label1;
    UIImageView *imageView2;
    UILabel *label2;
    UIImageView *imageView3;
    UILabel *label3;
    
    UIView *grayBackView;
    UILabel *agreementLabel;
    UIButton *agreementButton;
    UIButton *loginButton;
    
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

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

@end

@implementation LoginViewController

#pragma mark Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"LoginViewController"];
    
    if (thread != nil) {
        [thread cancel];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"LoginViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init Section
-(void)initNavBar{
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"登录";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    
    whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 156)];
    whiteBackView.backgroundColor = kWHITE_COLOR;
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"手机快速登录", @"已有帐号登录", @"第三方登录",nil];
    YJSegmentedControl * segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:0];
    [whiteBackView addSubview:segmentControl];
    
    segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:segmentBottomLineView];
    [self initQuickLoginView];
    
    [scrollView addSubview:whiteBackView];
    
    grayBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT-156)];
    grayBackView.backgroundColor = kBACKGROUND_COLOR;
    [scrollView addSubview:grayBackView];
    
    agreementLabel = [[UILabel alloc]init];
    agreementLabel.text = @"点击确定即同意";
    agreementLabel.textColor = kDARK_GRAY_COLOR;
    [grayBackView addSubview:agreementLabel];
    
    agreementButton = [[UIButton alloc] init];
    [agreementButton setTitle:@"就这看服务条款" forState:UIControlStateNormal];
    [agreementButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [agreementButton addTarget:self action:@selector(agreementButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [grayBackView addSubview:agreementButton];
    
    loginButton = [[UIButton alloc] init];
    [loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_normal"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_selected"] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [grayBackView addSubview:loginButton];
    
    if ([AdaptionUtil isIphoneFour]) {
        [agreementLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(grayBackView).offset(20);
            make.top.equalTo(grayBackView).offset(10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
        
        [agreementButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(agreementLabel).offset(100);
            make.right.equalTo(grayBackView).offset(-5);
            make.centerY.equalTo(agreementLabel).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(grayBackView).offset(0);
            make.top.equalTo(agreementButton).offset(25);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(49);
        }];
    }else if ([AdaptionUtil isIphoneFive]){
        [agreementLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(grayBackView).offset(30);
            make.top.equalTo(grayBackView).offset(20);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
        
        [agreementButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(agreementLabel).offset(120);
            make.right.equalTo(grayBackView).offset(-30);
            make.centerY.equalTo(agreementLabel).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(grayBackView).offset(0);
            make.top.equalTo(agreementButton).offset(25);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(40);
        }];
    }else if ([AdaptionUtil isIphoneSix]){
        [agreementLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(grayBackView).offset(50);
            make.top.equalTo(grayBackView).offset(56);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
        
        [agreementButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(agreementLabel).offset(100);
            make.right.equalTo(grayBackView).offset(-50);
            make.centerY.equalTo(agreementLabel).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(grayBackView).offset(0);
            make.top.equalTo(agreementButton).offset(36);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(49);
        }];
    }else if ([AdaptionUtil isIphoneSixPlus]){
        [agreementLabel mas_updateConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(grayBackView).offset(80);
            make.top.equalTo(grayBackView).offset(56);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
        
        [agreementButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(agreementLabel).offset(90);
            make.right.equalTo(grayBackView).offset(-56);
            make.centerY.equalTo(agreementLabel).offset(0);
            make.height.mas_equalTo(15);
        }];
        
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(grayBackView).offset(0);
            make.top.equalTo(agreementButton).offset(36);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(49);
        }];
    }
}

//快速登录
-(void)initQuickLoginView{
    [agreementLabel setHidden:NO];
    [agreementButton setHidden:NO];
    [loginButton setHidden:NO];
    
    firstBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 55)];
    firstBackView1.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:firstBackView1];
    
    firstTextField1 = [[UITextField alloc] init];
    firstTextField1.placeholder = @"请输入手机号码";
    [firstBackView1 addSubview:firstTextField1];
    
    firstButton1 = [[UIButton alloc] init];
    [firstButton1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [firstButton1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
    [firstButton1 setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_normal"] forState:UIControlStateNormal];
    [firstButton1 addTarget:self action:@selector(getCaptchaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [firstBackView1 addSubview:firstButton1];
    
    [firstTextField1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(firstBackView1).offset(16);
        make.centerY.equalTo(firstBackView1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(55);
    }];
    [firstButton1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(firstBackView1).offset(-10);
        make.centerY.equalTo(firstTextField1).offset(0);
        make.width.mas_equalTo(95);
        make.height.mas_equalTo(44);
    }];
    
    firstTFBottomLineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55, SCREEN_WIDTH, 1)];
    firstTFBottomLineView1.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:firstTFBottomLineView1];
    
    secondBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55+1, SCREEN_WIDTH, 55)];
    secondBackView1.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:secondBackView1];
    
    secondTextField1 = [[UITextField alloc] init];
    secondTextField1.placeholder = @"请输入验证码";
    [secondBackView1 addSubview:secondTextField1];
    
    [secondTextField1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(secondBackView1).offset(16);
        make.centerY.equalTo(secondBackView1).offset(0);
        make.right.equalTo(secondBackView1).offset(0);
        make.height.mas_equalTo(55);
    }];
}

//已有帐号登录
-(void)initNormalLoginView{
    [agreementLabel setHidden:NO];
    [agreementButton setHidden:NO];
    [loginButton setHidden:NO];
    
    firstBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 55)];
    firstBackView2.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:firstBackView2];
    
    firstTextField2 = [[UITextField alloc] init];
    firstTextField2.placeholder = @"请输入手机号码\\帐号\\身份证号\\社保帐号";
    [firstBackView2 addSubview:firstTextField2];
    
    [firstTextField2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(firstBackView2).offset(16);
        make.centerY.equalTo(firstBackView2).offset(0);
        make.right.equalTo(firstBackView2).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    firstTFBottomLineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55, SCREEN_WIDTH, 1)];
    firstTFBottomLineView2.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:firstTFBottomLineView2];
    
    secondBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44+55+1, SCREEN_WIDTH, 55)];
    secondBackView2.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:secondBackView2];
    
    secondTextField2 = [[UITextField alloc] init];
    secondTextField2.placeholder = @"请输入密码";
    secondTextField2.secureTextEntry = YES;
    [secondBackView2 addSubview:secondTextField2];
    
    [secondTextField2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(secondBackView2).offset(16);
        make.centerY.equalTo(secondBackView2).offset(0);
        make.right.equalTo(secondBackView2).offset(0);
        make.height.mas_equalTo(55);
    }];
}

//第三方登录
-(void)initPlatformLoginView{
    [agreementLabel setHidden:YES];
    [agreementButton setHidden:YES];
    [loginButton setHidden:YES];
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 145)];
    backView.backgroundColor = kWHITE_COLOR;
    [whiteBackView addSubview:backView];
    
    imageView1 = [[UIImageView alloc] init];
    [imageView1 setImage:[UIImage imageNamed:@"login_third_login_weixin"]];
    [backView addSubview:imageView1];
    
    label1 = [[UILabel alloc] init];
    label1.text = @"微信";
    [backView addSubview:label1];
    
    imageView2 = [[UIImageView alloc] init];
    [imageView2 setImage:[UIImage imageNamed:@"login_third_login_weibo"]];
    [backView addSubview:imageView2];
    
    label2 = [[UILabel alloc] init];
    label2.text = @"微博";
    [backView addSubview:label2];
    
    imageView3 = [[UIImageView alloc] init];
    [imageView3 setImage:[UIImage imageNamed:@"login_third_login_qq"]];
    [backView addSubview:imageView3];
    
    label3 = [[UILabel alloc] init];
    label3.text = @"QQ";
    [backView addSubview:label3];
    
    [imageView1 mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(backView).offset(35);
        make.top.equalTo(backView).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView1).offset(5);
        make.bottom.equalTo(backView).offset(-50);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
    
    [imageView2 mas_updateConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(imageView1).offset(0);
        make.centerX.equalTo(backView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView2).offset(5);
        make.centerY.equalTo(label1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
    
    [imageView3 mas_updateConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(imageView2).offset(0);
        make.right.equalTo(backView).offset(-35);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(imageView3).offset(5);
        make.centerY.equalTo(label2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
    
    imageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *weixinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdLoginWeixinClicked)];
    [imageView1 addGestureRecognizer:weixinTap];
    
    imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *weiboTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdLoginWeiboClicked)];
    [imageView2 addGestureRecognizer:weiboTap];
    
    imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tencentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdLoginTencentClicked)];
    [imageView3 addGestureRecognizer:tencentTap];

}

-(void)initRecognizer{
    kAddNotification(@selector(keyboardWillShow), UIKeyboardWillChangeFrameNotification);
    kAddNotification(@selector(keyboardWillHide), UIKeyboardWillHideNotification);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClicked:)];
    [scrollView addGestureRecognizer:tap];
}

#pragma mark Target Action
-(void)dismiss{
//    if (![CommonUtil judgeIsLoginSuccess]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert show];
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void)getCaptchaButtonClicked{
    if (![VerifyUtil mobileNumberCheck:firstTextField1.text]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的手机号码！"];
    }else{
        [self getCaptchaRequest];
        
        [firstButton1 setEnabled:NO];
        
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
        [firstButton1 setEnabled:YES];
        
        [firstButton1 setTitle:@"获取验证码" forState:UIControlStateNormal];
        [firstButton1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [firstButton1 setBackgroundImage:[UIImage imageNamed:@"login_confirm_login_normal"] forState:UIControlStateNormal];
    });
}

- (void)updateCaptchaButton{
    NSString *timeCountString = [NSString stringWithFormat:@"已发送(%d)", timeCount];
    firstButton1.titleLabel.text = timeCountString;
    [firstButton1 setTitle:timeCountString forState:UIControlStateNormal];
}

-(void)agreementButtonClicked{
    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
    agreementVC.urlStr = @"http://www.jiuzhekan.com/agreement.html";
    agreementVC.titleStr = @"用户协议";
    [self.navigationController pushViewController:agreementVC animated:YES];
}

-(void)loginButtonClicked{
    [self sendLoginRequest];
}

-(void)thirdLoginWeixinClicked{
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self sendWeixinLoginRequest:snsAccount.accessToken name:snsAccount.userName image:snsAccount.iconURL];
        }
    });
}

-(void)thirdLoginWeiboClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [self sendWeiboLoginRequest:snsAccount.accessToken name:snsAccount.userName image:snsAccount.iconURL];
        }
    });
}

-(void)thirdLoginTencentClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@,openid-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
            [self sendTencentLoginRequest:snsAccount.accessToken name:snsAccount.userName image:snsAccount.iconURL];
        }
    });
}

- (void)keyboardWillShow{
    if ([AdaptionUtil isIphoneFour]) {
        scrollView.contentOffset = CGPointMake(0, 50);
    }
}

- (void)keyboardWillHide{
    scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)scrollViewClicked:(UITapGestureRecognizer *)tap{
    [firstTextField1 resignFirstResponder];
    [secondTextField1 resignFirstResponder];
    [firstTextField2 resignFirstResponder];
    [secondTextField2 resignFirstResponder];
}

#pragma mark Network Request
-(void)getCaptchaRequest{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:firstTextField1.text forKey:@"phone"];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_LOGIN_GET_CATPCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

-(void)sendTencentLoginRequest:(NSString *)accessToken name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendTencentLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:accessToken forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Tencent" forKey:@"source"];
    [parameter setValue:@"iOS" forKey:@"equ"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_LOGIN] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"登录成功！" withDelaySeconds:kHud_DelayTime];
            
            [self tencentLoginDataParse];
            
            [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)sendWeixinLoginRequest:(NSString *)accessToken name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendWeixinLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:accessToken forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Weixin" forKey:@"source"];
    [parameter setValue:@"iOS" forKey:@"equ"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_LOGIN] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"登录成功！" withDelaySeconds:kHud_DelayTime];
            
            [self weixinLoginDataParse];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            DLog(@"%ld",(long)self.code2);
            DLog(@"%@",self.message2);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendWeiboLoginRequest:(NSString *)accessToken name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendWeiboLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:accessToken forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Weibo" forKey:@"source"];
    [parameter setValue:@"iOS" forKey:@"equ"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_LOGIN] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"登录成功！" withDelaySeconds:kHud_DelayTime];
            
            [self weiboLoginDataParse];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            DLog(@"%ld",(long)self.code3);
            DLog(@"%@",self.message3);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendLoginRequest{
    LoginRequestDelegate *loginRequest = [[LoginRequestDelegate alloc] init];
    loginRequest.loginDelegate =self;
    
    if (self.loginType == quickLogin) {
        DLog(@"quickLogin");
        if (![VerifyUtil mobileNumberCheck:firstTextField1.text]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的手机号码！"];
        }else if ([secondTextField1.text isEqualToString:@""]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"验证码不能为空！"];
        }else{
            [loginRequest quickLogin:firstTextField1.text pwd:secondTextField1.text];
        }
    }else if (self.loginType == normalLogin){
        DLog(@"normalLogin");
        if (![VerifyUtil mobileNumberCheck:firstTextField2.text]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"请输入正确的手机号码！"];
        }else if ([secondTextField2.text isEqualToString:@""]) {
            [AlertUtil showSimpleAlertWithTitle:nil message:@"密码不能为空！"];
        }else{
            [loginRequest normalLogin:firstTextField2.text pwd:[EncyptionUtil encrypt_md5:secondTextField2.text]];
        }
    }else if (self.loginType == thirdLogin){
        DLog(@"thirdLogin");
    }
}

#pragma mark Data Parse
-(void)tencentLoginDataParse{
    [[NSUserDefaults standardUserDefaults] setValue:[self.data objectForKey:@"token"] forKey:kJZK_token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)weixinLoginDataParse{
    [[NSUserDefaults standardUserDefaults] setValue:[self.data2 objectForKey:@"token"] forKey:kJZK_token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)weiboLoginDataParse{
    [[NSUserDefaults standardUserDefaults] setValue:[self.data3 objectForKey:@"token"] forKey:kJZK_token];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        self.loginType = quickLogin;
        [self initQuickLoginView];
    }else if (selection == 1){
        self.loginType = normalLogin;
        [self initNormalLoginView];
    }else{
        self.loginType = thirdLogin;
        [self initPlatformLoginView];
    }
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self dismissViewControllerAnimated:YES completion:^{
//            [CommonUtil changeIsLoginSuccess:NO];
            BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [self.window setRootViewController:rootVC];
            [self.window addSubview:rootVC.view];
            [self.window makeKeyAndVisible];
        }];
    }
}

#pragma mark LoginDelegate
-(void)loginSuccess:(NSString *)token userId:(NSString *)userId{
    DLog(@"登录成功回调！");
    
    [CommonUtil changeIsLoginSuccess:YES];
    
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:kJZK_token];
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:kJZK_userId];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setTags:nil alias:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
            DLog(@"iResCode-->%d\niAlias-->%@",iResCode,iAlias);
            
        }];
    });
    
    if (![CommonUtil judgeIsLoginOnce]) {
        [CommonUtil changeIsLoginOnce:NO];
        //如果是第一次登录将跳转到相应页面进行资料完善
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)loginError:(NSInteger)code errMsg:(NSString *)message{
    DLog(@"登录错误回调");
    [HudUtil showSimpleTextOnlyHUD:message withDelaySeconds:kHud_DelayTime];
}

-(void)loginFailure:(NSError *)error{
    DLog(@"登录失败回调");
    NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    [HudUtil showSimpleTextOnlyHUD:errorStr withDelaySeconds:kHud_DelayTime];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
