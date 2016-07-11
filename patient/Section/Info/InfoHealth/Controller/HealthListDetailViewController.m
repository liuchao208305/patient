//
//  HealthListDetailViewController.m
//  patient
//
//  Created by ChaosLiu on 16/7/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthListDetailViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "HealthListDetailData.h"
#import "HealthListDetailTableCell.h"

@interface HealthListDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;

@end

@implementation HealthListDetailViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"HealthListDetailViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self sendHealthListDetailRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"HealthListDetailViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.healthListDetailArray = [NSMutableArray array];
    self.healthListDetailIdArray = [NSMutableArray array];
    self.healthListDetailTimeArray = [NSMutableArray array];
    self.healthListDetailResultArray = [NSMutableArray array];
    self.healthListDetailPhotoArray  = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.title = @"健康自查列表";
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
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendHealthListDetailRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.healthListDetailArray.count == 0 ? 0 : self.healthListDetailArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 450;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.healthListHeaderView = [[HealthListHeaderView alloc] init];
    self.healthListHeaderView.titleLabel.text = self.healthListDetailTimeArray[section];
    return self.healthListHeaderView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"HealthListDetailTableCell";
    HealthListDetailTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[HealthListDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    NSString *shuimian = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"b_val"]];
    NSString *yinshi = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"c_val"]];
    NSString *yinshui = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"d_val"]];
    
    NSString *dabianCishu = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_val"]];
    NSString *bianmiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isBM"]];
    NSString *xiexieStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"	e_isXM"]];
    NSString *chengxingStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"	e_isCX"]];
    NSString *bianzhiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_isEX"]];
    NSString *bianzhiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"e_EX_val"]];
    NSString *paibianganStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"f_status"]];
    NSString *paibianganString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"f_val"]];
//    NSString *dabianyanseString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"	e_color"]];
    NSString *xiaobianBaitianString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"g_up_no"]];
    NSString *xiaobianWanshangString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"g_down_no"]];
//    NSString *sezhiStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"h_status"]];
    NSString *sezhiString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"h_val"]];
//    NSString *painiaoganStatus = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"i_status"]];
    NSString *painiaoganString = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"i_val"]];
    
    NSString *dabian1 = [NSString stringWithFormat:@"每天%@次；便秘：%@；泄泻：%@；成形：%@；",dabianCishu,bianmiStatus,xiexieStatus,chengxingStatus];
    NSString *dabian2 = [NSString stringWithFormat:@"便质：%@；排便感：%@",bianzhiString,paibianganString];
    NSString *dabian3 = @"大便颜色：";
    
    NSString *xiaobian1 = [NSString stringWithFormat:@"白天%@次，晚上%@次；色质：%@；",xiaobianBaitianString,xiaobianWanshangString,sezhiString];
    NSString *xiaobian2 = [NSString stringWithFormat:@"排尿感：%@；",painiaoganString];
    
    NSString *hanre = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"v_val"]];
    NSString *tiwen = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"w_val"]];
    NSString *chuhan = [NullUtil judgeStringNull:[[StringUtil dictionaryWithJsonString:self.healthListDetailResultArray[indexPath.section]] objectForKey:@"x_val"]];
    
    cell.shuimianLabel1.text = @"睡眠：";
    cell.shuimianLabel2.text = [shuimian isEqualToString:@""] ? @"无" : shuimian;
    cell.yinshiLabel1.text = @"饮食：";
    cell.yinshiLabel2.text = [yinshi isEqualToString:@""] ? @"无" : yinshi;
    cell.yinshuiLabel1.text = @"饮水：";
    cell.yinshuiLabel2.text = [yinshui isEqualToString:@""] ? @"无" : yinshui;
    cell.dabianLabel1.text = @"大便：";
    cell.dabianLabel2_1.text = [dabian1 isEqualToString:@""] ? @"无" : dabian1;
    cell.dabianLabel2_2.text = [dabian2 isEqualToString:@""] ? @"无" : dabian2;
    cell.dabianLabel2_3.text = [dabian3 isEqualToString:@""] ? @"无" : dabian3;
    //        NSString *test = @"0xb6bc16";
    //        unsigned long red = strtoul([test UTF8String],0,0);
    //        [cell.dabianImageView setBackgroundColor:ColorWithHexRGB(red)];
    NSString *dabianyanseString = @"";
    
    if ([dabianyanseString isEqualToString:@""]) {
        [cell.dabianImageView setBackgroundColor:kWHITE_COLOR];
    }else{
        unsigned long dabian = strtoul([dabianyanseString UTF8String],0,0);
        [cell.dabianImageView setBackgroundColor:ColorWithHexRGB(dabian)];
    }
    cell.xiaobianLabel1.text = @"小便：";
    cell.xiaobianLabel2_1.text = [xiaobian1 isEqualToString:@""] ? @"无" : xiaobian1;
    cell.xiaobianLabel2_2.text = [xiaobian2 isEqualToString:@""] ? @"无" : xiaobian2;
    cell.hanreLabel1.text = @"寒热：";
    cell.hanreLabel2.text = [hanre isEqualToString:@""] ? @"无" : hanre;
    cell.tiwenLabel1.text = @"体温：";
    cell.tiwenLabel2.text = [tiwen isEqualToString:@""] ? @"无" : tiwen;
    cell.chuhanLabel1.text = @"出汗：";
    cell.chuhanLabel2.text = [chuhan isEqualToString:@""] ? @"无" : chuhan;
    cell.zhaopianLabel1.text = @"照片资料：";
    if ([self.healthListDetailPhotoArray[indexPath.section] isEqualToString:@""]) {
        cell.zhaopianLabel2.hidden = NO;
        cell.zhaopianLabel2.text = @"无";
    }else{
        cell.zhaopianLabel2.hidden = YES;
        
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sourceVC isEqualToString:@"QuestionInquiryViewController"]) {
        if (self.healthListDelegate && [self.healthListDelegate respondsToSelector:@selector(healthListChoosed:time:type:)]) {
            [self.healthListDelegate healthListChoosed:self.healthListDetailIdArray[indexPath.section] time:self.healthListDetailTimeArray[indexPath.section] type:@"健康自查"];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Network Request
-(void)sendHealthListDetailRequest{
    DLog(@"sendTestResultListRequest");
    
    self.currentPage = 1;
    self.pageSize += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_HEALTH_LIST_DETAIL_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self healthListDetailDataParse];
        }else{
            DLog(@"%ld",(long)self.code);
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
-(void)healthListDetailDataParse{
    self.healthListDetailArray = [HealthListDetailData mj_objectArrayWithKeyValuesArray:self.data];
    [self.healthListDetailIdArray removeAllObjects];
    [self.healthListDetailTimeArray removeAllObjects];
    [self.healthListDetailResultArray removeAllObjects];
    [self.healthListDetailPhotoArray removeAllObjects];
    for (HealthListDetailData *healthListDetailData in self.healthListDetailArray) {
        [self.healthListDetailIdArray addObject:[NullUtil judgeStringNull:healthListDetailData.q_healthy_id]];
        [self.healthListDetailTimeArray addObject:[NullUtil judgeStringNull:healthListDetailData.create_date]];
        [self.healthListDetailResultArray addObject:[NullUtil judgeStringNull:healthListDetailData.results]];
        [self.healthListDetailPhotoArray addObject:[NullUtil judgeStringNull:healthListDetailData.photos]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

@end
