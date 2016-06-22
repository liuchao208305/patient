//
//  QuestionViewController.m
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionListViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "NullUtil.h"
#import "AlertUtil.h"
#import "AnalyticUtil.h"
#import "StringUtil.h"
#import "LoginViewController.h"
#import "QuestionListData.h"
#import "QuestionListTableCell.h"
#import "QuestionDetailViewController.h"
#import "QuestionInquiryViewController.h"

@interface QuestionListViewController ()<UITableViewDelegate,UITableViewDataSource>

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

@property (assign,nonatomic)NSInteger currentPage1;
@property (assign,nonatomic)NSInteger pageSize1;

@property (assign,nonatomic)NSInteger currentPage2;
@property (assign,nonatomic)NSInteger pageSize2;

@end

@implementation QuestionListViewController

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
    
    [AnalyticUtil UMBeginLogPageView:@"QuestionListViewController"];
    
    self.flag1 = YES;
    self.flag2 = NO;
    
    self.segmentedControl.selectedSegmentIndex = 0;
    [self initSubView1];
    [self sendQuestionCheckRequest1];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [AnalyticUtil UMEndLogPageView:@"QuestionListViewController"];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.questionMineArray = [NSMutableArray array];
    self.questionIdMineArray = [NSMutableArray array];
    self.questionStatusMineArray = [NSMutableArray array];
    self.questionPublicStatusMineArray = [NSMutableArray array];
    self.questionContentMineArray = [NSMutableArray array];
    self.questionExpertNameMineArray = [NSMutableArray array];
    self.questionExpertUnitMineArray = [NSMutableArray array];
    self.questionExpertTitleMineArray = [NSMutableArray array];
    self.questionExpertImageMineArray = [NSMutableArray array];
    self.questionExpertSoundMineArray = [NSMutableArray array];
    self.questionAudienceNumberMineArray = [NSMutableArray array];
    self.questionPayStatusMineArray = [NSMutableArray array];
    
    self.questionOtherArray = [NSMutableArray array];
    self.questionIdOtherArray = [NSMutableArray array];
    self.questionStatusOtherArray = [NSMutableArray array];
    self.questionPublicStatusOtherArray = [NSMutableArray array];
    self.questionContentOtherArray = [NSMutableArray array];
    self.questionExpertNameOtherArray = [NSMutableArray array];
    self.questionExpertUnitOtherArray = [NSMutableArray array];
    self.questionExpertTitleOtherArray = [NSMutableArray array];
    self.questionExpertImageOtherArray = [NSMutableArray array];
    self.questionExpertSoundOtherArray = [NSMutableArray array];
    self.questionAudienceNumberOtherArray = [NSMutableArray array];
    self.questionPayStatusOtherArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
//    self.title = @"问答";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的问答",@"其他问答",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 156, 32);
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = kWHITE_COLOR;
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.questionView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-112, 0, 16+4+80+12, 30)];
    
    self.questionImage = [[UIImageView alloc] init];
    self.questionImage.layer.cornerRadius = 8;
    [self.questionImage setImage:[UIImage imageNamed:@"question_list_right_barbuttonitem"]];
    [self.questionView addSubview:self.questionImage];
    
    self.questionLabel = [[UILabel alloc] init];
    self.questionLabel.text = @"提问";
    self.questionLabel.textColor = kWHITE_COLOR;
    self.questionLabel.textAlignment = NSTextAlignmentRight;
    [self.questionView addSubview:self.questionLabel];
    
    [self.questionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionLabel).offset(-35-4);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.questionView).offset(0);
        make.centerY.equalTo(self.questionView).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.questionView];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.view.backgroundColor = kBACKGROUND_COLOR;
}

-(void)initSubView1{
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView1.showsVerticalScrollIndicator = YES;
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView1.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest1];
    }];
    
    self.tableView1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest1];
    }];
    
    [self.view addSubview:self.tableView1];
}

-(void)initSubView2{
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
    self.tableView2.showsVerticalScrollIndicator = YES;
    self.tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView2.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest2];
    }];
    
    self.tableView2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self sendQuestionCheckRequest2];
    }];
    
    [self.view addSubview:self.tableView2];
}

-(void)initRecognizer{
    self.questionView.userInteractionEnabled = YES;
    UITapGestureRecognizer *questionViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(questionViewClicked)];
    [self.questionView addGestureRecognizer:questionViewTap];
}

#pragma mark Target Action
-(void)questionViewClicked{
    DLog(@"questionViewClicked");
    QuestionInquiryViewController *inquiryVC = [[QuestionInquiryViewController alloc] init];
    inquiryVC.hidesBottomBarWhenPushed = YES;
    inquiryVC.isForSpecialDoctor = NO;
    [self.navigationController pushViewController:inquiryVC animated:YES];
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
//    DLog(@"Index-->%li", (long)Index);
    switch (Index) {
        case 0:
            self.flag1 = YES;
            self.flag2 = NO;
            DLog(@"Index-->%li", (long)Index);
            [self initSubView1];
            [self sendQuestionCheckRequest1];
            break;
        case 1:
            self.flag1 = NO;
            self.flag2  = YES;
            DLog(@"Index-->%li", (long)Index);
            [self initSubView2];
            [self sendQuestionCheckRequest2];
            break;
        default:
            break;
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.flag1) {
        return self.questionMineArray.count == 0 ? 0 : self.questionMineArray.count;
    }else if (self.flag2){
        return self.questionOtherArray.count == 0 ? 0 : self.questionOtherArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 190;
    if (self.flag1) {
        
    }else if (self.flag2){
        return [StringUtil cellWithStr:self.questionContentOtherArray[indexPath.section] fontSize:14 width:SCREEN_WIDTH]*2+15+15+60+15+12+15;
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
    if (self.flag1) {
        static NSString *cellName = @"QuestionTableCell";
        QuestionListTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[QuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (self.questionMineArray.count > 0) {
            cell.contentLabel.text = self.questionContentMineArray[indexPath.section];
            if ([self.questionPublicStatusMineArray[indexPath.section] intValue] == 1) {
                [cell.publicImageView setImage:[UIImage imageNamed:@"question_list_public_flag_image"]];
            }else{
                cell.publicImageView.hidden = YES;
            }
            
            cell.expertLabel.text = [NSString stringWithFormat:@"%@ | %@ %@",self.questionExpertNameMineArray[indexPath.section],self.questionExpertUnitMineArray[indexPath.section],self.questionExpertTitleMineArray[indexPath.section]];
            [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.questionExpertImageMineArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
            [cell.expertSoundImageView setImage:[UIImage imageNamed:@"info_person_mr_record_image"]];
            cell.expertSoundLengthLabel.text = @"43''";
            cell.audienceNumberLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionAudienceNumberMineArray[indexPath.section]];
            
            if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 1) {
                cell.payStatusLabel.text = @"待支付";
                [cell.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
                [cell.deleteButton setTitleColor:ColorWithHexRGB(0x909090) forState:UIControlStateNormal];
                [cell.deleteButton setBackgroundColor:kWHITE_COLOR];
                cell.deleteButton.layer.cornerRadius = 3;
                cell.deleteButton.layer.borderWidth = 1;
                cell.deleteButton.layer.borderColor = ColorWithHexRGB(0x909090).CGColor;
                [cell.confirmButton setTitle:@"立即支付" forState:UIControlStateNormal];
                [cell.confirmButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
                [cell.confirmButton setBackgroundColor:kMAIN_COLOR];
                cell.confirmButton.layer.cornerRadius = 5;
            }else if ([self.questionPayStatusMineArray[indexPath.section] intValue] == 2){
                cell.payStatusLabel.hidden = YES;
                cell.deleteButton.hidden = YES;
                cell.confirmButton.hidden = YES;
            }
        }
        
        return cell;
    }else if (self.flag2){
        static NSString *cellName = @"QuestionTableCell";
        QuestionListTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[QuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        if (self.questionOtherArray.count > 0) {
            cell.contentLabel.text = self.questionContentOtherArray[indexPath.section];
            
            cell.expertLabel.text = [NSString stringWithFormat:@"%@ | %@ %@",self.questionExpertNameOtherArray[indexPath.section],self.questionExpertUnitOtherArray[indexPath.section],self.questionExpertTitleOtherArray[indexPath.section]];
            [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.questionExpertImageOtherArray[indexPath.section]] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
            
            if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 1) {
                
            }else if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 2){
                
            }else if ([self.questionPayStatusOtherArray[indexPath.section] intValue] == 3){
                
            }
            
            cell.expertSoundImageView.hidden = YES;
            cell.expertSoundLengthLabel.hidden = YES;
            
            cell.audienceNumberLabel.text = [NSString stringWithFormat:@"%@人已听",self.questionAudienceNumberOtherArray[indexPath.section]];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.flag1) {
        QuestionDetailViewController *detailVC = [[QuestionDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tableView1 deselectRowAtIndexPath:indexPath animated:YES];
    }else if (self.flag2){
        QuestionDetailViewController *detailVC = [[QuestionDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark Network Request
-(void)sendQuestionCheckRequest1{
    DLog(@"sendQuestionCheckRequest1");
    
    self.currentPage1 = 1;
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage1] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_MINE_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result1 = (NSMutableDictionary *)responseObject;
        
        self.code1 = [[self.result1 objectForKey:@"code"] integerValue];
        self.message1 = [self.result1 objectForKey:@"message"];
        self.data1 = [self.result1 objectForKey:@"data"];
        
        if (self.code1 == kSUCCESS) {
            [self questionCheckDataParse1];
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

-(void)sendQuestionCheckRequest2{
    DLog(@"sendQuestionCheckRequest2");
    
    self.currentPage2 = 1;
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage2] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_OTHER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddressPay,kJZK_QUESTION_LIST_OTHER_INFORMATION);
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self questionCheckDataParse2];
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
-(void)questionCheckDataParse1{
    DLog(@"questionCheckDataParse1");
    self.questionMineArray = [QuestionListData mj_objectArrayWithKeyValuesArray:self.data1];
    [self.questionIdMineArray removeAllObjects];
    [self.questionStatusMineArray removeAllObjects];
    [self.questionPublicStatusMineArray removeAllObjects];
    [self.questionContentMineArray removeAllObjects];
    [self.questionExpertNameMineArray removeAllObjects];
    [self.questionExpertUnitMineArray removeAllObjects];
    [self.questionExpertTitleMineArray removeAllObjects];
    [self.questionExpertImageMineArray removeAllObjects];
    [self.questionExpertSoundMineArray removeAllObjects];
    [self.questionAudienceNumberMineArray removeAllObjects];
    [self.questionPayStatusMineArray removeAllObjects];
    for (QuestionListData *questionListData in self.questionMineArray) {
        [self.questionIdMineArray addObject:[NullUtil judgeStringNull:questionListData.interloution_id]];
        [self.questionStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.status]];
        [self.questionPublicStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.is_public]];
        [self.questionContentMineArray addObject:[NullUtil judgeStringNull:questionListData.content]];
        [self.questionExpertNameMineArray addObject:[NullUtil judgeStringNull:questionListData.doctor_name]];
        [self.questionExpertUnitMineArray addObject:[NullUtil judgeStringNull:questionListData.company]];
        [self.questionExpertTitleMineArray addObject:[NullUtil judgeStringNull:questionListData.title_name]];
        [self.questionExpertImageMineArray addObject:[NullUtil judgeStringNull:questionListData.heand_url]];
        [self.questionExpertSoundMineArray addObject:[NullUtil judgeStringNull:questionListData.video_url]];
        [self.questionAudienceNumberMineArray addObject:[NullUtil judgeStringNull:questionListData.num_no]];
        [self.questionPayStatusMineArray addObject:[NullUtil judgeStringNull:questionListData.pay_status]];
    }
    
    [self.tableView1 reloadData];
    
    [self.tableView1.mj_header endRefreshing];
    [self.tableView1.mj_footer endRefreshing];
}

-(void)questionCheckDataParse2{
    DLog(@"questionCheckDataParse2");
    self.questionOtherArray = [QuestionListData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.questionIdOtherArray removeAllObjects];
    [self.questionStatusOtherArray removeAllObjects];
    [self.questionPublicStatusOtherArray removeAllObjects];
    [self.questionContentOtherArray removeAllObjects];
    [self.questionExpertNameOtherArray removeAllObjects];
    [self.questionExpertUnitOtherArray removeAllObjects];
    [self.questionExpertTitleOtherArray removeAllObjects];
    [self.questionExpertImageOtherArray removeAllObjects];
    [self.questionExpertSoundOtherArray removeAllObjects];
    [self.questionAudienceNumberOtherArray removeAllObjects];
    [self.questionPayStatusOtherArray removeAllObjects];
    for (QuestionListData *questionListData in self.questionOtherArray) {
        [self.questionIdOtherArray addObject:[NullUtil judgeStringNull:questionListData.interloution_id]];
        [self.questionStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.status]];
        [self.questionPublicStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.is_public]];
        [self.questionContentOtherArray addObject:[NullUtil judgeStringNull:questionListData.content]];
        [self.questionExpertNameOtherArray addObject:[NullUtil judgeStringNull:questionListData.doctor_name]];
        [self.questionExpertUnitOtherArray addObject:[NullUtil judgeStringNull:questionListData.company]];
        [self.questionExpertTitleOtherArray addObject:[NullUtil judgeStringNull:questionListData.title_name]];
        [self.questionExpertImageOtherArray addObject:[NullUtil judgeStringNull:questionListData.heand_url]];
        [self.questionExpertSoundOtherArray addObject:[NullUtil judgeStringNull:questionListData.video_url]];
        [self.questionAudienceNumberOtherArray addObject:[NullUtil judgeStringNull:questionListData.num_no]];
        [self.questionPayStatusOtherArray addObject:[NullUtil judgeStringNull:questionListData.is_pay]];
    }
    
    [self.tableView2 reloadData];
    
    [self.tableView2.mj_header endRefreshing];
    [self.tableView2.mj_footer endRefreshing];
}

@end
