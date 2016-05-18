//
//  HealthInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthDishInfoViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "DishHeaderView.h"
#import "DishBasicTableCell.h"
#import "DishDetailTableCell.h"
#import "DishFoodTableCell.h"
#import "DishStepTableCell.h"
#import "DishTabooTableCell.h"
#import "DishExpertTableCell.h"
#import "DishFoodData.h"
#import "DishExpertData.h"
#import "ExpertInfoViewController.h"

@interface HealthDishInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)UIImageView *dishImageView;
@property (strong,nonatomic)DishHeaderView *dishHeaderView;

@property (strong,nonatomic)NSString *dishImageString;
@property (assign,nonatomic)NSInteger commentNumber;
@property (strong,nonatomic)NSString *dishProperty;
@property (strong,nonatomic)NSString *dishFunction;

@property (strong,nonatomic)NSString *dishDetail;

@property (strong,nonatomic)NSMutableArray *foodArray;
@property (strong,nonatomic)NSMutableArray *foodIdArray;
@property (strong,nonatomic)NSMutableArray *foodNameArray;
@property (strong,nonatomic)NSMutableArray *foodQuantityArray;
@property (strong,nonatomic)NSMutableArray *foodImageArray;

@property (strong,nonatomic)NSString *dishStep;

@property (strong,nonatomic)NSString *dishTaboo;

@property (strong,nonatomic)NSMutableArray *expertArray;
@property (strong,nonatomic)NSMutableArray *expertIdArray;
@property (strong,nonatomic)NSMutableArray *expertImageArray;
@property (strong,nonatomic)NSMutableArray *expertNameArray;
@property (strong,nonatomic)NSMutableArray *expertTitleArray;
@property (strong,nonatomic)NSMutableArray *expertUnitArray;

@end

@implementation HealthDishInfoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthDishInfoViewController"];
    
    [self sendHealthDishInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"HealthDishInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.foodArray = [NSMutableArray array];
    self.foodIdArray = [NSMutableArray array];
    self.foodNameArray = [NSMutableArray array];
    self.foodQuantityArray = [NSMutableArray array];
    self.foodImageArray = [NSMutableArray array];
    
    self.expertArray = [NSMutableArray array];
    self.expertIdArray = [NSMutableArray array];
    self.expertImageArray = [NSMutableArray array];
    self.expertNameArray = [NSMutableArray array];
    self.expertTitleArray = [NSMutableArray array];
    self.expertUnitArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = self.healthName;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initHeadView];
    [self initFootView];
    [self initTableView];
    [self initBottomView];
}

-(void)initHeadView{
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    
    self.dishImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
//    [self.dishImageView sd_setImageWithURL:[NSURL URLWithString:self.dishImageString] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
    [self.dishImageView setImage:[UIImage imageNamed:@"default_image_big"]];
    
    [self.headView addSubview:self.dishImageView];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT-55) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH/3*2, 55)];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"test" forState:UIControlStateNormal];
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, SCREEN_HEIGHT-55, SCREEN_WIDTH/3, 55)];
    self.rightButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.rightButton];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return self.expertArray.count == 0 ? 0 :self.expertArray.count;
            break;
        default:
            return 1;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 66;
            break;
        case 1:
            return 260;
            break;
        case 2:
            return 145;
            break;
        case 3:
            return 46;
            break;
        case 4:
            return 145;
            break;
        case 5:
            return 90;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0.1;
            break;
        case 1:
            return 45;
            break;
        case 2:
            return 45;
            break;
        case 3:
            return 45;
            break;
        case 4:
            return 45;
            break;
        case 5:
            return 45;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.dishHeaderView = [[DishHeaderView alloc] init];
    
    if (section == 0) {
        self.dishHeaderView.titleLabel.hidden = YES;
    }else if (section == 1){
        self.dishHeaderView.titleLabel.text = @"简介";
    }else if (section == 2){
        self.dishHeaderView.titleLabel.text = @"食材";
    }else if (section == 3){
        self.dishHeaderView.titleLabel.text = @"步骤";
    }else if (section == 4){
        self.dishHeaderView.titleLabel.text = @"食用禁忌";
    }else if (section == 5){
        self.dishHeaderView.titleLabel.text = @"找专家";
    }
    
    return self.dishHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"DishBasicTableCell";
        DishBasicTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishBasicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.commentImageView setImage:[UIImage imageNamed:@"info_health_dish_comment_yellow"]];
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld人点赞",(long)self.commentNumber];
        cell.propertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.dishProperty];
        cell.functionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.dishFunction];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"DishDetailTableCell";
        DishDetailTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.dishDetail;
        
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"DishFoodTableCell";
        DishFoodTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishFoodTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"DishStepTableCell";
        DishStepTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishStepTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 4){
        static NSString *cellName = @"DishTabooTableCell";
        DishTabooTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishTabooTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.dishTaboo;
        
        return cell;
    }else if (indexPath.section == 5){
        static NSString *cellName = @"DishExpertTableCell";
        DishExpertTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DishExpertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.expertNameLabel.text = self.expertNameArray[indexPath.row];
        cell.expertTitleLabel.text = self.expertTitleArray[indexPath.row];
        cell.expertUnitLabel.text = self.expertUnitArray[indexPath.row];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
        expertVC.expertId = self.expertIdArray[indexPath.row];
        expertVC.expertName = self.expertNameArray[indexPath.row];
        [self.navigationController pushViewController:expertVC animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendHealthDishInfoRequest{
    DLog(@"sendHealthDishInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.healthId forKey:@"food_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.healthType] forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self healthDishInfoDataParse];
        }else{
            DLog(@"%@",self.message);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
        
        [HudUtil showSimpleTextOnlyHUD:kNetworkStatusErrorText withDelaySeconds:kHud_DelayTime];
    }];
}

#pragma mark Data Parse
-(void)healthDishInfoDataParse{
    self.dishImageString = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"cover_url"]];
    
    [self.dishImageView sd_setImageWithURL:[NSURL URLWithString:self.dishImageString] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
    
    self.commentNumber = [[[self.data objectForKey:@"foodDetail"] objectForKey:@"admire"] integerValue];
    self.dishProperty = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_wx"]];
    self.dishFunction = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_gx"]];
    
    self.dishDetail = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"jianjie"]];
    
    self.foodArray = [DishFoodData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"foods"]];
    if (self.foodArray.count > 0) {
        for (DishFoodData *dishFoodData in self.foodArray) {
            [self.foodIdArray addObject:dishFoodData.food_id];
            [self.foodNameArray addObject:dishFoodData.food_name];
            [self.foodQuantityArray addObject:dishFoodData.dose];
            [self.foodImageArray addObject:dishFoodData.cover_url];
        }
    }
    
    self.dishStep = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"buzhou"]];
    
    self.dishTaboo = [NullUtil judgeStringNull:[[self.data objectForKey:@"foodDetail"] objectForKey:@"food_jj"]];
    
    self.expertArray = [DishExpertData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"doctors"]];
    for (DishExpertData *dishExpertData in self.expertArray) {
        [self.expertIdArray addObject:dishExpertData.doctor_id];
        [self.expertImageArray addObject:dishExpertData.heand_url];
        [self.expertNameArray addObject:dishExpertData.doctor_name];
        [self.expertTitleArray addObject:dishExpertData.title_name];
        [self.expertUnitArray addObject:dishExpertData.company];
    }
    
    [self.tableView reloadData];
}

@end