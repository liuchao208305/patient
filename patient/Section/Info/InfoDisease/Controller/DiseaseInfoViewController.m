//
//  DiseaseInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "DiseaseInfoViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "DiseaseHeaderView.h"
#import "DiseaseDetailTableCell.h"
#import "DiseaseSymptomTableCell.h"
#import "DiseaseCauseTableCell.h"
#import "DiseaseAttentionTableCell.h"
#import "DiseaseExpertTableCell.h"
#import "DiseaseHealthTableCell.h"
#import "DiseaseExpertData.h"
#import "DiseaseHealthData.h"
#import "ExpertInfoViewController.h"
#import "HealthDishInfoViewController.h"
#import "HealthFoodInfoViewController.h"
#import "LoginViewController.h"

@interface DiseaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableDictionary *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)DiseaseHeaderView *diseaseHeaderView;

@property (strong,nonatomic)NSString *diseaseIdFix;

@property (strong,nonatomic)NSString *diseaseDetail;

@property (strong,nonatomic)NSString *diseaseCause;

@property (strong,nonatomic)NSString *diseaseAttention;

@property (strong,nonatomic)NSMutableArray *expertArray;
@property (strong,nonatomic)NSMutableArray *expertIdArray;
@property (strong,nonatomic)NSMutableArray *expertImageArray;
@property (strong,nonatomic)NSMutableArray *expertNameArray;
@property (strong,nonatomic)NSMutableArray *expertTitleArray;
@property (strong,nonatomic)NSMutableArray *expertUnitArray;
@property (strong,nonatomic)NSMutableArray *expertFlagArray;

@property (strong,nonatomic)NSMutableArray *healthArray;
@property (strong,nonatomic)NSMutableArray *healthTypeArray;
@property (strong,nonatomic)NSMutableArray *healthIdArray;
@property (strong,nonatomic)NSMutableArray *healthImageArray;
@property (strong,nonatomic)NSMutableArray *healthNameArray;
@property (strong,nonatomic)NSMutableArray *healthPropertyArray;
@property (strong,nonatomic)NSMutableArray *healthFunctionArray;
@property (strong,nonatomic)NSMutableArray *healthSeasonArray;
@property (strong,nonatomic)NSMutableArray *healthCommentArray;

@property (assign,nonatomic)NSInteger commentFlag;
@property (assign,nonatomic)NSInteger favouriteFlag;

@end

@implementation DiseaseInfoViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"DiseaseInfoViewController"];
    
    [self sendDiseaseInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"DiseaseInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.expertArray = [NSMutableArray array];
    self.expertIdArray = [NSMutableArray array];
    self.expertImageArray = [NSMutableArray array];
    self.expertNameArray = [NSMutableArray array];
    self.expertTitleArray = [NSMutableArray array];
    self.expertUnitArray = [NSMutableArray array];
    self.expertFlagArray = [NSMutableArray array];
    
    self.healthArray = [NSMutableArray array];
    self.healthTypeArray = [NSMutableArray array];
    self.healthIdArray = [NSMutableArray array];
    self.healthImageArray = [NSMutableArray array];
    self.healthNameArray = [NSMutableArray array];
    self.healthPropertyArray = [NSMutableArray array];
    self.healthFunctionArray = [NSMutableArray array];
    self.healthSeasonArray = [NSMutableArray array];
    self.healthCommentArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = self.diseaseName;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    [self initTableView];
    [self initBottomView];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT-55) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.tableView.size.height, SCREEN_WIDTH/3*2, 68)];
    [self.commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commentButton];
    
    self.favouriteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, self.tableView.size.height, SCREEN_WIDTH/3, 68)];
    [self.favouriteButton addTarget:self action:@selector(favouriteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.favouriteButton];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)commentButtonClicked{
    DLog(@"commentButtonClicked");
    [self sendHealthCommentAndFavouriteRequest:1];
}

-(void)favouriteButtonClicked{
    DLog(@"favouriteButtonClicked");
    [self sendHealthCommentAndFavouriteRequest:2];
}

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
            return self.expertArray.count == 0 ? 0 :self.expertArray.count;
            break;
        case 5:
            return self.healthArray.count == 0 ? 0 :self.healthArray.count;
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
            return 80;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 250;
            break;
        case 3:
            return 100;
            break;
        case 4:
            return 85;
            break;
        case 5:
            return 100;
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
    self.diseaseHeaderView = [[DiseaseHeaderView alloc] init];
    
    if (section == 0) {
        self.diseaseHeaderView.titleLabel.hidden = YES;
    }else if (section == 1){
        self.diseaseHeaderView.titleLabel.text = @"症状";
    }else if (section == 2){
        self.diseaseHeaderView.titleLabel.text = @"病因";
    }else if (section == 3){
        self.diseaseHeaderView.titleLabel.text = @"注意事项";
    }else if (section == 4){
        self.diseaseHeaderView.titleLabel.text = @"找专家";
    }else if (section == 5){
        self.diseaseHeaderView.titleLabel.text = @"饮食调理咳嗽";
    }
    
    return self.diseaseHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"DiseaseDetailTableCell";
        DiseaseDetailTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.diseaseDetail;
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"DiseaseSymptomTableCell";
        DiseaseSymptomTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseSymptomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"DiseaseCauseTableCell";
        DiseaseCauseTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseCauseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.diseaseCause;
        
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"DiseaseAttentionTableCell";
        DiseaseAttentionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseAttentionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.label.text = self.diseaseAttention;
        
        return cell;
    }else if (indexPath.section == 4){
        static NSString *cellName = @"DiseaseExpertTableCell";
        DiseaseExpertTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseExpertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.expertNameLabel.text = self.expertNameArray[indexPath.row];
        cell.expertTitleLabel.text = self.expertTitleArray[indexPath.row];
        cell.expertUnitLabel.text = self.expertUnitArray[indexPath.row];
        
        return cell;
    }else if (indexPath.section == 5){
        static NSString *cellName = @"DiseaseHealthTableCell";
        DiseaseHealthTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[DiseaseHealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.healthImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.healthNameLabel.text = self.healthNameArray[indexPath.row];
        cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.healthPropertyArray[indexPath.row]];
        cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.healthFunctionArray[indexPath.row]];
        [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
        cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.healthCommentArray[indexPath.row]];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
        expertVC.expertId = self.expertIdArray[indexPath.row];
        expertVC.expertName = self.expertNameArray[indexPath.row];
        [self.navigationController pushViewController:expertVC animated:YES];
    }else if (indexPath.section == 5){
        if ([self.healthTypeArray[indexPath.row] integerValue] == 1) {
            HealthFoodInfoViewController *foodVC = [[HealthFoodInfoViewController alloc] init];
            foodVC.healthType = [self.healthTypeArray[indexPath.row] integerValue];
            foodVC.healthId = self.healthIdArray[indexPath.row];
            foodVC.healthName = self.healthNameArray[indexPath.row];
            [self.navigationController pushViewController:foodVC animated:YES];
        }else if([self.healthTypeArray[indexPath.row] integerValue] == 2){
            HealthDishInfoViewController *dishVC = [[HealthDishInfoViewController alloc] init];
            dishVC.healthType = [self.healthTypeArray[indexPath.row] integerValue];
            dishVC.healthId = self.healthIdArray[indexPath.row];
            dishVC.healthName = self.healthNameArray[indexPath.row];
            [self.navigationController pushViewController:dishVC animated:YES];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendDiseaseInfoRequest{
    DLog(@"sendDiseaseInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.diseaseId forKey:@"case_id"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_DISEASE_INFOMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self diseaseInfoDataParse];
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

-(void)sendHealthCommentAndFavouriteRequest:(NSInteger)type{
    DLog(@"sendHealthCommentAndFavouriteRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.diseaseIdFix forKey:@"disease_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_COMMENT_AND_FAVOURITE] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            if (type == 1) {
                self.isCommented = !self.isCommented;
                DLog(@"self.isCommented-->%@",self.isCommented ? @"YES" : @"NO");
                if (self.isCommented == YES) {
                    [HudUtil showSimpleTextOnlyHUD:@"点赞成功！" withDelaySeconds:kHud_DelayTime];
                    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_after"] forState:UIControlStateNormal];
                }else if (self.isCommented == NO){
                    [HudUtil showSimpleTextOnlyHUD:@"取消点赞成功！" withDelaySeconds:kHud_DelayTime];
                    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_before"] forState:UIControlStateNormal];
                }
            }else if (type == 2){
                self.isFavourited = !self.isFavourited;
                DLog(@"self.isFavourited-->%@",self.isFavourited ? @"YES" : @"NO");
                if (self.isFavourited == YES) {
                    [HudUtil showSimpleTextOnlyHUD:@"收藏成功！" withDelaySeconds:kHud_DelayTime];
                    [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_after"] forState:UIControlStateNormal];
                }else if (self.isFavourited == NO){
                    [HudUtil showSimpleTextOnlyHUD:@"取消收藏成功！" withDelaySeconds:kHud_DelayTime];
                    [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_before"] forState:UIControlStateNormal];
                }
            }
            
            
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

#pragma mark Data Parse
-(void)diseaseInfoDataParse{
    self.diseaseIdFix = [NullUtil judgeStringNull:[[self.data objectForKey:@"diseaseKey"] objectForKey:@"disease_id"]];
    
    self.diseaseDetail = [NullUtil judgeStringNull:[[self.data objectForKey:@"diseaseKey"] objectForKey:@"clinical"]];
    
    self.diseaseCause = [NullUtil judgeStringNull:[[self.data objectForKey:@"diseaseKey"] objectForKey:@"reason"]];
    
    self.diseaseAttention = [NullUtil judgeStringNull:[[self.data objectForKey:@"diseaseKey"] objectForKey:@"matters"]];
    
    self.expertArray = [DiseaseExpertData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"doctorsKey"]];
    for (DiseaseExpertData *diseaseExpertData in self.expertArray) {
        [self.expertIdArray addObject:[NullUtil judgeStringNull:diseaseExpertData.doctor_id]];
        [self.expertImageArray addObject:[NullUtil judgeStringNull:diseaseExpertData.heand_url]];
        [self.expertNameArray addObject:[NullUtil judgeStringNull:diseaseExpertData.doctor_name]];
        [self.expertTitleArray addObject:[NullUtil judgeStringNull:diseaseExpertData.title_name]];
        [self.expertUnitArray addObject:[NullUtil judgeStringNull:diseaseExpertData.company]];
        [self.expertFlagArray addObject:[NullUtil judgeStringNull:diseaseExpertData.flags]];
    }
    
    self.healthArray = [DiseaseHealthData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"yinshiKey"]];
    if (self.healthArray.count > 0) {
        for (DiseaseHealthData *diseaseHealthData in self.healthArray) {
            [self.healthTypeArray addObject:diseaseHealthData.type];
            [self.healthIdArray addObject:diseaseHealthData.food_id];
            [self.healthNameArray addObject:diseaseHealthData.food_name];
            [self.healthImageArray addObject:diseaseHealthData.cover_url];
            [self.healthPropertyArray addObject:diseaseHealthData.food_wx];
            [self.healthFunctionArray addObject:diseaseHealthData.food_gx];
            [self.healthSeasonArray addObject:diseaseHealthData.season_id];
            [self.healthCommentArray addObject:[NSString stringWithFormat:@"%ld",(long)diseaseHealthData.admire]];
        }
    }
    
    self.commentFlag = [[[self.data objectForKey:@"diseaseKey"] objectForKey:@"is_like"] integerValue];
    if (self.commentFlag == 0) {
        self.isCommented = NO;
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_before"] forState:UIControlStateNormal];
    }else{
        self.isCommented = YES;
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"info_health_comment_after"] forState:UIControlStateNormal];
    }
    
    self.favouriteFlag = [[[self.data objectForKey:@"diseaseKey"] objectForKey:@"is_shouchan"] integerValue];
    if (self.favouriteFlag == 0) {
        self.isFavourited = NO;
        [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_before"] forState:UIControlStateNormal];
    }else{
        self.isFavourited = YES;
        [self.favouriteButton setBackgroundImage:[UIImage imageNamed:@"info_health_favourite_after"] forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}

@end
