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

@interface LoginViewController ()<YJSegmentedControlDelegate>{
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
@end

@implementation LoginViewController

#pragma mark Life Circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (thread != nil) {
        [thread cancel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init Section
-(void)initNavBar{
    self.navigationController.navigationBar.hidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 156)];
    whiteBackView.backgroundColor = kWHITE_COLOR;
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"手机快速登录", @"已有帐号登录", @"第三方登录",nil];
    YJSegmentedControl * segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self];
    [whiteBackView addSubview:segmentControl];
    
    segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [whiteBackView addSubview:segmentBottomLineView];
    [self initQuickLoginView];
    
    [self.view addSubview:whiteBackView];
    
    grayBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, SCREEN_HEIGHT-156)];
    grayBackView.backgroundColor = kBACKGROUND_COLOR;
    [self.view addSubview:grayBackView];
    
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

}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getCaptchaButtonClicked{
    [self getCaptchaRequest];
    
    [firstButton1 setEnabled:NO];
    
    thread= [[NSThread alloc]initWithTarget:self selector:@selector(beginCountDown) object:nil];
    [thread start];
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

- (void) updateCaptchaButton{
    NSString *timeCountString = [NSString stringWithFormat:@"已发送(%d)", timeCount];
    firstButton1.titleLabel.text = timeCountString;
    [firstButton1 setTitle:timeCountString forState:UIControlStateNormal];
}

-(void)agreementButtonClicked{
    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
    agreementVC.urlStr = @"http://www.jiuzhekan.com/agreement.html";
    [self.navigationController pushViewController:agreementVC animated:YES];
}
#pragma mark Network Request
-(void)getCaptchaRequest{
//    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:@"18058974552" forKey:@"phone"];
//    
//    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:kServerUrl successBlock:^(NSURLSessionDataTask *task,id responseObject){
//        DLog(@"responseObject-->%@",responseObject);
//    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        DLog(@"errorStr-->%@",errorStr);
//    }];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"18058974552" forKey:@"phone"];
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [[NetworkUtil sharedInstance]postResultWithParameter:parameter url:kServerUrl successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}
#pragma mark Data Parse

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        [self initQuickLoginView];
    }else if (selection == 1){
        [self initNormalLoginView];
    }else{
        [self initPlatformLoginView];
    }
    
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
