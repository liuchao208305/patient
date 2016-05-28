//
//  OrderListViewController.m
//  patient
//
//  Created by ChaosLiu on 16/4/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "OrderListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "OrderListTableCell.h"
#import "OrderData.h"
#import "TreatmentDetailViewController.h"
#import "TreatmentFinishViewController.h"
#import "MedicineReceivingViewController.h"
#import "LoginViewController.h"
#import "RecordDetailViewController.h"

@interface OrderListViewController ()

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

@property (strong,nonatomic)NSMutableDictionary *result4;
@property (assign,nonatomic)NSInteger code4;
@property (strong,nonatomic)NSString *message4;
@property (strong,nonatomic)NSMutableArray *data4;
@property (assign,nonatomic)NSError *error4;

@property (strong,nonatomic)NSMutableDictionary *result5;
@property (assign,nonatomic)NSInteger code5;
@property (strong,nonatomic)NSString *message5;
@property (strong,nonatomic)NSMutableArray *data5;
@property (assign,nonatomic)NSError *error5;

@property (assign,nonatomic)NSInteger currentPage1;
@property (assign,nonatomic)NSInteger pageSize1;

@property (assign,nonatomic)NSInteger currentPage2;
@property (assign,nonatomic)NSInteger pageSize2;

@property (assign,nonatomic)NSInteger currentPage3;
@property (assign,nonatomic)NSInteger pageSize3;

@property (assign,nonatomic)NSInteger currentPage4;
@property (assign,nonatomic)NSInteger pageSize4;

@property (assign,nonatomic)NSInteger currentPage5;
@property (assign,nonatomic)NSInteger pageSize5;

@end

@implementation OrderListViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView:self.orderType];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"OrderListViewController"];
    
    self.navigationController.navigationBar.hidden = NO;

    if (self.orderType == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView1];
        [self sendOrderListRequest1];
    }else if (self.orderType == 1){
        self.flag1 = NO;
        self.flag2 = YES;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView2];
        [self sendOrderListRequest2];
    }else if (self.orderType == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        self.flag4 = NO;
        self.flag5 = NO;
        
        [self initSubView3];
        [self sendOrderListRequest3];
    }else if (self.orderType == 3){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = YES;
        self.flag5 = NO;
        
        [self initSubView4];
        [self sendOrderListRequest4];
    }else if (self.orderType == 4){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = YES;
        
        [self initSubView5];
        [self sendOrderListRequest5];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"OrderListViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.orderArrayAll = [NSMutableArray array];
    self.orderIdArrayAll = [NSMutableArray array];
    self.orderStatusArrayAll = [NSMutableArray array];
    self.orderCreatTimeArrayAll = [NSMutableArray array];
    self.orderBookTimeArrayAll = [NSMutableArray array];
    self.orderMoneyArrayAll = [NSMutableArray array];
    self.orderExpertIdArrayAll = [NSMutableArray array];
    self.orderExpertNameArrayAll = [NSMutableArray array];
    self.orderExpertImageArrayAll = [NSMutableArray array];
    self.orderClinicNameArrayAll = [NSMutableArray array];
    self.orderClinicAddressArrayAll = [NSMutableArray array];
    self.orderDoctorIdArrayAll = [NSMutableArray array];
    self.orderDoctorNameArrayAll = [NSMutableArray array];
    self.orderDoctorImageArrayAll = [NSMutableArray array];
    self.orderPatientIdArrayAll = [NSMutableArray array];
    self.orderPatientNameArrayAll = [NSMutableArray array];
    
    self.orderPayIdArrayAll = [NSMutableArray array];
    self.orderPayStatusArrayAll = [NSMutableArray array];
    
    self.orderArrayBooked = [NSMutableArray array];
    self.orderIdArrayBooked = [NSMutableArray array];
    self.orderStatusArrayBooked = [NSMutableArray array];
    self.orderCreatTimeArrayBooked = [NSMutableArray array];
    self.orderBookTimeArrayBooked = [NSMutableArray array];
    self.orderMoneyArrayBooked = [NSMutableArray array];
    self.orderExpertIdArrayBooked = [NSMutableArray array];
    self.orderExpertNameArrayBooked = [NSMutableArray array];
    self.orderExpertImageArrayBooked = [NSMutableArray array];
    self.orderClinicNameArrayBooked = [NSMutableArray array];
    self.orderClinicAddressArrayBooked = [NSMutableArray array];
    self.orderDoctorIdArrayBooked = [NSMutableArray array];
    self.orderDoctorNameArrayBooked = [NSMutableArray array];
    self.orderDoctorImageArrayBooked = [NSMutableArray array];
    self.orderPatientIdArrayBooked = [NSMutableArray array];
    self.orderPatientNameArrayBooked = [NSMutableArray array];
    
    self.orderPayIdArrayBooked = [NSMutableArray array];
    self.orderPayStatusArrayBooked = [NSMutableArray array];
    
    self.orderArrayProceeding = [NSMutableArray array];
    self.orderIdArrayProceeding = [NSMutableArray array];
    self.orderStatusArrayProceeding = [NSMutableArray array];
    self.orderCreatTimeArrayProceeding = [NSMutableArray array];
    self.orderBookTimeArrayProceeding = [NSMutableArray array];
    self.orderMoneyArrayProceeding = [NSMutableArray array];
    self.orderExpertIdArrayProceeding = [NSMutableArray array];
    self.orderExpertNameArrayProceeding = [NSMutableArray array];
    self.orderExpertImageArrayProceeding = [NSMutableArray array];
    self.orderClinicNameArrayProceeding = [NSMutableArray array];
    self.orderClinicAddressArrayProceeding = [NSMutableArray array];
    self.orderDoctorIdArrayProceeding = [NSMutableArray array];
    self.orderDoctorNameArrayProceeding = [NSMutableArray array];
    self.orderDoctorImageArrayProceeding = [NSMutableArray array];
    self.orderPatientIdArrayProceeding = [NSMutableArray array];
    self.orderPatientNameArrayProceeding = [NSMutableArray array];
    
    self.orderPayIdArrayProceeding = [NSMutableArray array];
    self.orderPayStatusArrayProceeding = [NSMutableArray array];
    
    self.orderArrayCompleted = [NSMutableArray array];
    self.orderIdArrayCompleted = [NSMutableArray array];
    self.orderStatusArrayCompleted = [NSMutableArray array];
    self.orderCreatTimeArrayCompleted = [NSMutableArray array];
    self.orderBookTimeArrayCompleted = [NSMutableArray array];
    self.orderMoneyArrayCompleted = [NSMutableArray array];
    self.orderExpertIdArrayCompleted = [NSMutableArray array];
    self.orderExpertNameArrayCompleted = [NSMutableArray array];
    self.orderExpertImageArrayCompleted = [NSMutableArray array];
    self.orderClinicNameArrayCompleted = [NSMutableArray array];
    self.orderClinicAddressArrayCompleted = [NSMutableArray array];
    self.orderDoctorIdArrayCompleted = [NSMutableArray array];
    self.orderDoctorNameArrayCompleted = [NSMutableArray array];
    self.orderDoctorImageArrayCompleted = [NSMutableArray array];
    self.orderPatientIdArrayCompleted = [NSMutableArray array];
    self.orderPatientNameArrayCompleted = [NSMutableArray array];
    
    self.orderPayIdArrayCompleted = [NSMutableArray array];
    self.orderPayStatusArrayCompleted = [NSMutableArray array];
    
    self.orderArrayEvaluating = [NSMutableArray array];
    self.orderIdArrayEvaluating = [NSMutableArray array];
    self.orderStatusArrayEvaluating = [NSMutableArray array];
    self.orderCreatTimeArrayEvaluating = [NSMutableArray array];
    self.orderBookTimeArrayEvaluating = [NSMutableArray array];
    self.orderMoneyArrayEvaluating = [NSMutableArray array];
    self.orderExpertIdArrayEvaluating = [NSMutableArray array];
    self.orderExpertNameArrayEvaluating = [NSMutableArray array];
    self.orderExpertImageArrayEvaluating = [NSMutableArray array];
    self.orderClinicNameArrayEvaluating = [NSMutableArray array];
    self.orderClinicAddressArrayEvaluating = [NSMutableArray array];
    self.orderDoctorIdArrayEvaluating = [NSMutableArray array];
    self.orderDoctorNameArrayEvaluating = [NSMutableArray array];
    self.orderDoctorImageArrayEvaluating = [NSMutableArray array];
    self.orderPatientIdArrayEvaluating = [NSMutableArray array];
    self.orderPatientNameArrayEvaluating = [NSMutableArray array];
    
    self.orderPayIdArrayEvaluating = [NSMutableArray array];
    self.orderPayStatusArrayEvaluating = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = @"订单列表";
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title=@"订单列表";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView:(NSInteger)number{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"全部", @"已预约", @"进行中",@"待评价",@"已完成",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:kBACKGROUND_COLOR titleColor:kLIGHT_GRAY_COLOR titleFont:[UIFont systemFontOfSize:14] selectColor:kBLACK_COLOR buttonDownColor:kMAIN_COLOR Delegate:self selectSeugment:number];
    
    [self.view addSubview:self.segmentControl];
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = YES;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView1.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendOrderListRequest1];
    }];
    
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendOrderListRequest1];
    }];
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = YES;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView2.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendOrderListRequest2];
    }];
    
    self.tableView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendOrderListRequest2];
    }];
    
    [self.view addSubview:self.tableView2];
}

-(void)initSubView3{
    self.tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView3.delegate = self;
    self.tableView3.dataSource = self;
    self.tableView3.showsVerticalScrollIndicator = YES;
    self.tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView3.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendOrderListRequest3];
    }];
    
    self.tableView3.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendOrderListRequest3];
    }];
    
    [self.view addSubview:self.tableView3];
}

-(void)initSubView4{
    self.tableView4 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView4.delegate = self;
    self.tableView4.dataSource = self;
    self.tableView4.showsVerticalScrollIndicator = YES;
    self.tableView4.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView4.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendOrderListRequest4];
    }];
    
    self.tableView4.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendOrderListRequest4];
    }];
    
    [self.view addSubview:self.tableView4];
}

-(void)initSubView5{
    self.tableView5 = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, SCREEN_HEIGHT-42-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView5.delegate = self;
    self.tableView5.dataSource = self;
    self.tableView5.showsVerticalScrollIndicator = YES;
    self.tableView5.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView5.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendOrderListRequest5];
    }];
    
    self.tableView5.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendOrderListRequest5];
    }];
    
    [self.view addSubview:self.tableView5];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)allButtonClicked:(UIButton *)sender{
    DLog(@"allButtonClicked");
    DLog(@"%ld",(long)sender.tag);
    DLog(@"%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"立即支付"]) {
        TreatmentDetailViewController *detaiVC = [[TreatmentDetailViewController alloc] init];
        detaiVC.isFromOrderListVC = YES;
        detaiVC.orderNumber = self.orderPayIdArrayAll[sender.tag-10000];
        [self.navigationController pushViewController:detaiVC animated:YES];
    }else{
        MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        medicineVC.orderNumber = self.orderIdArrayAll[sender.tag-10000];
        [self.navigationController pushViewController:medicineVC animated:YES];
    }
}

-(void)bookedButtonClicked:(UIButton *)sender{
    DLog(@"bookedButtonClicked");
    DLog(@"%ld",(long)sender.tag);
    TreatmentDetailViewController *detaiVC = [[TreatmentDetailViewController alloc] init];
    detaiVC.isFromOrderListVC = YES;
    detaiVC.orderNumber = self.orderPayIdArrayBooked[sender.tag-20000];
    [self.navigationController pushViewController:detaiVC animated:YES];
}

-(void)proceedingButtonClicked{
    DLog(@"proceedingButtonClicked");
}

-(void)evaluatingButtonClicked:(UIButton *)sender{
    DLog(@"evaluatingButtonClicked");
    DLog(@"%ld",(long)sender.tag);
    MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
    medicineVC.orderNumber = self.orderIdArrayEvaluating[sender.tag-40000];
    [self.navigationController pushViewController:medicineVC animated:YES];
}

-(void)completedButtonClicked{
    DLog(@"completedButtonClicked");
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.orderArrayAll.count == 0 ? 0 : self.orderArrayAll.count;
    }else if (self.flag2){
        return self.orderArrayBooked.count == 0 ? 0 : self.orderArrayBooked.count;
    }else if (self.flag3){
        return self.orderArrayProceeding.count == 0 ? 0 : self.orderArrayProceeding.count;
    }else if (self.flag4){
        return self.orderArrayEvaluating.count == 0 ? 0 : self.orderArrayEvaluating.count;
    }else if (self.flag5){
        return self.orderArrayCompleted.count == 0 ? 0 : self.orderArrayCompleted.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        if ([self.orderPayStatusArrayAll[indexPath.section] integerValue] == 1 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 2 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 3 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 4 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 6) {
            return 135;
        }else{
            return 195;
        }
    }else if (self.flag2){
        if ([self.orderPayStatusArrayBooked[indexPath.section] integerValue] == 0) {
            return 195;
        }else if ([self.orderPayStatusArrayBooked[indexPath.section] integerValue] == 1){
            return 135;
        }
    }else if (self.flag3){
        return 135;
    }else if (self.flag4){
        return 195;
    }else if (self.flag5){
        return 135;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"OrderListTableCell";
    OrderListTableCell *cell = [self.tableView1 dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[OrderListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (self.flag1) {
        cell.label1_1.text = self.orderPatientNameArrayAll[indexPath.section];
        cell.label1_2.text = self.orderBookTimeArrayAll[indexPath.section];
        
        if ([self.orderStatusArrayAll[indexPath.section] integerValue] == 1){
            if ([self.orderPayStatusArrayAll[indexPath.section] integerValue] == 0) {
                cell.label1_3.text = @"未支付";
                cell.button.tag = 10000+indexPath.section;
                [cell.button setTitle:@"立即支付" forState:UIControlStateNormal];
                [cell.button addTarget:self action:@selector(allButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }else if ([self.orderPayStatusArrayAll[indexPath.section] integerValue] == 1){
                cell.label1_3.text = @"已支付";
                cell.lineView2.hidden = YES;
                cell.button.hidden = YES;
            }
        }else if ([self.orderStatusArrayAll[indexPath.section] integerValue] == 2 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 3 || [self.orderStatusArrayAll[indexPath.section] integerValue] == 4){
            cell.label1_3.text = @"进行中";
            
            cell.lineView2.hidden = YES;
            cell.button.hidden = YES;
        }else if ([self.orderStatusArrayAll[indexPath.section] integerValue] == 5){
            cell.label1_3.text = @"待评价";
            [cell.button setTitle:@"立即评价" forState:UIControlStateNormal];
        }else if ([self.orderStatusArrayAll[indexPath.section] integerValue] == 6){
            cell.label1_3.text = @"已完成";
            
            cell.lineView2.hidden = YES;
            cell.button.hidden = YES;
        }
        
        cell.label2_1.text = [self.orderCreatTimeArrayAll[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.orderCreatTimeArrayAll[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.orderCreatTimeArrayAll[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.orderExpertImageArrayAll[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayAll[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.orderExpertNameArrayAll[indexPath.section];
        cell.label2_8.text = self.orderDoctorNameArrayAll[indexPath.section];
        cell.label2_9.text = self.orderClinicNameArrayAll[indexPath.section];
        
        cell.label2_10.text = [NSString stringWithFormat:@"¥ %@",self.orderMoneyArrayAll[indexPath.section]];
        
    }else if (self.flag2){
        cell.label1_1.text = self.orderPatientNameArrayBooked[indexPath.section];
        cell.label1_2.text = self.orderBookTimeArrayBooked[indexPath.section];
        
        if ([self.orderPayStatusArrayBooked[indexPath.section] integerValue] == 0) {
            cell.label1_3.text = @"未支付";
            cell.button.tag = 20000+indexPath.section;
            [cell.button setTitle:@"立即支付" forState:UIControlStateNormal];
            [cell.button addTarget:self action:@selector(bookedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([self.orderPayStatusArrayBooked[indexPath.section] integerValue] == 1){
            cell.label1_3.text = @"已支付";
            cell.lineView2.hidden = YES;
            cell.button.hidden = YES;
        }
        
        cell.label2_1.text = [self.orderCreatTimeArrayBooked[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.orderCreatTimeArrayBooked[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.orderCreatTimeArrayBooked[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.orderExpertImageArrayBooked[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayBooked[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.orderExpertNameArrayBooked[indexPath.section];
        cell.label2_8.text = self.orderDoctorNameArrayBooked[indexPath.section];
        cell.label2_9.text = self.orderClinicNameArrayBooked[indexPath.section];
        
        cell.label2_10.text = [NSString stringWithFormat:@"¥ %@",self.orderMoneyArrayBooked[indexPath.section]];
    }else if (self.flag3){
        cell.label1_1.text = self.orderPatientNameArrayProceeding[indexPath.section];
        cell.label1_2.text = self.orderBookTimeArrayProceeding[indexPath.section];
        
        cell.label1_3.text = @"进行中";
        cell.lineView2.hidden = YES;
        cell.button.hidden = YES;
        
        if (![self.orderCreatTimeArrayProceeding[indexPath.section] isEqualToString:@""]) {
            cell.label2_1.text = [self.orderCreatTimeArrayProceeding[indexPath.section] substringToIndex:4];
            cell.label2_2.text = [self.orderCreatTimeArrayProceeding[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
            cell.label2_3.text = [self.orderCreatTimeArrayProceeding[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        }
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.orderExpertImageArrayProceeding[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayProceeding[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.orderExpertNameArrayProceeding[indexPath.section];
        cell.label2_8.text = self.orderDoctorNameArrayProceeding[indexPath.section];
        cell.label2_9.text = self.orderClinicNameArrayProceeding[indexPath.section];
        
        cell.label2_10.text = [NSString stringWithFormat:@"¥ %@",self.orderMoneyArrayProceeding[indexPath.section]];
    }else if (self.flag4){
        cell.label1_1.text = self.orderPatientNameArrayEvaluating[indexPath.section];
        cell.label1_2.text = self.orderBookTimeArrayEvaluating[indexPath.section];
        
        cell.label1_3.text = @"待评价";
        cell.button.tag = 40000+indexPath.section;
        [cell.button setTitle:@"立即评价" forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(evaluatingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.label2_1.text = [self.orderCreatTimeArrayEvaluating[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.orderCreatTimeArrayEvaluating[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.orderCreatTimeArrayEvaluating[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.orderExpertImageArrayEvaluating[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayEvaluating[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.orderExpertNameArrayEvaluating[indexPath.section];
        cell.label2_8.text = self.orderDoctorNameArrayEvaluating[indexPath.section];
        cell.label2_9.text = self.orderClinicNameArrayEvaluating[indexPath.section];
        
        cell.label2_10.text = [NSString stringWithFormat:@"¥ %@",self.orderMoneyArrayEvaluating[indexPath.section]];
    }else if (self.flag5){
        cell.label1_1.text = self.orderPatientNameArrayCompleted[indexPath.section];
        cell.label1_2.text = self.orderBookTimeArrayCompleted[indexPath.section];
        
        cell.label1_3.text = @"已完成";
        cell.lineView2.hidden = YES;
        cell.button.hidden = YES;
        
        cell.label2_1.text = [self.orderCreatTimeArrayCompleted[indexPath.section] substringToIndex:4];
        cell.label2_2.text = [self.orderCreatTimeArrayCompleted[indexPath.section] substringWithRange:NSMakeRange(5, 5)];
        cell.label2_3.text = [self.orderCreatTimeArrayCompleted[indexPath.section] substringWithRange:NSMakeRange(11, 5)];
        
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.orderExpertImageArrayCompleted[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.orderDoctorImageArrayCompleted[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        
        cell.label2_7.text = self.orderExpertNameArrayCompleted[indexPath.section];
        cell.label2_8.text = self.orderDoctorNameArrayCompleted[indexPath.section];
        cell.label2_9.text = self.orderClinicNameArrayCompleted[indexPath.section];
        
        cell.label2_10.text = [NSString stringWithFormat:@"¥ %@",self.orderMoneyArrayCompleted[indexPath.section]];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
#warning 跳转回来，页面重新初始化，触发不了此方法
        TreatmentDetailViewController *detaiVC = [[TreatmentDetailViewController alloc] init];
        detaiVC.isFromOrderListVC = YES;
        detaiVC.orderNumber = self.orderPayIdArrayBooked[indexPath.section];
        [self.navigationController pushViewController:detaiVC animated:YES];

        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag3){
        
        
        [self.tableView3 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag4){
        MedicineReceivingViewController *medicineVC = [[MedicineReceivingViewController alloc] init];
        medicineVC.orderNumber = self.orderIdArrayEvaluating[indexPath.section];
        [self.navigationController pushViewController:medicineVC animated:YES];
        
//        RecordDetailViewController *recordDetailVC = [[RecordDetailViewController alloc] init];
//        recordDetailVC.orderNumber = self.orderIdArrayEvaluating[indexPath.section];
//        [self.navigationController pushViewController:recordDetailVC animated:YES];
        
        [self.tableView4 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag5){
        
        
        [self.tableView5 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        self.flag1 = YES;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendOrderListRequest1];
        [self initSubView1];
    }else if (selection == 1){
        self.flag1 = NO;
        self.flag2 = YES;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendOrderListRequest2];
        [self initSubView2];
    }else if (selection == 2){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = YES;
        self.flag4 = NO;
        self.flag5 = NO;
        [self sendOrderListRequest3];
        [self initSubView3];
    }else if (selection == 3){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = YES;
        self.flag5 = NO;
        [self sendOrderListRequest4];
        [self initSubView4];
    }else if (selection == 4){
        self.flag1 = NO;
        self.flag2 = NO;
        self.flag3 = NO;
        self.flag4 = NO;
        self.flag5 = YES;
        [self sendOrderListRequest5];
        [self initSubView5];
    }
}

#pragma mark Network Request
-(void)sendOrderListRequest1{
    DLog(@"sendOrderListRequest1");
    
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self orderListDataParse1];
        }else{
            DLog(@"%@",self.message1);
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

-(void)sendOrderListRequest2{
    DLog(@"sendOrderListRequest2");
    
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"1" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self orderListDataParse2];
        }else{
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

-(void)sendOrderListRequest3{
    DLog(@"sendOrderListRequest3");
    
    self.pageSize3 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"2" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize3] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            [self orderListDataParse3];
        }else{
            DLog(@"%@",self.message3);
            if (self.code3 == kTOKENINVALID) {
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

-(void)sendOrderListRequest4{
    DLog(@"sendOrderListRequest4");
    
    self.pageSize4 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"5" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize4] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result4 = (NSMutableDictionary *)responseObject;
        
        self.code4 = [[self.result4 objectForKey:@"code"] integerValue];
        self.message4 = [self.result4 objectForKey:@"message"];
        self.data4 = [self.result4 objectForKey:@"data"];
        
        if (self.code4 == kSUCCESS) {
            [self orderListDataParse4];
        }else{
            DLog(@"%@",self.message4);
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

-(void)sendOrderListRequest5{
    DLog(@"sendOrderListRequest5");
    
    self.pageSize5 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:@"6" forKey:@"type"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize5] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_ORDER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result5 = (NSMutableDictionary *)responseObject;
        
        self.code5 = [[self.result5 objectForKey:@"code"] integerValue];
        self.message5 = [self.result5 objectForKey:@"message"];
        self.data5 = [self.result5 objectForKey:@"data"];
        
        if (self.code5 == kSUCCESS) {
            [self orderListDataParse5];
        }else{
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
-(void)orderListDataParse1{
    DLog(@"orderListDataParse1");
    self.orderArrayAll = [OrderData mj_objectArrayWithKeyValuesArray:self.data1];
    for (OrderData *orderData in self.orderArrayAll) {
        [self.orderIdArrayAll addObject:[NullUtil judgeStringNull:orderData.consult_id]];
        [self.orderStatusArrayAll addObject:[NSString stringWithFormat:@"%ld",(long)orderData.status]];
        [self.orderCreatTimeArrayAll addObject:[NullUtil judgeStringNull:orderData.create_date]];
        [self.orderBookTimeArrayAll addObject:[NullUtil judgeStringNull:orderData.bespoke_date]];
        [self.orderMoneyArrayAll addObject:[NSString stringWithFormat:@"%.2f",orderData.price]];
        [self.orderExpertIdArrayAll addObject:[NullUtil judgeStringNull:orderData.max_doctor_id]];
        [self.orderExpertNameArrayAll addObject:[NullUtil judgeStringNull:orderData.maxDoctorName]];
        [self.orderExpertImageArrayAll addObject:[NullUtil judgeStringNull:orderData.maxHeand]];
        [self.orderClinicNameArrayAll addObject:[NullUtil judgeStringNull:orderData.outpat_name]];
        [self.orderClinicAddressArrayAll addObject:[NullUtil judgeStringNull:orderData.address]];
        [self.orderDoctorIdArrayAll addObject:[NullUtil judgeStringNull:orderData.min_doctor_id]];
        [self.orderDoctorNameArrayAll addObject:[NullUtil judgeStringNull:orderData.minDoctorName]];
        [self.orderDoctorImageArrayAll addObject:[NullUtil judgeStringNull:orderData.minHeand]];
        [self.orderPatientNameArrayAll addObject:[NullUtil judgeStringNull:orderData.userName]];
        
        [self.orderPayIdArrayAll addObject:[NullUtil judgeStringNull:orderData.order_no]];
        [self.orderPayStatusArrayAll addObject:[NSString stringWithFormat:@"%ld",(long)orderData.pay_status]];
    }
    
    [self.tableView1 reloadData];
    
    [self.tableView1.mj_header endRefreshing];
    [self.tableView1.mj_footer endRefreshing];
}

-(void)orderListDataParse2{
    DLog(@"orderListDataParse2");
    self.orderArrayBooked = [OrderData mj_objectArrayWithKeyValuesArray:self.data2];
    for (OrderData *orderData in self.orderArrayBooked) {
        [self.orderIdArrayBooked addObject:[NullUtil judgeStringNull:orderData.consult_id]];
        [self.orderStatusArrayBooked addObject:[NSString stringWithFormat:@"%ld",(long)orderData.status]];
        [self.orderCreatTimeArrayBooked addObject:[NullUtil judgeStringNull:orderData.create_date]];
        [self.orderBookTimeArrayBooked addObject:[NullUtil judgeStringNull:orderData.bespoke_date]];
        [self.orderMoneyArrayBooked addObject:[NSString stringWithFormat:@"%.2f",orderData.price]];
        [self.orderExpertIdArrayBooked addObject:[NullUtil judgeStringNull:orderData.max_doctor_id]];
        [self.orderExpertNameArrayBooked addObject:[NullUtil judgeStringNull:orderData.maxDoctorName]];
        [self.orderExpertImageArrayBooked addObject:[NullUtil judgeStringNull:orderData.maxHeand]];
        [self.orderClinicNameArrayBooked addObject:[NullUtil judgeStringNull:orderData.outpat_name]];
        [self.orderClinicAddressArrayBooked addObject:[NullUtil judgeStringNull:orderData.address]];
        [self.orderDoctorIdArrayBooked addObject:[NullUtil judgeStringNull:orderData.min_doctor_id]];
        [self.orderDoctorNameArrayBooked addObject:[NullUtil judgeStringNull:orderData.minDoctorName]];
        [self.orderDoctorImageArrayBooked addObject:[NullUtil judgeStringNull:orderData.minHeand]];
        [self.orderPatientNameArrayBooked addObject:[NullUtil judgeStringNull:orderData.userName]];
        
        [self.orderPayIdArrayBooked addObject:[NullUtil judgeStringNull:orderData.order_no]];
        [self.orderPayStatusArrayBooked addObject:[NSString stringWithFormat:@"%ld",(long)orderData.pay_status]];
    }
    
    [self.tableView2 reloadData];
    
    [self.tableView2.mj_header endRefreshing];
    [self.tableView2.mj_footer endRefreshing];
}

-(void)orderListDataParse3{
    DLog(@"orderListDataParse3");
    self.orderArrayProceeding = [OrderData mj_objectArrayWithKeyValuesArray:self.data3];
    for (OrderData *orderData in self.orderArrayProceeding ) {
        [self.orderIdArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.consult_id]];
        [self.orderStatusArrayProceeding  addObject:[NSString stringWithFormat:@"%ld",(long)orderData.status]];
        [self.orderCreatTimeArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.create_date]];
        [self.orderBookTimeArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.bespoke_date]];
        [self.orderMoneyArrayProceeding  addObject:[NSString stringWithFormat:@"%.2f",orderData.price]];
        [self.orderExpertIdArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.max_doctor_id]];
        [self.orderExpertNameArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.maxDoctorName]];
        [self.orderExpertImageArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.maxHeand]];
        [self.orderClinicNameArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.outpat_name]];
        [self.orderClinicAddressArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.address]];
        [self.orderDoctorIdArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.min_doctor_id]];
        [self.orderDoctorNameArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.minDoctorName]];
        [self.orderDoctorImageArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.minHeand]];
        [self.orderPatientNameArrayProceeding  addObject:[NullUtil judgeStringNull:orderData.userName]];
        
        [self.orderPayIdArrayProceeding addObject:[NullUtil judgeStringNull:orderData.order_no]];
        [self.orderPayStatusArrayProceeding addObject:[NSString stringWithFormat:@"%ld",(long)orderData.pay_status]];
    }
    
    [self.tableView3 reloadData];
    
    [self.tableView3.mj_header endRefreshing];
    [self.tableView3.mj_footer endRefreshing];
}

-(void)orderListDataParse4{
    DLog(@"orderListDataParse4");
    self.orderArrayEvaluating = [OrderData mj_objectArrayWithKeyValuesArray:self.data4];
    for (OrderData *orderData in self.orderArrayEvaluating) {
        [self.orderIdArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.consult_id]];
        [self.orderStatusArrayEvaluating addObject:[NSString stringWithFormat:@"%ld",(long)orderData.status]];
        [self.orderCreatTimeArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.create_date]];
        [self.orderBookTimeArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.bespoke_date]];
        [self.orderMoneyArrayEvaluating addObject:[NSString stringWithFormat:@"%.2f",orderData.price]];
        [self.orderExpertIdArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.max_doctor_id]];
        [self.orderExpertNameArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.maxDoctorName]];
        [self.orderExpertImageArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.maxHeand]];
        [self.orderClinicNameArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.outpat_name]];
        [self.orderClinicAddressArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.address]];
        [self.orderDoctorIdArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.min_doctor_id]];
        [self.orderDoctorNameArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.minDoctorName]];
        [self.orderDoctorImageArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.minHeand]];
        [self.orderPatientNameArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.userName]];
        
        [self.orderPayIdArrayEvaluating addObject:[NullUtil judgeStringNull:orderData.order_no]];
        [self.orderPayStatusArrayEvaluating addObject:[NSString stringWithFormat:@"%ld",(long)orderData.pay_status]];
    }
    
    [self.tableView4 reloadData];
    
    [self.tableView4.mj_header endRefreshing];
    [self.tableView4.mj_footer endRefreshing];
}

-(void)orderListDataParse5{
    DLog(@"orderListDataParse5");
    self.orderArrayCompleted = [OrderData mj_objectArrayWithKeyValuesArray:self.data5];
    for (OrderData *orderData in self.orderArrayCompleted) {
        [self.orderIdArrayCompleted addObject:[NullUtil judgeStringNull:orderData.consult_id]];
        [self.orderStatusArrayCompleted addObject:[NSString stringWithFormat:@"%ld",(long)orderData.status]];
        [self.orderCreatTimeArrayCompleted addObject:[NullUtil judgeStringNull:orderData.create_date]];
        [self.orderBookTimeArrayCompleted addObject:[NullUtil judgeStringNull:orderData.bespoke_date]];
        [self.orderMoneyArrayCompleted addObject:[NSString stringWithFormat:@"%.2f",orderData.price]];
        [self.orderExpertIdArrayCompleted addObject:[NullUtil judgeStringNull:orderData.max_doctor_id]];
        [self.orderExpertNameArrayCompleted addObject:[NullUtil judgeStringNull:orderData.maxDoctorName]];
        [self.orderExpertImageArrayCompleted addObject:[NullUtil judgeStringNull:orderData.maxHeand]];
        [self.orderClinicNameArrayCompleted addObject:[NullUtil judgeStringNull:orderData.outpat_name]];
        [self.orderClinicAddressArrayCompleted addObject:[NullUtil judgeStringNull:orderData.address]];
        [self.orderDoctorIdArrayCompleted addObject:[NullUtil judgeStringNull:orderData.min_doctor_id]];
        [self.orderDoctorNameArrayCompleted addObject:[NullUtil judgeStringNull:orderData.minDoctorName]];
        [self.orderDoctorImageArrayCompleted addObject:[NullUtil judgeStringNull:orderData.minHeand]];
        [self.orderPatientNameArrayCompleted addObject:[NullUtil judgeStringNull:orderData.userName]];
        
        [self.orderPayIdArrayCompleted addObject:[NullUtil judgeStringNull:orderData.order_no]];
        [self.orderPayStatusArrayCompleted addObject:[NSString stringWithFormat:@"%ld",(long)orderData.pay_status]];
    }
    
    [self.tableView5 reloadData];
    
    [self.tableView5.mj_header endRefreshing];
    [self.tableView5.mj_footer endRefreshing];
}

@end
