//
//  MineExpertFixViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineExpertFixViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "AlertUtil.h"
#import "NullUtil.h"
#import "AnalyticUtil.h"
#import "MineExpertData.h"
#import "MineExpertTableCell.h"
#import "ExpertInfoViewController.h"
#import "LoginViewController.h"
#import "MorePersonTableCell.h"
#import "MorePersonData.h"
#import "MineExpertFixData.h"

@interface MineExpertFixViewController ()

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@end

@implementation MineExpertFixViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"MineExpertViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendMineExpertFixRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"MineExpertViewController"];
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
    self.expertDepartArray = [NSMutableArray array];
    self.expertDetailArray = [NSMutableArray array];
    self.expertShanchangArray = [NSMutableArray array];
//    self.expertAnswerArray = [NSMutableArray array];
//    self.expertFocusArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    //    label.text = @"我的专家";
    //    label.textColor = [UIColor whiteColor];
    //    label.font = [UIFont systemFontOfSize:20];
    //    label.textAlignment = NSTextAlignmentCenter;
    //    self.navigationItem.titleView = label;
    self.title=@"我的医生";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
}

-(void)initTabBar{
    
}

-(void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendMineExpertFixRequest];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendMineExpertFixRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.expertArray.count == 0 ? 0 : self.expertArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"MorePersonTableCell";
    MorePersonTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[MorePersonTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
    cell.expertNameLabel.text = self.expertNameArray[indexPath.row];
    cell.expertTitleLabel.text = self.expertTitleArray[indexPath.row];
    cell.expertUnitLabel.text = self.expertUnitArray[indexPath.row];
    cell.expertDepartLabel.text = self.expertDepartArray[indexPath.row];
    cell.expertDetailLabel.text = self.expertDetailArray[indexPath.row];
    cell.expertShanchangLabel.text = self.expertShanchangArray[indexPath.row];
//    [cell.expertAnswserImageView setImage:[UIImage imageNamed:@"info_more_person_anwer_image"]];
//    cell.expertAnswerLabel.text = [NSString stringWithFormat:@"已回答%@个问题",self.expertAnswerArray[indexPath.row]];
//    [cell.expertFocusImageView setImage:[UIImage imageNamed:@"info_more_person_focus_image"]];
//    cell.expertFocusLabel.text = [NSString stringWithFormat:@"%@人已关注",self.expertFocusArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertInfoViewController *expertVC = [[ExpertInfoViewController alloc] init];
    expertVC.expertId = self.expertIdArray[indexPath.row];
    expertVC.expertName = self.expertNameArray[indexPath.row];
    [self.navigationController pushViewController:expertVC animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendMineExpertFixRequest{
    DLog(@"sendMineExpertFixRequest");
    
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_MINE_EXPERT_FIX_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_MORE_PERSON_INFORMATION);
        DLog(@"%@",parameter);
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self mineExpertFixDataParse];
        }else{
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
-(void)mineExpertFixDataParse{
    self.expertArray = [MineExpertFixData mj_objectArrayWithKeyValuesArray:self.data];
    [self.expertIdArray removeAllObjects];
    [self.expertImageArray removeAllObjects];
    [self.expertNameArray removeAllObjects];
    [self.expertTitleArray removeAllObjects];
    [self.expertUnitArray removeAllObjects];
    [self.expertDepartArray removeAllObjects];
    [self.expertDetailArray removeAllObjects];
    [self.expertShanchangArray removeAllObjects];
//    [self.expertAnswerArray removeAllObjects];
//    [self.expertFocusArray removeAllObjects];
    for (MineExpertFixData *mineExpertFixData in self.expertArray) {
        [self.expertIdArray addObject:[NullUtil judgeStringNull:mineExpertFixData.doctor_id]];
        [self.expertImageArray addObject:[NullUtil judgeStringNull:mineExpertFixData.heand_url]];
        [self.expertNameArray addObject:[NullUtil judgeStringNull:mineExpertFixData.doctor_name]];
        [self.expertTitleArray addObject:[NullUtil judgeStringNull:mineExpertFixData.title_name]];
        [self.expertUnitArray addObject:[NullUtil judgeStringNull:mineExpertFixData.org_name]];
        [self.expertDepartArray addObject:[NullUtil judgeStringNull:mineExpertFixData.depart_name]];
        [self.expertDetailArray addObject:[NullUtil judgeStringNull:mineExpertFixData.doctor_descr]];
        [self.expertShanchangArray addObject:[NullUtil judgeStringNull:mineExpertFixData.shanchang]];
//        [self.expertAnswerArray addObject:[NullUtil judgeStringNull:mineExpertFixData.answers]];
//        [self.expertFocusArray addObject:[NullUtil judgeStringNull:mineExpertFixData.atteations]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
