//
//  InfoMoreHealthViewController.m
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "InfoMoreHealthViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "MoreHealthTableCell.h"
#import "MoreHealthData.h"
#import "HealthDishInfoViewController.h"
#import "HealthFoodInfoViewController.h"

@interface InfoMoreHealthViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@end

@implementation InfoMoreHealthViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"InfoMoreHealthViewController"];
    
    [self sendMoreHealthRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"InfoMoreHealthViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.healthArray = [NSMutableArray array];
    self.healthTypeArray = [NSMutableArray array];
    self.healthIdArray = [NSMutableArray array];
    self.healthImageArray = [NSMutableArray array];
    self.healthNameArray = [NSMutableArray array];
    self.healthPropertyArray = [NSMutableArray array];
    self.healthFunctionArray = [NSMutableArray array];
    self.healthCommentArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"健康饮食列表";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendMoreHealthRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendMoreHealthRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.healthArray.count == 0 ? 0 : self.healthArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MoreHealthTableCell";
    MoreHealthTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MoreHealthTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell.healthImageView sd_setImageWithURL:[NSURL URLWithString:self.healthImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    cell.healthNameLabel.text = self.healthNameArray[indexPath.row];
    cell.healthPropertyLabel.text = [NSString stringWithFormat:@"物性：%@",self.healthPropertyArray[indexPath.row]];
    cell.healthFunctionLabel.text = [NSString stringWithFormat:@"适用于：%@",self.healthFunctionArray[indexPath.row]];
    [cell.healthCommentImageView setImage:[UIImage imageNamed:@"info_health_comment_image"]];
    cell.healthCommentLabel.text = [NSString stringWithFormat:@"%@人点赞",self.healthCommentArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendMoreHealthRequest{
    DLog(@"sendMoreHealthRequest");
    
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"" forKey:@"seach"];
    [parameter setValue:@"1" forKey:@"pageNo"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    
    DLog(@"%@",parameter);
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MORE_HEALTH_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self moreHealthDataPase];
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

#pragma mark Data Parse
-(void)moreHealthDataPase{
    self.healthArray = [MoreHealthData mj_objectArrayWithKeyValuesArray:self.data];
    for (MoreHealthData *moreHealthData in self.healthArray) {
        [self.healthTypeArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)moreHealthData.type]]];
        [self.healthIdArray addObject:[NullUtil judgeStringNull:moreHealthData.food_id]];
        [self.healthImageArray addObject:[NullUtil judgeStringNull:moreHealthData.cover_url]];
        [self.healthNameArray addObject:[NullUtil judgeStringNull:moreHealthData.food_name]];
        [self.healthPropertyArray addObject:[NullUtil judgeStringNull:moreHealthData.food_wx]];
        [self.healthFunctionArray addObject:[NullUtil judgeStringNull:moreHealthData.food_gx]];
        [self.healthCommentArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)moreHealthData.admire]]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
