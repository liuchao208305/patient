//
//  MineAccoutSecurityViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineAccoutSecurityViewController.h"
#import "AdaptionUtil.h"
#import "NetworkUtil.h"
#import "AlertUtil.h"
#import "HudUtil.h"
#import "CommonUtil.h"
#import "AnalyticUtil.h"
#import "VerifyUtil.h"
#import "DateUtil.h"
#import "NullUtil.h"
#import "LoginViewController.h"
#import "MineSettingTwoTableCell.h"
#import "CustomAlert.h"
#import "MineChangePhoneOneViewController.h"
#import "MineChangePhoneTwoViewController.h"
#import "MineChangeEmailViewController.h"
#import "WXApi.h"

@interface MineAccoutSecurityViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *phoneString;
@property (strong,nonatomic)NSString *emailString;
@property (strong,nonatomic)NSString *tencentString;
@property (strong,nonatomic)NSString *weixinString;
@property (strong,nonatomic)NSString *weiboString;

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

@property (strong,nonatomic)NSMutableDictionary *result2Fix1;
@property (assign,nonatomic)NSInteger code2Fix1;
@property (strong,nonatomic)NSString *message2Fix1;
@property (strong,nonatomic)NSMutableDictionary *data2Fix1;
@property (assign,nonatomic)NSError *error2Fix1;

@property (strong,nonatomic)NSMutableDictionary *result2Fix2;
@property (assign,nonatomic)NSInteger code2Fix2;
@property (strong,nonatomic)NSString *message2Fix2;
@property (strong,nonatomic)NSMutableDictionary *data2Fix2;
@property (assign,nonatomic)NSError *error2Fix2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

@property (strong,nonatomic)NSMutableDictionary *result4;
@property (assign,nonatomic)NSInteger code4;
@property (strong,nonatomic)NSString *message4;
@property (strong,nonatomic)NSMutableDictionary *data4;
@property (assign,nonatomic)NSError *error4;

@property (strong,nonatomic)NSMutableDictionary *result5;
@property (assign,nonatomic)NSInteger code5;
@property (strong,nonatomic)NSString *message5;
@property (strong,nonatomic)NSMutableDictionary *data5;
@property (assign,nonatomic)NSError *error5;

@end

@implementation MineAccoutSecurityViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineAccoutSecurityViewController"];
    
    [self sendAccountSecurityRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineAccoutSecurityViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
    self.title = @"账号安全";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT-115+64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        return 3;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MineSettingTwoTableCell";
    MineSettingTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MineSettingTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"手机号码";
            cell.phoneLabel.text = [self.phoneString isEqualToString:@""] ?@"暂无" : self.phoneString;
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"邮箱账号";
            cell.phoneLabel.text = [self.emailString isEqualToString:@""] ?@"暂无" : self.emailString;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.titleLabel.text = @"QQ";
            cell.phoneLabel.text = [self.tencentString isEqualToString:@""] ?@"暂无" : self.tencentString;
        }else if (indexPath.row == 1){
            cell.titleLabel.text = @"微信";
            cell.phoneLabel.text = [self.weixinString isEqualToString:@""] ?@"暂无" : self.weixinString;
        }else if (indexPath.row == 2){
            cell.titleLabel.text = @"微博";
            cell.phoneLabel.text = [self.weiboString isEqualToString:@""] ?@"暂无" : self.weiboString;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",indexPath.section);
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([self.phoneString isEqualToString:@""]) {
                if ([self.tencentString isEqualToString:@""] && [self.weixinString isEqualToString:@""] && [self.weiboString isEqualToString:@""]) {
                    [AlertUtil showSimpleAlertWithTitle:nil message:@"请先进行第三方平台认证！"];
                }else{
                    MineChangePhoneTwoViewController *changePhoneTwoVC = [[MineChangePhoneTwoViewController alloc] init];
                    changePhoneTwoVC.sourceVC = @"MineAccoutSecurityViewController";
                    [self.navigationController pushViewController:changePhoneTwoVC animated:YES];
                }
            }else{
//                [self sendChangePhoneRequest];
                NSString *msg = [NSString stringWithFormat:@"%@\n来完成手机号更换",self.phoneString];
                CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"将发送验证码至您的手机" withMsg:msg withCancel:@"确定" withSure:@"取消"];
                [alert alertViewShow];
                alert.alertViewBlock = ^(NSInteger index) {
                    if (index == 1) {
                        [self sendGetCaptchaRequest];
                    }
                };
            }
        }else if (indexPath.row == 1){
            MineChangeEmailViewController *changeEmailVC = [[MineChangeEmailViewController alloc] init];
            changeEmailVC.emailString = self.emailString;
            [self.navigationController pushViewController:changeEmailVC animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@,openid-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
                    [self sendTencentLoginRequest:snsAccount.openId name:snsAccount.userName image:snsAccount.iconURL];
                }
            });
        }else if (indexPath.row == 1){
//            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//                if (response.responseCode == UMSResponseCodeSuccess) {
//                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//                    NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//                    [self sendWeixinLoginRequest:snsAccount.openId name:snsAccount.userName image:snsAccount.iconURL];
//                }
//            });
            if ([WXApi isWXAppInstalled]){
                SendAuthReq* req =[[SendAuthReq alloc] init];
                req.scope = @"snsapi_userinfo" ;
                req.state = @"123" ;
                [WXApi sendReq:req];
                
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAuthResult:) name:@"WXAuthMineAccoutSecurityViewController" object:nil];
                [[NSUserDefaults standardUserDefaults] setValue:@"WXAuthMineAccoutSecurityViewController" forKey:kJZK_weixinauthType];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }else if (indexPath.row == 2){
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    NSLog(@"username-->%@,uid-->%@,token-->%@,url-->%@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    [self sendWeiboLoginRequest:snsAccount.usid name:snsAccount.userName image:snsAccount.iconURL];
                }
            });
        }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getAuthResult:(NSNotification *)notification{
    NSLog(@"object: %@",notification.object);
    [self sendWeixinAuthRequest1:notification.object];
}

-(void)sendWeixinAuthRequest1:(NSString *)code{
    DLog(@"sendWeixinAuthRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"wx6a048cad50cccc7b" forKey:@"appid"];
    [parameter setValue:@"5cc5a1439d30a6bbead8dffeaa52aadc" forKey:@"secret"];
    [parameter setValue:code forKey:@"code"];
    [parameter setValue:@"authorization_code" forKey:@"grant_type"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:@"https://api.weixin.qq.com/sns/oauth2/access_token?" successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2Fix1 = (NSMutableDictionary *)responseObject;
        
        self.code2Fix1 = [[self.result2Fix1 objectForKey:@"code"] integerValue];
        self.message2Fix1 = [self.result2Fix1 objectForKey:@"message"];
        self.data2Fix1 = [self.result2Fix1 objectForKey:@"data"];
        
        if (self.code2Fix1 == kSUCCESS) {
            DLog(@"self.result2Fix1-->%@",self.result2Fix1);
            [self sendWeixinAuthRequest2:[self.result2Fix1 objectForKey:@"openid"] access_token:[self.result2Fix1 objectForKey:@"access_token"]];
        }else{
            DLog(@"%ld",(long)self.code2Fix1);
            DLog(@"%@",self.message2Fix1);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendWeixinAuthRequest2:(NSString *)openid access_token:(NSString *)access_token{
    DLog(@"sendWeixinAuthRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:openid forKey:@"openid"];
    [parameter setValue:access_token forKey:@"access_token"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:@"https://api.weixin.qq.com/sns/userinfo?" successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2Fix2 = (NSMutableDictionary *)responseObject;
        
        self.code2Fix2 = [[self.result2Fix2 objectForKey:@"code"] integerValue];
        self.message2Fix2 = [self.result2Fix2 objectForKey:@"message"];
        self.data2Fix2 = [self.result2Fix2 objectForKey:@"data"];
        
        if (self.code2Fix2 == kSUCCESS) {
            DLog(@"self.result2Fix2-->%@",self.result2Fix2);
            [self sendWeixinLoginRequest:[self.result2Fix2 objectForKey:@"openid"] name:[self.result2Fix2 objectForKey:@"nickname"] image:[self.result2Fix2 objectForKey:@"headimgurl"]];
        }else{
            DLog(@"%ld",(long)self.code2Fix2);
            DLog(@"%@",self.message2Fix2);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Network Request
-(void)sendAccountSecurityRequest{
    DLog(@"sendAccountSecurityRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ACCOUNT_SECURITY_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self accoutSecurityDataParse];
        }else{
            DLog(@"%ld",(long)self.code);
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

-(void)sendTencentLoginRequest:(NSString *)openId name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendTencentLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:openId forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Tencent" forKey:@"source"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_AUTHORIZATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"QQ授权成功！" withDelaySeconds:kHud_DelayTime];
            
            [self sendAccountSecurityRequest];
        }else{
            DLog(@"%ld",(long)self.code1);
            DLog(@"%@",self.message1);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendWeixinLoginRequest:(NSString *)openId name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendWeixinLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:openId forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Weixin" forKey:@"source"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_AUTHORIZATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"微信授权成功！" withDelaySeconds:kHud_DelayTime];
            
            [self sendAccountSecurityRequest];
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

-(void)sendWeiboLoginRequest:(NSString *)usid name:(NSString *)userName image:(NSString *)iconURL{
    DLog(@"sendWeiboLoginRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:usid forKey:@"code"];
    [parameter setValue:userName forKey:@"name"];
    [parameter setValue:iconURL forKey:@"head_url"];
    [parameter setValue:@"Weibo" forKey:@"source"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_THIRD_AUTHORIZATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"微博授权成功！" withDelaySeconds:kHud_DelayTime];
            
            [self sendAccountSecurityRequest];
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

-(void)sendChangePhoneRequest{
    DLog(@"sendChangePhoneRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:self.phoneString forKey:@"phone"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CHANGE_PHONE_INFORMATION_ONE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            NSString *msg = [NSString stringWithFormat:@"%@\n来完成手机号更换",self.phoneString];
            CustomAlert *alert = [[CustomAlert alloc] initWithTitle:@"将发送验证码至您的手机" withMsg:msg withCancel:@"确定" withSure:@"取消"];
            [alert alertViewShow];
            alert.alertViewBlock = ^(NSInteger index) {
                if (index == 1) {
                    [self sendGetCaptchaRequest];
                }
            };
        }else{
            DLog(@"%ld",(long)self.code4);
            DLog(@"%@",self.message4);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message4];
            if (self.code4 == kTOKENINVALID) {
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
    [parameter setValue:self.phoneString forKey:@"phone"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_LOGIN_GET_CATPCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result5 = (NSMutableDictionary *)responseObject;
        
        self.code5 = [[self.result5 objectForKey:@"code"] integerValue];
        self.message5 = [self.result5 objectForKey:@"message"];
        self.data5 = [self.result5 objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [HudUtil showSimpleTextOnlyHUD:@"验证码发送成功！" withDelaySeconds:kHud_DelayTime];
            
            MineChangePhoneOneViewController *changePhoneOneVC = [[MineChangePhoneOneViewController alloc] init];
            changePhoneOneVC.soureVC = @"MineAccoutSecurityViewController";
            changePhoneOneVC.OldPhoneString = self.phoneString;
            
            [self.navigationController pushViewController:changePhoneOneVC animated:YES];
        }else{
            DLog(@"%ld",(long)self.code5);
            DLog(@"%@",self.message5);
            if (self.code5 == kTOKENINVALID) {
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
-(void)accoutSecurityDataParse{
    self.phoneString = [NullUtil judgeStringNull:[self.data objectForKey:@"phone"]];
    self.emailString = [NullUtil judgeStringNull:[self.data objectForKey:@"email"]];
    self.tencentString = [NullUtil judgeStringNull:[self.data objectForKey:@"Tencent"]];
    self.weixinString = [NullUtil judgeStringNull:[self.data objectForKey:@"Weixin"]];
    self.weiboString = [NullUtil judgeStringNull:[self.data objectForKey:@"Weibo"]];
    
    [self.tableView reloadData];
}

#pragma mark Data Filling

@end
