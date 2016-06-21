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
    
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];
//    self.title = @"问答";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的问答",@"其他问答",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 156, 32);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kWHITE_COLOR;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
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
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
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
    self.tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
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
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
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
        
        cell.contentLabel.text = @"昨天去游泳了，时间可能有点长，大概有三个小时，今天大腿内前侧酸痛，走路都有些不是太方便，怎么减轻酸痛？";
        [cell.publicImageView setImage:[UIImage imageNamed:@"question_list_public_flag_image"]];
        
        cell.expertLabel.text = @"有卫平 ｜ 省立同德 主任中医师";
        [cell.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
        [cell.expertSoundImageView setImage:[UIImage imageNamed:@"info_person_mr_record_image"]];
        cell.expertSoundLengthLabel.text = @"43''";
        cell.audienceNumberLabel.text = @"999人已听";
        
//        cell.payStatusLabel.text = @"test";
//        [cell.deleteButton setTitle:@"test" forState:UIControlStateNormal];
//        [cell.deleteButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
//        [cell.confirmButton setTitle:@"test" forState:UIControlStateNormal];
//        [cell.confirmButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        cell.payStatusLabel.hidden = YES;
        cell.deleteButton.hidden = YES;
        cell.confirmButton.hidden = YES;
        
        return cell;
    }else if (self.flag2){
        static NSString *cellName = @"QuestionTableCell";
        QuestionListTableCell *cell = [self.tableView2 dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[QuestionListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.contentLabel.text = @"昨天去游泳了，时间可能有点长，大概有三个小时，今天大腿内前侧酸痛，走路都有些不是太方便，怎么减轻酸痛？";
        [cell.publicImageView setImage:[UIImage imageNamed:@"question_list_public_flag_image"]];
        
//        cell.expertLabel.text = @"test";
//        [cell.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
//        [cell.expertSoundImageView setImage:[UIImage imageNamed:@"default_image_small"]];
//        cell.expertSoundLengthLabel.text = @"test";
//        cell.audienceNumberLabel.text = @"test";
        cell.expertLabel.hidden = YES;
        cell.expertImageView.hidden = YES;
        cell.expertSoundImageView.hidden = YES;
        cell.expertSoundLengthLabel.hidden = YES;
        cell.audienceNumberLabel.hidden = YES;
        
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
    
    self.pageSize1 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage1] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize1] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_QUESTION_LIST_MINE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_QUESTION_LIST_MINE_INFORMATION);
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
    
    self.pageSize2 += 10;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.currentPage2] forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize2] forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_QUESTION_LIST_OTHER_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"%@%@",kServerAddress,kJZK_COUPON_INFORMATION);
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
}

-(void)questionCheckDataParse2{
    DLog(@"questionCheckDataParse2");
}

@end
