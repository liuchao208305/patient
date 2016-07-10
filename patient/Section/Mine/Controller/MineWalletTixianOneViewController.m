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

@interface MineWalletTixianOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSString *zhifubaoName;
@property (strong,nonatomic)NSString *weixinName;

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
    
    [self sendMineTixianRequest];
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
    return 2;
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
    if (indexPath.section == 0) {
        [cell.titleImageView setImage:[UIImage imageNamed:@"mine_wallet_tixian_zhifubao"]];
        cell.titleLabel.text = @"支付宝";
        cell.nameLabel.text = self.zhifubaoName;
    }else if (indexPath.section == 1){
        [cell.titleImageView setImage:[UIImage imageNamed:@"mine_wallet_tixian_weixin"]];
        cell.titleLabel.text = @"微信";
        cell.nameLabel.text = self.weixinName;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"%ld",indexPath.section);
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_accout] forKey:@"phone"];
    [parameter setValue:@"1" forKey:@"userType"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_WALLET_TIXIAN_ONE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self mineTixianDataParse];
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

#pragma mark Data Parse
-(void)mineTixianDataParse{
    self.zhifubaoName = [NullUtil judgeStringNull:[self.data objectForKey:@"Alipay"]];
    self.weixinName = [NullUtil judgeStringNull:[self.data objectForKey:@"Weixin"]];
    
    [self.tableView reloadData];
}

#pragma mark Data Filling

@end
