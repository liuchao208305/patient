//
//  HealthDiseaseHistoryViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthDiseaseHistoryViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "SelfInspectionOneTableCell.h"

@interface HealthDiseaseHistoryViewController ()<JiwangshiDelegate,ShoushushiDelegate,GuominshiDelegate,JiazushiDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)BOOL jiwangshiHideFlag;
@property (assign,nonatomic)BOOL shoushushiHideFlag;
@property (assign,nonatomic)BOOL guominshiHideFlag;
@property (assign,nonatomic)BOOL jiazushiHideFlag;

@property (strong,nonatomic)NSString *jiwangshi;
@property (strong,nonatomic)NSString *shoushushi;
@property (strong,nonatomic)NSString *guominshi;
@property (strong,nonatomic)NSString *jiazushi;

@end

@implementation HealthDiseaseHistoryViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthDiseaseHistoryViewController"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthDiseaseHistoryViewController"];
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
    
    self.title = @"既往史／手术史／过敏史／家族史";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
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
-(void)jiwangshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.jiwangshiHideFlag = NO;
            break;
        case 1:
            self.jiwangshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)shoushushiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.shoushushiHideFlag = NO;
            break;
        case 1:
            self.shoushushiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)guominshiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.guominshiHideFlag = NO;
            break;
        case 1:
            self.guominshiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

-(void)jiazushiSegmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.jiazushiHideFlag = NO;
            break;
        case 1:
            self.jiazushiHideFlag = YES;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark SymtomDelegate
-(void)sendTextField1Value:(NSString *)string{
    self.jiwangshi = string;
    DLog(@"self.jiwangshi-->%@",self.jiwangshi);
}

-(void)sendTextField2Value:(NSString *)string{
    self.shoushushi = string;
    DLog(@"self.shoushushi-->%@",self.shoushushi);
}

-(void)sendTextField3Value:(NSString *)string{
    self.guominshi = string;
    DLog(@"self.guominshi-->%@",self.guominshi);
}

-(void)sendTextField4Value:(NSString *)string{
    self.jiazushi = string;
    DLog(@"self.jiazushi-->%@",self.jiazushi);
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.jiwangshiHideFlag == NO) {
            return 95;
        }
    }else if (indexPath.section == 1){
        if (self.shoushushiHideFlag == NO) {
            return 95;
        }
    }else if (indexPath.section == 2){
        if (self.guominshiHideFlag == NO) {
            return 95;
        }
    }else if (indexPath.section == 3){
        if (self.jiazushiHideFlag == NO) {
            return 95;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.selfInspectionHeaderView = [[SelfInspectionHeaderView alloc] init];
    if (section == 0) {
        NSString *title = @"既往史";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.jiwangshiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(jiwangshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 1){
        NSString *title = @"手术史";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.shoushushiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(shoushushiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    else if (section == 2){
        NSString *title = @"过敏史";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"异常",@"正常",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.guominshiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(guominshiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }else if (section == 3){
        NSString *title = @"家族史";
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"口渴",@"不口渴",nil];
        [self.selfInspectionHeaderView initView:title array:segmentedArray righHideFlag:self.jiazushiHideFlag];
        [self.selfInspectionHeaderView.segmentedControl addTarget:self action:@selector(jiazushiSegmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return self.selfInspectionHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initViewWithTextField:@"请在此处填写您的既往病史"];
            cell.jiwangshiDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 1){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initViewWithTextField:@"请在此处填写您的手术史"];
            cell.shoushushiDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 2){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initViewWithTextField:@"请在此处填写您的过敏原"];
            cell.guominshiDelegate = self;
        }
        return cell;
    }else if (indexPath.section == 3){
        NSString *cellName = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
        SelfInspectionOneTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[SelfInspectionOneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [cell initViewWithTextField:@"请在此处填写您的家族史，如：祖父，高血压等"];
            cell.jiazushiDelegate = self;
        }
        return cell;
    }
    return nil;
}

#pragma mark Network Request

#pragma mark Data Parse

@end
