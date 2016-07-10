//
//  MineWalletViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "MineWalletTableCell.h"
#import "MineWalletData.h"

@interface MineWalletViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableDictionary *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@property (strong,nonatomic)NSString *accountMoney;

@end

@implementation MineWalletViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendMineWalletRequest1];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthListViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.tradeArray = [NSMutableArray array];
    self.tradeIdArray = [NSMutableArray array];
    self.tradeTypeArray = [NSMutableArray array];
    self.tradeMoneyArray = [NSMutableArray array];
    self.tradeTimeArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.title = @"我的钱包";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现" style:(UIBarButtonItemStylePlain) target:self action:@selector(tixianButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-115+64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    self.headView.backgroundColor = kWHITE_COLOR;
    
    self.accountLabel = [[UILabel alloc] init];
    self.accountLabel.font = [UIFont systemFontOfSize:16];
    self.accountLabel.textColor = ColorWithHexRGB(0x65b317);
    [self.headView addSubview:self.accountLabel];
    
    self.moneyLabel1 = [[UILabel alloc] init];
    self.moneyLabel1.font = [UIFont systemFontOfSize:13];
    self.moneyLabel1.textColor = ColorWithHexRGB(0x909090);
    [self.headView addSubview:self.moneyLabel1];
    
    self.moneyLabel2 = [[UILabel alloc] init];
    self.moneyLabel2.font = [UIFont systemFontOfSize:30];
    [self.headView addSubview:self.moneyLabel2];
    
    self.moneyLabel3 = [[UILabel alloc] init];
    self.moneyLabel3.font = [UIFont systemFontOfSize:13];
    self.moneyLabel3.textColor = ColorWithHexRGB(0x909090);
    [self.headView addSubview:self.moneyLabel3];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.headView).offset(15);
        make.centerY.equalTo(self.headView).offset(0);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel2.mas_leading).offset(-1);
        make.bottom.equalTo(self.accountLabel).offset(4);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel3.mas_leading).offset(-1);
        make.centerY.equalTo(self.accountLabel).offset(0);
    }];
    
    [self.moneyLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.headView).offset(-15);
        make.bottom.equalTo(self.accountLabel).offset(4);
    }];
    
    self.tableView.tableHeaderView = self.headView;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendMineWalletRequest2];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)tixianButtonClicked{
    DLog(@"tixianButtonClicked");
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tradeArray.count==0 ? 0 : self.tradeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.mineWalletHeaderView = [[MineWalletHeaderView alloc] init];
    
    self.mineWalletHeaderView.titleLabel.text = @"交易纪录";
    
    return self.mineWalletHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MineWalletTableCell";
    MineWalletTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MineWalletTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if ([self.tradeTypeArray[indexPath.row] intValue] == 1) {
        cell.typeLabel1.text = @"被旁听";
        cell.typeLabel2.text = @"收入";
    }else if ([self.tradeTypeArray[indexPath.row] intValue] == 2){
        cell.typeLabel1.text = @"提现";
        cell.typeLabel2.text = @"支出";
    }
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %@ 元",self.tradeMoneyArray[indexPath.row]];
    
    cell.timeLabel.text = self.tradeTimeArray[indexPath.row];
    
    if ([self.tradeTypeArray[indexPath.row] intValue] == 1) {
        cell.typeLabel1.textColor = ColorWithHexRGB(0x909090);
        cell.typeLabel2.textColor = ColorWithHexRGB(0x909090);
        cell.moneyLabel.textColor = ColorWithHexRGB(0x909090);
        cell.timeLabel.textColor = ColorWithHexRGB(0x909090);
    }else if ([self.tradeTypeArray[indexPath.row] intValue] == 2){
        cell.typeLabel1.textColor = ColorWithHexRGB(0xee5722);
        cell.typeLabel2.textColor = ColorWithHexRGB(0xee5722);
        cell.moneyLabel.textColor = ColorWithHexRGB(0xee5722);
        cell.timeLabel.textColor = ColorWithHexRGB(0xee5722);
    }
    
    return cell;
}

#pragma mark Network Request
-(void)sendMineWalletRequest1{
    DLog(@"sendMineWalletRequest1");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_WALLET_INFORMATION_ONE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self mineWalletInfoDataParse1];
        }else{
            DLog(@"%@",self.message1);
            [HudUtil showSimpleTextOnlyHUD:self.message1 withDelaySeconds:kHud_DelayTime];
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

-(void)sendMineWalletRequest2{
    DLog(@"sendMineWalletRequest2");
    
    self.currentPage = 1;
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameter setValue:@"0" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_WALLET_INFORMATION_TWO] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self mineWalletInfoDataParse2];
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
-(void)mineWalletInfoDataParse1{
    self.accountMoney = [NullUtil judgeStringNull:[self.data1 objectForKey:@"money"]];
    
    [self mineWalletDataFilling];
    
    [self sendMineWalletRequest2];
}

-(void)mineWalletInfoDataParse2{
    self.tradeArray = [MineWalletData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.tradeIdArray removeAllObjects];
    [self.tradeTypeArray removeAllObjects];
    [self.tradeMoneyArray removeAllObjects];
    [self.tradeTimeArray removeAllObjects];
    for (MineWalletData *mineWalletData in self.tradeArray) {
        [self.tradeIdArray addObject:[NullUtil judgeStringNull:mineWalletData.deal_id]];
        [self.tradeTypeArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%d",mineWalletData.type]]];
        [self.tradeMoneyArray addObject:[NullUtil judgeStringNull:mineWalletData.price]];
        [self.tradeTimeArray addObject:[NullUtil judgeStringNull:mineWalletData.dates]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark Data Filling
-(void)mineWalletDataFilling{
    self.accountLabel.text = @"账户余额";
    
    self.moneyLabel1.text = @"¥";
    self.moneyLabel2.text = self.accountMoney;
    self.moneyLabel3.text = @"元";
}

@end
