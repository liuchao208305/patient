//
//  MineWalletTixianOneViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletTixianOneViewController.h"
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
#import "MineWalletTixianTableCell.h"
#import "MineWalletTixianTwoViewController.h"

@interface MineWalletTixianOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

//@property (strong,nonatomic)NSMutableDictionary *result2;
//@property (assign,nonatomic)NSInteger code2;
//@property (strong,nonatomic)NSString *message2;
//@property (strong,nonatomic)NSMutableDictionary *data2;
//@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSString *tixianPhoneFix;

@end

@implementation MineWalletTixianOneViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineWalletTixianOneViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"MineWalletTixianOneViewController"];
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
    self.title = @"提现";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115+64) style:UITableViewStyleGrouped];
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
//    return 2;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MineWalletTixianTableCell";
    MineWalletTixianTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MineWalletTixianTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
//    if (indexPath.section == 0) {
//        [cell.titleImageView setImage:[UIImage imageNamed:@"mine_wallet_tixian_zhifubao"]];
//        cell.titleLabel.text = @"支付宝";
//        if ([self.zhifubaoName isEqualToString:@""]) {
//            cell.nameLabel.text = @"暂未绑定";
//        }else{
//            cell.nameLabel.text = self.zhifubaoName;
//        }
//    }else if (indexPath.section == 1){
//        [cell.titleImageView setImage:[UIImage imageNamed:@"mine_wallet_tixian_weixin"]];
//        cell.titleLabel.text = @"微信";
//        if ([self.weixinName isEqualToString:@""]) {
//            cell.nameLabel.text = @"暂未绑定";
//        }else{
//           cell.nameLabel.text = self.weixinName;
//        }
//        
//    }
    [cell.titleImageView setImage:[UIImage imageNamed:@"mine_wallet_tixian_weixin"]];
    cell.titleLabel.text = @"微信";
    if ([self.weixinName isEqualToString:@""]) {
        cell.nameLabel.text = @"暂未绑定";
    }else{
        cell.nameLabel.text = self.weixinName;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",(long)indexPath.section);
    
//    if (indexPath.section == 0) {
////        if ([self.zhifubaoName isEqualToString:@""]) {
////            [AlertUtil showSimpleAlertWithTitle:nil message:@"请前往帐户安全绑定支付宝！"];
////        }else{
////            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您将提现至支付宝" message:self.zhifubaoName delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////            alert.tag = 1;
////            [alert show];
////        }
//        [AlertUtil showSimpleAlertWithTitle:nil message:@"支付宝提现暂未开放，敬请期待！"];
//    }else if (indexPath.section == 1){
//        if ([self.weixinName isEqualToString:@""]) {
//            [AlertUtil showSimpleAlertWithTitle:nil message:@"请前往帐户安全绑定微信！"];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您将提现至微信" message:self.weixinName delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alert.tag = 2;
//            [alert show];
//        }
//    }
    
    if ([self.weixinName isEqualToString:@""]) {
        [AlertUtil showSimpleAlertWithTitle:nil message:@"请前往帐户安全绑定微信！"];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您将提现至微信" message:self.weixinName delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 2;
        [alert show];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex==1) {
            [self sendMineTixianRequest];
        }
    }else if (alertView.tag == 2){
        if (buttonIndex==1) {
            [self sendMineTixianRequest];
        }
    }
}

#pragma mark Network Request
-(void)sendMineTixianRequest{
    DLog(@"sendMineTixianRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:self.tixianPhone forKey:@"phone"];
    [parameter setValue:@"1" forKey:@"userType"];
    
    DLog(@"%@%@",kServerAddress,kJZK_MINE_WALLET_TIXIAN_TWO);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_WALLET_TIXIAN_TWO] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            self.tixianPhoneFix = [NullUtil judgeStringNull:[self.data1 objectForKey:@"phone"]];
            
            MineWalletTixianTwoViewController *mineWalletTixian2VC = [[MineWalletTixianTwoViewController alloc] init];
            mineWalletTixian2VC.tixianPhone = self.tixianPhoneFix;
            [self.navigationController pushViewController:mineWalletTixian2VC animated:YES];
        }else{
            DLog(@"%ld",(long)self.code1);
            DLog(@"%@",self.message1);
            [AlertUtil showSimpleAlertWithTitle:nil message:self.message1];
//            [AlertUtil showSimpleAlertWithTitle:nil message:@"请前往［设置－账号安全］绑定手机号！"];
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

//-(void)sendGetCaptchaRequest{
//    DLog(@"sendGetCaptchaRequest");
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDAnimationFade;
//    hud.labelText = kNetworkStatusLoadingText;
//    
//    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.tixianPhoneFix forKey:@"phone"];
//    
//    
//    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_LOGIN_GET_CATPCHA] successBlock:^(NSURLSessionDataTask *task,id responseObject){
//        DLog(@"responseObject-->%@",responseObject);
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//        self.result2 = (NSMutableDictionary *)responseObject;
//        
//        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
//        self.message2 = [self.result2 objectForKey:@"message"];
//        self.data2 = [self.result2 objectForKey:@"data"];
//        
//        if (self.code2 == kSUCCESS) {
//            [HudUtil showSimpleTextOnlyHUD:@"验证码发送成功！" withDelaySeconds:kHud_DelayTime];
//            
//            MineWalletTixianTwoViewController *mineWalletTixian2VC = [[MineWalletTixianTwoViewController alloc] init];
//            mineWalletTixian2VC.tixianPhone = self.tixianPhoneFix;
//            [self.navigationController pushViewController:mineWalletTixian2VC animated:YES];
//        }else{
//            DLog(@"%ld",(long)self.code2);
//            DLog(@"%@",self.message2);
//            if (self.code2 == kTOKENINVALID) {
//                LoginViewController *loginVC = [[LoginViewController alloc] init];
//                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//                [self presentViewController:navController animated:YES completion:nil];
//            }
//        }
//        
//    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
//        
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        DLog(@"errorStr-->%@",errorStr);
//        
//        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
//    }];
//}

@end
