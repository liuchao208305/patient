//
//  TestViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestViewController.h"
#import "NetworkUtil.h"
#import "HudUtil.h"
#import "QuestionData.h"
#import "TestQuestionTableCell.h"
#import "NullUtil.h"

@interface TestViewController ()<QuestionDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableArray *data;
@property (assign,nonatomic)NSError *error;

@property (assign,nonatomic)NSInteger answeredQuestionQuantity;

@end

@implementation TestViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.answeredQuestionQuantity = 0;
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self sendTestInfoRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.questionArray = [NSMutableArray array];
    self.questionGroupIdArray = [NSMutableArray array];
    self.questionItemIdArray = [NSMutableArray array];
    self.questionItemNameArray = [NSMutableArray array];
    self.questionItemStarArray = [NSMutableArray array];
    self.questionItemRepeatArray = [NSMutableArray array];
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image.png"] forBarMetrics:(UIBarMetricsDefault)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = @"测体质";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
}

-(void)initTabBar{
    [self setHidesBottomBarWhenPushed:NO];
}

-(void)initView{
    self.topFixedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
    self.topFixedView.backgroundColor = kWHITE_COLOR;
    [self.view addSubview:self.topFixedView];
    
    self.presentationLabel1 = [[UILabel alloc] init];
    self.presentationLabel1.text = @"请根据最近一年的体验和感觉";
    self.presentationLabel1.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.presentationLabel1];
    
    self.presentationLabel2 = [[UILabel alloc] init];
    self.presentationLabel2.text = @"回答以下问题";
    self.presentationLabel2.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.presentationLabel2];
    
    self.quantityLabel = [[UILabel alloc] init];
    self.quantityLabel.text = @"0/60";
    self.quantityLabel.textAlignment = NSTextAlignmentRight;
    self.quantityLabel.textColor = [UIColor lightGrayColor];
    [self.topFixedView addSubview:self.quantityLabel];
    
    [self.presentationLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topFixedView).offset(15);
        make.top.equalTo(self.topFixedView).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.height.mas_equalTo(15);
    }];
    
    [self.presentationLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.presentationLabel1).offset(0);
        make.bottom.equalTo(self.topFixedView).offset(-15);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.height.mas_equalTo(15);
    }];
    
    [self.quantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.topFixedView).offset(-15);
        make.centerY.equalTo(self.presentationLabel1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(15);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75+10, SCREEN_WIDTH, SCREEN_HEIGHT-75-10-STATUS_BAR_HEIGHT-STATUS_AND_NAVIGATION_HEIGHT-30) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.questionArray.count == 0 ? 0 :self.questionArray.count;
    return 20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellName = @"TestQuestionTableCell";
//    TestQuestionTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//    if (!cell) {
//        cell = [[TestQuestionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }
    TestQuestionTableCell *cell = [[TestQuestionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.questionDelegate = self;
    
//    cell.quesionLabel.text = self.questionItemNameArray[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark QuestionDelegate
-(void)changeAnsweredQuestionQuantity:(BOOL)flag{
    if (flag) {
        self.answeredQuestionQuantity += 1;
        DLog(@"%ld",(long)self.answeredQuestionQuantity);
        self.quantityLabel.text = [NSString stringWithFormat:@"%ld/60",(long)self.answeredQuestionQuantity];
    }
}

#pragma mark Network Request
-(void)sendTestInfoRequest{
    DLog(@"sendTestInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:@"60" forKey:@"pageSize"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_TEST_INFORMATION_GET] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
//            [self testInfoDataParse];
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
-(void)testInfoDataParse{
    self.questionArray = [QuestionData mj_objectArrayWithKeyValuesArray:self.data];
    for (QuestionData *questionData in self.questionArray) {
        [self.questionGroupIdArray addObject:[NullUtil judgeStringNull:questionData.group_id]];
        [self.questionItemIdArray addObject:[NullUtil judgeStringNull:questionData.item_id]];
        [self.questionItemNameArray addObject:[NullUtil judgeStringNull:questionData.item_name]];
        [self.questionItemStarArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)questionData.is_item]]];
        [self.questionItemRepeatArray addObject:[NullUtil judgeStringNull:[NSString stringWithFormat:@"%ld",(long)questionData.repeat_like]]];
    }
    
    [self.tableView reloadData];
}

@end
