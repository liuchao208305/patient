//
//  HealthSelfInspectionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthSelfInspectionViewController.h"
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
#import "SelfInspectionFourTableCell.h"
#import "SelfInspectionFiveTableCell.h"

@interface HealthSelfInspectionViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@end

@implementation HealthSelfInspectionViewController

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
    return 18;
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
    }else if (indexPath.section == 14){
        return 110;
    }else if (indexPath.section == 16){
        if (self.chuhanHideFlag == NO) {
            return 205;
        }
    }else if (indexPath.section == 17){
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
        NSString *title = @"寒热";
        [self.selfInspectionHeaderView initView:title];
    }else if (section == 15){
        NSString *title = @"体温";
        NSString *content = @"37";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"未测",@"已测",nil];
        [self.selfInspectionHeaderView initView:title content:content array:segmentedArray hideFlag:self.tiwenHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(tiwenSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 16){
        NSString *title = @"出汗";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.chuhanHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(chuhanSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 17){
        NSString *title = @"照片资料";
        NSString *titleFix = @"（请在自然光下拍摄哦）";
        [self.selfInspectionHeaderView initView:title titleFix:titleFix];
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SelfInspectionOneTableCell *cell = [[SelfInspectionOneTableCell alloc] init];;
        [cell initViewWithTextField];
        
        return cell;
    }else if (indexPath.section == 1){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.shuimianHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
           [cell initView:6 string1:@"不易入睡" string2:@"睡而复醒，难以复睡" string3:@"时时惊醒，睡不安宁" string4:@"彻夜不眠" string5:@"多梦" string6:@"瞌睡"];
        }
        return cell;
    }else if (indexPath.section == 2){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.yinshiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            [cell initView:4 string1:@"食欲不佳" string2:@"厌食" string3:@"多食易饥" string4:@"饥不择食" string5:@"" string6:@""];
        }
        return cell;
    }else if (indexPath.section == 3){
        SelfInspectionTwoTableCell *cell = [[SelfInspectionTwoTableCell alloc] init];
        if (self.yinshuiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
        }else{
            [cell initView:2 string1:@"口渴多饮" string2:@"渴不多饮" string3:@"" string4:@"" string5:@"" string6:@""];
        }
        return cell;
    }else if (indexPath.section == 8){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.bianmiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"软" string2:@"干硬" string3:@"稀" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
        return cell;
    }else if (indexPath.section == 9){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.paibianganHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"排便不爽" string2:@"滑泄失禁" string3:@"肛门重坠" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
        return cell;
    }else if (indexPath.section == 12){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.sezhiHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:5 string1:@"色清量多" string2:@"色黄短少" string3:@"尿中带血" string4:@"浑浊" string5:@"夹有砂石" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
        return cell;
    }else if (indexPath.section == 13){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.painiaoganHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:3 string1:@"小便失禁" string2:@"小便涩痛" string3:@"尿后点滴不尽" string4:@"" string5:@"" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        }
        return cell;
    }else if (indexPath.section == 14){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        [cell initView:5 string1:@"恶风" string2:@"恶寒" string3:@"畏寒" string4:@"发热" string5:@"潮热" string6:@"" string7:@"" string8:@"" string9:@"" string10:@"" string11:@""];
        return cell;
    }else if (indexPath.section == 16){
        SelfInspectionThreeTableCell *cell = [[SelfInspectionThreeTableCell alloc] init];
        if (self.chuhanHideFlag == YES) {
            cell.button1.hidden = YES;
            cell.button2.hidden = YES;
            cell.button3.hidden = YES;
            cell.button4.hidden = YES;
            cell.button5.hidden = YES;
            cell.button6.hidden = YES;
            cell.button7.hidden = YES;
            cell.button8.hidden = YES;
            cell.button9.hidden = YES;
            cell.button10.hidden = YES;
            cell.button11.hidden = YES;
        }else{
            [cell initView:11 string1:@"有汗" string2:@"无汗" string3:@"自汗" string4:@"盗汗" string5:@"绝汗" string6:@"战汗" string7:@"黄汗" string8:@"头汗" string9:@"手足出汗" string10:@"心胸出汗" string11:@"半身出汗"];
        }
        return cell;
    }
    else if (indexPath.section > 1){
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
