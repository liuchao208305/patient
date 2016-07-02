//
//  HealthMarriageHistoryViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthMarriageHistoryViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"

@interface HealthMarriageHistoryViewController ()<UITextViewDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)int marryStatus;
@property (assign,nonatomic)BOOL unmarriedClickedFlag;
@property (assign,nonatomic)BOOL marriedClickedFlag;

@property (assign,nonatomic)int erziCount;
@property (assign,nonatomic)int nverCount;

@end

@implementation HealthMarriageHistoryViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthMarriageHistoryViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthMarriageHistoryViewController"];
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
    
    self.title = @"婚育情况";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.backView1 = [[UIView alloc] init];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self initSubView1];
    [self.view addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] init];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self initSubView2];
    [self.view addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] init];
    self.backView3.backgroundColor = kWHITE_COLOR;
    [self initSubView3];
    [self.view addSubview:self.backView3];
    
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(0);
        make.trailing.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(50);
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(0);
        make.trailing.equalTo(self.view).offset(0);
        make.top.equalTo(self.backView1.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self.backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(0);
        make.trailing.equalTo(self.view).offset(0);
        make.top.equalTo(self.backView2.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
}

-(void)initSubView1{
    self.label1 = [[UILabel alloc] init];
    self.label1.font = [UIFont systemFontOfSize:16];
    self.label1.text = @"婚育情况";
    [self.backView1 addSubview:self.label1];
    
    self.button1 = [[UIButton alloc] init];
    [self.button1 setTitle:@"未婚" forState:UIControlStateNormal];
    [self.button1 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.borderWidth = 1;
    self.button1.layer.borderColor = ColorWithHexRGB(0x646464).CGColor;
    [self.button1 addTarget:self action:@selector(unmarriedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView1 addSubview:self.button1];
    
    self.button2 = [[UIButton alloc] init];
    [self.button2 setTitle:@"已婚" forState:UIControlStateNormal];
    [self.button2 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    self.button2.layer.cornerRadius = 5;
    self.button2.layer.borderWidth = 1;
    self.button2.layer.borderColor = ColorWithHexRGB(0x646464).CGColor;
    [self.button2 addTarget:self action:@selector(marriedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.backView1 addSubview:self.button2];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(12);
        make.centerY.equalTo(self.backView1).offset(0);
    }];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.button2.mas_leading).offset(-12);
        make.centerY.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-12);
        make.centerY.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(30);
    }];
}

-(void)initSubView2{
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.font = [UIFont systemFontOfSize:16];
    self.label2_1.text = @"儿子";
    [self.backView2 addSubview:self.label2_1];
    
    self.textField2 = [[UITextField alloc] init];
    self.textField2.placeholder = @"0";
    self.textField2.textColor = ColorWithHexRGB(0x646464);
    [self.backView2 addSubview:self.textField2];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"个";
    self.label2_2.textColor = ColorWithHexRGB(0x646464);
    [self.backView2 addSubview:self.label2_2];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(12);
        make.centerY.equalTo(self.backView2).offset(0);
    }];
    
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.label2_2.mas_leading).offset(-5);
        make.centerY.equalTo(self.backView2).offset(0);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView2).offset(-12);
        make.centerY.equalTo(self.backView2).offset(0);
    }];
}

-(void)initSubView3{
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.font = [UIFont systemFontOfSize:16];
    self.label3_1.text = @"女儿";
    [self.backView3 addSubview:self.label3_1];
    
    self.textField3 = [[UITextField alloc] init];
    self.textField3.placeholder = @"0";
    self.textField3.textColor = ColorWithHexRGB(0x646464);
    [self.backView3 addSubview:self.textField3];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"个";
    self.label3_2.textColor = ColorWithHexRGB(0x646464);
    [self.backView3 addSubview:self.label3_2];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView3).offset(12);
        make.centerY.equalTo(self.backView3).offset(0);
    }];
    
    [self.textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.label3_2.mas_leading).offset(-5);
        make.centerY.equalTo(self.backView3).offset(0);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView3).offset(-12);
        make.centerY.equalTo(self.backView3).offset(0);
    }];
}

-(void)initRecognizer{
    UITapGestureRecognizer *wholeViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wholeViewClicked)];
    [self.view addGestureRecognizer:wholeViewTap];
}

#pragma mark Target Action
-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
    
    if (self.marryStatus == 0) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请选择您的婚姻情况"];
    }else{
        if (self.marryStatus == 2) {
            if (self.erziCount == 0 && self.nverCount == 0) {
                [AlertUtil showSimpleAlertWithTitle:nil message:@"请填写您的儿女数量"];
            }else{
                [self sendMarriageHistoryConfirmRequest];
            }
        }
    }
}

-(void)unmarriedButtonClicked{
    self.unmarriedClickedFlag = YES;
    self.marriedClickedFlag = NO;
    [self changeButtonPresentation];
    self.marryStatus = 1;
    DLog(@"self.marryStatus-->%d",self.marryStatus);
}

-(void)marriedButtonClicked{
    self.unmarriedClickedFlag = NO;
    self.marriedClickedFlag = YES;
    [self changeButtonPresentation];
    self.marryStatus = 2;
    DLog(@"self.marryStatus-->%d",self.marryStatus);
}

-(void)changeButtonPresentation{
    if (self.unmarriedClickedFlag ==YES) {
        [self.button1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        self.button1.layer.borderColor = kMAIN_COLOR.CGColor;
        [self.button2 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button2.layer.borderColor = ColorWithHexRGB(0x646464).CGColor;
    }
    
    if (self.marriedClickedFlag == YES) {
        [self.button1 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button1.layer.borderColor = ColorWithHexRGB(0x646464).CGColor;
        [self.button2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
        self.button2.layer.borderColor = kMAIN_COLOR.CGColor;
    }
}

-(void)wholeViewClicked{
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    self.erziCount = [self.textField2.text intValue];
    self.nverCount = [self.textField3.text intValue];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    self.erziCount = [self.textField2.text intValue];
    self.nverCount = [self.textField3.text intValue];
    return YES;
}

#pragma mark Network Request
-(void)sendMarriageHistoryConfirmRequest{
    DLog(@"sendMarriageHistoryConfirmRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%d",self.marryStatus] forKey:@"marriage_status"];
    [parameter setValue:[NSString stringWithFormat:@"%d",self.erziCount] forKey:@"a_son"];
    [parameter setValue:[NSString stringWithFormat:@"%d",self.nverCount] forKey:@"b_son"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_MARRIAGE_HISTORY_CONFIRM] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"提交成功！" withDelaySeconds:kHud_DelayTime];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
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

#pragma mark Data Filling

@end
