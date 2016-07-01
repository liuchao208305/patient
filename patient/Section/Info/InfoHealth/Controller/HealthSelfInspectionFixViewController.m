//
//  HealthSelfInspectionFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthSelfInspectionFixViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "SelfInspectionOneTableCell.h"
#import "SelfInspectionTwoTableCell.h"
#import "SelfInspectionThreeTableCell.h"

@interface HealthSelfInspectionFixViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@property (assign,nonatomic)BOOL shuimianHideFlag;
@property (assign,nonatomic)BOOL yinshiHideFlag;
@property (assign,nonatomic)BOOL yinshuiHideFlag;
@property (assign,nonatomic)BOOL bianmiHideFlag;
@property (assign,nonatomic)BOOL xiexieHideFlag;
@property (assign,nonatomic)BOOL chengxingHideFlag;
@property (assign,nonatomic)BOOL bianzhiHideFlag;
@property (assign,nonatomic)BOOL paibianganHideFlag;
@property (assign,nonatomic)BOOL sezhiHideFlag;
@property (assign,nonatomic)BOOL painiaoganHideFlag;
@property (assign,nonatomic)BOOL tiwenHideFlag;
@property (assign,nonatomic)BOOL chuhanHideFlag;

@property (assign,nonatomic)BOOL juejingHideFlag;
@property (assign,nonatomic)BOOL bijingHideFlag;
@property (assign,nonatomic)BOOL jingliangHideFlag;
@property (assign,nonatomic)BOOL zhidiHideFlag;
@property (assign,nonatomic)BOOL qitajingHideFlag;

@end

@implementation HealthSelfInspectionFixViewController

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
    
    self.tiwenHideFlag = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [AnalyticUtil UMBeginLogPageView:@"HealthSelfInspectionViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthSelfInspectionViewController"];
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
    
    self.title = @"健康自查";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(submitButtonClicked)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)submitButtonClicked{
    DLog(@"submitButtonClicked");
}

-(void)shuimianSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.shuimianHideFlag = NO;
            break;
        case 1:
            self.shuimianHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yinshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yinshiHideFlag = NO;
            break;
        case 1:
            self.yinshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)yinshuiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.yinshuiHideFlag = NO;
            break;
        case 1:
            self.yinshuiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)bianmiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.bianmiHideFlag = YES;
            break;
        case 1:
            self.bianmiHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)xiexieSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.xiexieHideFlag = YES;
            break;
        case 1:
            self.xiexieHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)chengxingSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.chengxingHideFlag = YES;
            break;
        case 1:
            self.chengxingHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)bianzhiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.bianzhiHideFlag = NO;
            break;
        case 1:
            self.bianzhiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)paibianganSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.paibianganHideFlag = NO;
            break;
        case 1:
            self.paibianganHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)sezhiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.sezhiHideFlag = NO;
            break;
        case 1:
            self.sezhiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)painiaoganSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.painiaoganHideFlag = NO;
            break;
        case 1:
            self.painiaoganHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)tiwenSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.tiwenHideFlag = YES;
            break;
        case 1:
            self.tiwenHideFlag = NO;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)chuhanSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.chuhanHideFlag = NO;
            break;
        case 1:
            self.chuhanHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)buttonClicked:(UIButton *)sender{
    DLog(@"%ld",(long)sender.tag);
}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 32;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 107;
    }else if (indexPath.section == 1){
        if (self.shuimianHideFlag == NO) {
            return 150;
        }
    }else if (indexPath.section == 2){
        if (self.yinshiHideFlag == NO) {
            return 110;
        }
    }else if (indexPath.section == 3){
        if (self.yinshuiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 8){
        if (self.bianzhiHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 9){
        if (self.paibianganHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 10){
        return 100;
    }else if (indexPath.section == 12){
        if (self.sezhiHideFlag == NO) {
            return 110;
        }
    }else if (indexPath.section == 13){
        if (self.painiaoganHideFlag == NO) {
            return 60;
        }
    }else if (indexPath.section == 15){
        return 60;
    }else if (indexPath.section == 16){
        return 60;
    }else if (indexPath.section == 17){
        return 110;
    }else if (indexPath.section == 20){
        return 107;
    }else if (indexPath.section == 24){
        return 60;
    }else if (indexPath.section == 25){
        return 60;
    }else if (indexPath.section == 26){
        return 110;
    }else if (indexPath.section == 27){
        return 107;
    }else if (indexPath.section == 28){
        return 110;
    }else if (indexPath.section == 30){
        if (self.chuhanHideFlag == NO) {
            return 205;
        }
    }else if (indexPath.section == 31){
        return 210;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 0.01;
    }else if (section == 5){
        return 0.01;
    }else if (section == 6){
        return 0.01;
    }else if (section == 7){
        return 0.01;
    }else if (section == 8){
        return 0.01;
    }else if (section == 9){
        return 0.01;
    }else if (section == 11){
        return 0.01;
    }else if (section == 12){
        return 0.01;
    }else if (section == 14){
        return 0.01;
    }else if (section == 15){
        return 0.01;
    }else if (section == 16){
        return 0.01;
    }else if (section == 18){
        return 0.01;
    }else if (section == 19){
        return 0.01;
    }else if (section == 20){
        return 0.01;
    }else if (section == 21){
        return 0.01;
    }else if (section == 22){
        return 0.01;
    }else if (section == 23){
        return 0.01;
    }else if (section == 24){
        return 0.01;
    }else if (section == 25){
        return 0.01;
    }else if (section == 26){
        return 0.01;
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.selfInspectionHeaderView = [[SelfInspectionHeaderView alloc] init];
    if (section == 0) {
        NSString *title = @"主诉";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 1){
        NSString *title = @"睡眠";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.shuimianHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(shuimianSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    else if (section == 2){
        NSString *title = @"饮食";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yinshiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yinshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 3){
        NSString *title = @"饮水";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"口渴",@"不口渴",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.yinshuiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(yinshuiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 4){
        NSString *title = @"大便";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"每天";
        NSString *content2_2 = @"1";
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 5){
        NSString *title = @"便秘";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.bianmiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(bianmiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 6){
        NSString *title = @"泄泻";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.xiexieHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(xiexieSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 7){
        NSString *title = @"成形";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray leftHideFlag:self.chengxingHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chengxingSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 8){
        NSString *title = @"便质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.bianzhiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(bianzhiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 9){
        NSString *title = @"排便感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.paibianganHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(paibianganSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 10){
        NSString *title = @"大便颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 11){
        NSString *title = @"小便";
        NSString *content1_1 = @"白天";
        NSString *content1_2 = @"1";
        NSString *content1_3 = @"次";
        NSString *content2_1 = @"晚上";
        NSString *content2_2 = @"1";
        NSString *content2_3 = @"次";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 12){
        NSString *title = @"色质";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.sezhiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(sezhiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 13){
        NSString *title = @"排尿感";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.painiaoganHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(painiaoganSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 14){
        NSString *title = @"带下";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 15){
        NSString *title = @"气味";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 16){
        NSString *title = @"质地";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 17){
        NSString *title = @"颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 18){
        NSString *title = @"月经";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 19){
        NSString *title = @"绝经";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.juejingHideFlag];
    }else if (section == 20){
        NSString *title = @"闭经";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"是",@"否",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.bijingHideFlag];
    }else if (section == 21){
        NSString *title = @"初潮年龄";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"12";
        NSString *content2_3 = @"岁";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 22){
        NSString *title = @"月经周期";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"28";
        NSString *content2_3 = @"天";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 23){
        NSString *title = @"持续天数";
        NSString *content1_1 = @"";
        NSString *content1_2 = @"";
        NSString *content1_3 = @"";
        NSString *content2_1 = @"";
        NSString *content2_2 = @"12";
        NSString *content2_3 = @"天";
        [self.selfInspectionHeaderView initView:title content1_1:content1_1 content1_2:content1_2 content1_3:content1_3 content2_1:content2_1 content2_2:content2_2 content2_3:content2_3];
    }else if (section == 24){
        NSString *title = @"经量";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.jingliangHideFlag];
    }else if (section == 25){
        NSString *title = @"质地";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.zhidiHideFlag];
    }else if (section == 26){
        NSString *title = @"颜色";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 27){
        NSString *title = @"其他经行伴随症状";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.qitajingHideFlag];
    }else if (section == 28){
        NSString *title = @"寒热";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 29){
        NSString *title = @"体温";
        NSString *content = @"37";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未测",@"已测",nil];
        [self.selfInspectionHeaderView initView:title content:content array:segmentedArray hideFlag:self.tiwenHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(tiwenSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 30){
        NSString *title = @"出汗";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.chuhanHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chuhanSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 31){
        NSString *title = @"照片资料";
        NSString *titleFix = @"（请在自然光下拍摄哦）";
        [self.selfInspectionHeaderView initView:title titleFix:titleFix];
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SelfInspectionOneTableCell *cell = [[SelfInspectionOneTableCell alloc] init];;
        [cell initViewWithTextField:@"请输入患者主诉"];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"SelfInspectionTwoTableCell";
        SelfInspectionTwoTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionTwoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }else if (indexPath.section > 1){
        static NSString *cellName = @"SelfInspectionThreeTableCell";
        SelfInspectionThreeTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionThreeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        return cell;
    }
    return nil;
}

#pragma mark Network Request

#pragma mark Data Parse

@end
