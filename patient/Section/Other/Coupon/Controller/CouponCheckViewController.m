//
//  CouponCheckViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "CouponCheckViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"

@interface CouponCheckViewController ()<UIAlertViewDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result1;
@property (assign,nonatomic)NSInteger code1;
@property (strong,nonatomic)NSString *message1;
@property (strong,nonatomic)NSMutableArray *data1;
@property (assign,nonatomic)NSError *error1;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableArray *data3;
@property (assign,nonatomic)NSError *error3;

@end

@implementation CouponCheckViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"CouponCheckViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.flag1 = YES;
    self.flag2 = NO;
    self.flag3 = NO;
    
    [self initSubView1];
    
    [self sendCouponCheckRequest1];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"CouponCheckViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.couponArrayUnused = [NSMutableArray array];
    self.couponIdArrayUnused = [NSMutableArray array];
    self.couponTypeArrayUnused = [NSMutableArray array];
    self.couponNameArrayUnused = [NSMutableArray array];
    self.couponDescriptionArrayUnused = [NSMutableArray array];
    self.couponMoneyArrayUnused = [NSMutableArray array];
    self.couponStatusArrayUnused = [NSMutableArray array];
    self.couponDayArrayUnused = [NSMutableArray array];
    self.couponMinMoneyArrayUnused = [NSMutableArray array];
    self.couponReasonArrayUnused = [NSMutableArray array];
    self.couponRebateArrayUnused = [NSMutableArray array];
    self.couponEndArrayUnused = [NSMutableArray array];
    
    self.couponArrayUsed = [NSMutableArray array];
    self.couponIdArrayUsed = [NSMutableArray array];
    self.couponTypeArrayUsed = [NSMutableArray array];
    self.couponNameArrayUsed = [NSMutableArray array];
    self.couponDescriptionArrayUsed = [NSMutableArray array];
    self.couponMoneyArrayUsed = [NSMutableArray array];
    self.couponStatusArrayUsed = [NSMutableArray array];
    self.couponDayArrayUsed = [NSMutableArray array];
    self.couponMinMoneyArrayUsed = [NSMutableArray array];
    self.couponReasonArrayUsed = [NSMutableArray array];
    self.couponRebateArrayUsed = [NSMutableArray array];
    self.couponEndArrayUsed = [NSMutableArray array];
    
    self.couponArrayExpired = [NSMutableArray array];
    self.couponIdArrayExpired = [NSMutableArray array];
    self.couponTypeArrayExpired = [NSMutableArray array];
    self.couponNameArrayExpired = [NSMutableArray array];
    self.couponDescriptionArrayExpired = [NSMutableArray array];
    self.couponMoneyArrayExpired = [NSMutableArray array];
    self.couponStatusArrayExpired = [NSMutableArray array];
    self.couponDayArrayExpired = [NSMutableArray array];
    self.couponMinMoneyArrayExpired = [NSMutableArray array];
    self.couponReasonArrayExpired = [NSMutableArray array];
    self.couponRebateArrayExpired = [NSMutableArray array];
    self.couponEndArrayExpired = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"我的优惠券";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换" style:(UIBarButtonItemStylePlain) target:self action:@selector(exchangeButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"未使用", @"已使用", @"已过期",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor grayColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kBLACK_COLOR buttonDownColor:nil Delegate:self selectSeugment:0];
    [self.view addSubview:self.segmentControl];
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = NO;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView1.tableHeaderView = self.headView;
    self.tableView1.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = NO;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView2.tableHeaderView = self.headView;
    self.tableView2.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView2];
}

-(void)initSubView3{
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42) style:UITableViewStyleGrouped];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.showsVerticalScrollIndicator = NO;
    self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView3.tableHeaderView = self.headView;
    self.tableView3.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView3];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)exchangeButtonClicked{
    DLog(@"exchangeButtonClicked");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"兑换优惠券" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"兑换",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textfield = [alertView textFieldAtIndex:0];
        DLog(@"%@",textfield.text);
        [self sendCouponExchangeRequest:textfield.text];
    }
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        [self sendCouponCheckRequest1];
        [self initSubView1];
    }else if (selection == 1){
        self.flag1 = NO;
        self.flag2 = YES;
        self.flag3 = NO;
        [self sendCouponCheckRequest2];
        [self initSubView2];
    }else if (selection == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        [self sendCouponCheckRequest3];
        [self initSubView3];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.couponArrayUnused.count == 0 ? 0 : self.couponArrayUnused.count;
    }else if (self.flag2){
        return self.couponArrayUsed.count == 0 ? 0 : self.couponArrayUsed.count;
    }else if (self.flag3){
        return self.couponArrayExpired.count == 0 ? 0 : self.couponArrayExpired.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 134;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"CouponTableCell";
    CouponTableCell *cell = [self.tableView1 dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[CouponTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (self.flag1) {
        [cell.backImageView setImage:[UIImage imageNamed:@"info_coupon_blue_back_image"]];
        cell.moneySmallLabel.text = @"¥";
        if ([self.couponMoneyArrayUnused[indexPath.section] integerValue] == 0) {
            cell.moneyBigLabel.text = self.couponRebateArrayUnused[indexPath.section];
        }else{
            cell.moneyBigLabel.text = self.couponMoneyArrayUnused[indexPath.section];
        }
        cell.moneyBottomLabel.text = self.couponReasonArrayUnused[indexPath.section];
        if ([self.couponDayArrayUnused[indexPath.section] integerValue] < 8) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%@到期（仅剩%@天）",self.couponEndArrayUnused[indexPath.section],self.couponDayArrayUnused[indexPath.section]];
        }else{
            cell.dateLabel.text = [NSString stringWithFormat:@"%@到期",self.couponEndArrayUnused[indexPath.section]];
        }
        cell.conditionLabel.text = self.couponDescriptionArrayUnused[indexPath.section];
        cell.nameLabelLeft.text = self.couponNameArrayUnused[indexPath.section];
    }else if (self.flag2){
        [cell.backImageView setImage:[UIImage imageNamed:@"info_coupon_pink_back_image"]];
        cell.moneySmallLabel.text = @"¥";
        if ([self.couponMoneyArrayUsed[indexPath.section] integerValue] == 0) {
            cell.moneyBigLabel.text = self.couponRebateArrayUsed[indexPath.section];
        }else{
            cell.moneyBigLabel.text = self.couponMoneyArrayUsed[indexPath.section];
        }
        cell.moneyBottomLabel.text = self.couponReasonArrayUsed[indexPath.section];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@已使用",self.couponEndArrayUsed[indexPath.section]];
        cell.conditionLabel.text = self.couponDescriptionArrayUsed[indexPath.section];
        cell.nameLabelLeft.text = self.couponNameArrayUsed[indexPath.section];
    }else if (self.flag3){
        [cell.backImageView setImage:[UIImage imageNamed:@"info_coupon_yellow_back_image"]];
        cell.moneySmallLabel.text = @"¥";
        if ([self.couponMoneyArrayExpired[indexPath.section] integerValue] == 0) {
            cell.moneyBigLabel.text = self.couponRebateArrayExpired[indexPath.section];
        }else{
            cell.moneyBigLabel.text = self.couponMoneyArrayExpired[indexPath.section];
        }
        cell.moneyBottomLabel.text = self.couponReasonArrayExpired[indexPath.section];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@已过期",self.couponEndArrayExpired[indexPath.section]];
        cell.conditionLabel.text = self.couponDescriptionArrayExpired[indexPath.section];
        cell.nameLabelLeft.text = self.couponNameArrayExpired[indexPath.section];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if (!self.isFromMineVC) {
            if ([self.couponMinMoneyArrayUnused[indexPath.section] doubleValue] < self.treatmentMoney && [self.couponTypeArrayUnused[indexPath.section] integerValue] == 2) {
                if (self.couponDelegate && [self.couponDelegate respondsToSelector:@selector(couponSelected:)]) {
                    [self.couponDelegate couponSelected:self.couponArrayUnused[indexPath.section]];
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [AlertUtil showSimpleAlertWithTitle:@"温馨提示" message:self.couponReasonArrayUnused[indexPath.section]];
            }
        }
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag3){
        [self.tableView3 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Network Request
-(void)sendCouponExchangeRequest:(NSString *)code{
    DLog(@"sendCouponExchangeRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:code forKey:@"code"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_COUPON_INFORAMTION_EXCHANGE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendCouponCheckRequest1{
    DLog(@"sendCouponCheckRequest1");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"0" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self couponCheckDataParse1];
        }else{
            DLog(@"%@",self.message1);
            [HudUtil showSimpleTextOnlyHUD:self.message1 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

-(void)sendCouponCheckRequest2{
    DLog(@"sendCouponCheckRequest2");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"2" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self couponCheckDataParse2];
        }else{
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

-(void)sendCouponCheckRequest3{
    DLog(@"sendCouponCheckRequest3");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"1" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self couponCheckDataParse3];
        }else{
            DLog(@"%@",self.message3);
            [HudUtil showSimpleTextOnlyHUD:self.message3 withDelaySeconds:kHud_DelayTime];
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)couponCheckDataParse1{
    self.couponArrayUnused = [CouponData mj_objectArrayWithKeyValuesArray:self.data1];
    for (CouponData *couponData in self.couponArrayUnused) {
        [self.couponIdArrayUnused addObject:[NullUtil judgeStringNull:couponData.conpouId]];
        [self.couponTypeArrayUnused addObject:[NullUtil judgeStringNull:couponData.TYPE]];
        [self.couponNameArrayUnused addObject:[NullUtil judgeStringNull:couponData.conpouName]];
        [self.couponDescriptionArrayUnused addObject:[NullUtil judgeStringNull:couponData.conpou_descr]];
        [self.couponMoneyArrayUnused addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.0f",couponData.conpou_money]]];
        [self.couponStatusArrayUnused addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)couponData.conpou_status]]];
        [self.couponDayArrayUnused addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%d",couponData.days]]];
        [self.couponMinMoneyArrayUnused addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%f",couponData.min_money]]];
        [self.couponReasonArrayUnused addObject:[NullUtil judgeStringNull:couponData.reason]];
        [self.couponRebateArrayUnused addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.2f",couponData.rebate]]];
        [self.couponEndArrayUnused addObject:[NullUtil judgeStringNull:couponData.valid_end]];
    }
    
    [self.tableView1 reloadData];
}

-(void)couponCheckDataParse2{
    self.couponArrayUsed = [CouponData mj_objectArrayWithKeyValuesArray:self.data2];
    for (CouponData *couponData in self.couponArrayUsed) {
        [self.couponIdArrayUsed addObject:[NullUtil judgeStringNull:couponData.conpouId]];
        [self.couponTypeArrayUsed addObject:[NullUtil judgeStringNull:couponData.TYPE]];
        [self.couponNameArrayUsed addObject:[NullUtil judgeStringNull:couponData.conpouName]];
        [self.couponDescriptionArrayUsed addObject:[NullUtil judgeStringNull:couponData.conpou_descr]];
        [self.couponMoneyArrayUsed addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.0f",couponData.conpou_money]]];
        [self.couponStatusArrayUsed addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)couponData.conpou_status]]];
        [self.couponDayArrayUsed addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%d",couponData.days]]];
        [self.couponMinMoneyArrayUsed addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%f",couponData.min_money]]];
        [self.couponReasonArrayUsed addObject:[NullUtil judgeStringNull:couponData.reason]];
        [self.couponRebateArrayUsed addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.2f",couponData.rebate]]];
        [self.couponEndArrayUsed addObject:[NullUtil judgeStringNull:couponData.valid_end]];
    }
    
    [self.tableView2 reloadData];
}

-(void)couponCheckDataParse3{
    self.couponArrayExpired = [CouponData mj_objectArrayWithKeyValuesArray:self.data3];
    for (CouponData *couponData in self.couponArrayExpired) {
        [self.couponIdArrayExpired addObject:[NullUtil judgeStringNull:couponData.conpouId]];
        [self.couponTypeArrayExpired addObject:[NullUtil judgeStringNull:couponData.TYPE]];
        [self.couponNameArrayExpired addObject:[NullUtil judgeStringNull:couponData.conpouName]];
        [self.couponDescriptionArrayExpired addObject:[NullUtil judgeStringNull:couponData.conpou_descr]];
        [self.couponMoneyArrayExpired addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.0f",couponData.conpou_money]]];
        [self.couponStatusArrayExpired addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)couponData.conpou_status]]];
        [self.couponDayArrayExpired addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%d",couponData.days]]];
        [self.couponMinMoneyArrayExpired addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%f",couponData.min_money]]];
        [self.couponReasonArrayExpired addObject:[NullUtil judgeStringNull:couponData.reason]];
        [self.couponRebateArrayExpired addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%.2f",couponData.rebate]]];
        [self.couponEndArrayExpired addObject:[NullUtil judgeStringNull:couponData.valid_end]];
    }
    
    [self.tableView3 reloadData];
}

@end
