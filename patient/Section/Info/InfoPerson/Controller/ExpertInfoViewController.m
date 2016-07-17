//
//  ExpertInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertInfoViewController.h"
#import "ExpertDetailTableCell.h"
#import "ExpertAdvantageTableCell.h"
#import "ExpertAdvantageFixTableCell.h"
#import "TextEntity.h"
#import "ExpertCommentTableCell.h"
#import "ExpertProcessTableCell.h"
#import "ExpertClinicTableCell.h"
#import "FMGVideoPlayView.h"
#import "FullViewController.h"
#import "NetworkUtil.h"
#import "ExpertCommentData.h"
#import "NullUtil.h"
#import "ExpertClinicData.h"
#import "ClinicInfoViewController.h"
#import "LoginViewController.h"
#import "CommonUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"
#import "ClinicInfoFixViewController.h"
#import "QuestionInquiryViewController.h"
#import "BookInfoViewController.h"

@interface ExpertInfoViewController ()<FiterViewClickDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2;
@property (assign,nonatomic)NSInteger code2;
@property (strong,nonatomic)NSString *message2;
@property (strong,nonatomic)NSMutableArray *data2;
@property (assign,nonatomic)NSError *error2;

@property (strong,nonatomic)NSMutableDictionary *result3;
@property (assign,nonatomic)NSInteger code3;
@property (strong,nonatomic)NSString *message3;
@property (strong,nonatomic)NSMutableDictionary *data3;
@property (assign,nonatomic)NSError *error3;

//@property (strong,nonatomic)FMGVideoPlayView *playView;
//@property (strong,nonatomic)NSString *videoUrl;
//
//@property (strong,nonatomic)NSString *detailLabel1;
//@property (strong,nonatomic)NSString *detailLabel2;
//@property (strong,nonatomic)NSString *detailLabel3;
//@property (assign,nonatomic)int detailNumber;
//@property (strong,nonatomic)NSString *detailNumberFix;
//@property (assign,nonatomic)BOOL isFocused;
//@property (strong,nonatomic)NSString *detailMoney;
//
//@property (strong,nonatomic)NSString *advantageLabel1;
//@property (strong,nonatomic)NSString *advantageLabel2;
//@property (strong,nonatomic)NSString *advantageLabel3;
//@property (strong,nonatomic)NSString *advantageLabel4;
//
//@property(nonatomic, strong)NSMutableArray   *dataArr;
//
//@property (assign,nonatomic)NSInteger currentPage;
//@property (assign,nonatomic)NSInteger pageSize;
//@property (strong,nonatomic)NSString *shaixuanType;

@property (strong,nonatomic)FMGVideoPlayView *playView;
@property (strong,nonatomic)NSString *videoUrlFix;

@property (strong,nonatomic)NSString *expertImageString;
@property (strong,nonatomic)NSString *expertNameString;
@property (strong,nonatomic)NSString *expertTitleString1;
@property (strong,nonatomic)NSString *expertTitleString2;
@property (strong,nonatomic)NSString *expertUnitString;
@property (strong,nonatomic)NSString *expertDepartString;

@property (assign,nonatomic)double expertMoney1;
@property (assign,nonatomic)double expertMoney2;

@property (assign,nonatomic)int expertFocus;
@property (assign,nonatomic)int expertService;

@property (strong,nonatomic)NSString *shanchang;
@property (strong,nonatomic)NSString *jianjie;

@property (strong,nonatomic)NSMutableArray *dataArr;

@property (assign,nonatomic)BOOL isFocused;

@property (assign,nonatomic)BOOL isConsulted;

@property (assign,nonatomic)BOOL isBooked;

@end

@implementation ExpertInfoViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    
    [self initNavBar];
    [self initTabBar];
//    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"ExpertInfoViewController"];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.longtitude = [NSString stringWithFormat:@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:kJZK_longitude]];
    self.latitude = [NSString stringWithFormat:@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:kJZK_latitude]];
    
    [self sendExpertInfoRequestFix];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"ExpertInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    self.commentArray = [NSMutableArray array];
    self.commentExpertIdArray = [NSMutableArray array];
    self.commemtImageArray = [NSMutableArray array];
    self.commentPatientArray = [NSMutableArray array];
    self.commentExpertArray = [NSMutableArray array];
    self.commentPraiseArray = [NSMutableArray array];
    
    self.clinicArray = [NSMutableArray array];
    self.clinicIdArray = [NSMutableArray array];
    self.clinicNameArray = [NSMutableArray array];
    self.clinicAddressArray = [NSMutableArray array];
    self.clinicStarArray = [NSMutableArray array];
    self.clinicDistanceArray = [NSMutableArray array];
    self.clinicMoneyArray = [NSMutableArray array];
    self.clinicCouponArray = [NSMutableArray array];
    
//    self.dataArr = [NSMutableArray array];
    
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"TextInfo" ofType:@"json"];
//    NSString *jsonContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    if (jsonContent != nil)
//    {
//        NSData *jsonData = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                                   options:NSJSONReadingMutableContainers
//                                                                     error:&err];
//        NSArray *textList = [dic objectForKey:@"textList"];
//        for (NSDictionary *dict in textList)
//        {
//            TextEntity *entity = [[TextEntity alloc]initWithDict:dict];
//            if (entity)
//            {
//                [self.dataArr addObject:entity];
//            }
//        }
//        if(err)
//        {
//            NSLog(@"json解析失败：%@",err);
//        }
//    }
}

#pragma mark Init Section
-(void)initNavBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_background_image"] forBarMetrics:(UIBarMetricsDefault)];   
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = self.expertName;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title = self.expertName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
    
    if ([self.sourceVC isEqualToString:@"ScanViewController"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"< 返回" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClicked)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
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
    
    self.playView = [FMGVideoPlayView videoPlayView];
    self.playView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3);
    self.playView.contrainerViewController = self;
    
    [self.headView addSubview:self.playView];
}

-(void)initFootView{
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT-45) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (![self.videoUrlFix isEqualToString:@""]) {
        self.tableView.tableHeaderView = self.headView;
    }
    self.tableView.tableFooterView = self.footView;
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self sendClinicInfoRequest:self.fiterType];
//    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initBottomView{
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.size.height-1, SCREEN_WIDTH, 1)];
    self.bottomLineView.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.view addSubview:self.bottomLineView];
    
    self.focusBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.tableView.size.height, SCREEN_WIDTH/5*1, 55)];
    [self.focusBackView setBackgroundColor:ColorWithHexRGB(0xeeeeee)];
    [self.view addSubview:self.focusBackView];
    
    self.focusImageView = [[UIImageView alloc] init];
    [self.focusBackView addSubview:self.focusImageView];
    
    self.focusLabel = [[UILabel alloc] init];
    self.focusLabel.font = [UIFont systemFontOfSize:12];
    self.focusLabel.textAlignment = NSTextAlignmentCenter;
    [self.focusBackView addSubview:self.focusLabel];
    
    [self.focusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.focusBackView).offset(8);
        make.centerX.equalTo(self.focusBackView).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [self.focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.focusBackView).offset(-8);
        make.centerX.equalTo(self.focusBackView).offset(0);
    }];
    
    self.inquiryBackView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*1, self.tableView.size.height, SCREEN_WIDTH/5*2, 55)];
//    [self.inquiryBackView setBackgroundColor:ColorWithHexRGB(0xf5f5f5)];
    [self.view addSubview:self.inquiryBackView];
    
    self.inquiryImageView = [[UIImageView alloc] init];
    [self.inquiryBackView addSubview:self.inquiryImageView];
    
    self.inquiryLabel = [[UILabel alloc] init];
    self.inquiryLabel.font = [UIFont systemFontOfSize:14];
    [self.inquiryBackView addSubview:self.inquiryLabel];
    
    [self.inquiryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inquiryBackView).offset(-20-5);
        make.centerY.equalTo(self.inquiryBackView).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.inquiryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.inquiryBackView).offset(40+5);
        make.centerY.equalTo(self.inquiryBackView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    self.bookBackView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5*3, self.tableView.size.height, SCREEN_WIDTH/5*2, 55)];
//    [self.bookBackView setBackgroundColor:ColorWithHexRGB(0x0fcf41)];
    [self.view addSubview:self.bookBackView];
    
    self.bookImageView = [[UIImageView alloc] init];
    [self.bookBackView addSubview:self.bookImageView];
    
    self.bookLabel = [[UILabel alloc] init];
    self.bookLabel.font = [UIFont systemFontOfSize:14];
//    self.bookLabel.textColor = kWHITE_COLOR;
    [self.bookBackView addSubview:self.bookLabel];
    
    [self.bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bookBackView).offset(-20-5);
        make.centerY.equalTo(self.bookBackView).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.bookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bookBackView).offset(40+5);
        make.centerY.equalTo(self.bookBackView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
//    [self.inquiryImageView setImage:[UIImage imageNamed:@"info_expert_inquiry_image"]];
//    self.inquiryLabel.text = @"问问";
//    [self.bookImageView setImage:[UIImage imageNamed:@"info_expert_book_image"]];
//    self.bookLabel.text = @"预约";
}

-(void)initRecognizer{
    self.focusBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *focusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusButtonClicked:)];
    [self.focusBackView addGestureRecognizer:focusTap];
}

#pragma mark Target Action
-(void)backButtonClicked{
    DLog(@"backButtonClicked");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)focusButtonClicked:(BOOL)isFocus{
    DLog(@"focusButtonClicked");
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] isEqualToString:@""]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navController animated:YES completion:nil];
    }else{
        [self sendExpertFocusRequest:@"1"];
    }
}

-(void)focusViewClicked{
    DLog(@"focusViewClicked");
}

-(void)inquiryViewClicked{
    DLog(@"inquiryViewClicked");
    QuestionInquiryViewController *inquiryVC = [[QuestionInquiryViewController alloc] init];
    inquiryVC.isForSpecialDoctor = YES;
    inquiryVC.expertId = self.expertId;
    [self.navigationController pushViewController:inquiryVC animated:YES];
}

-(void)bookViewClicked{
    DLog(@"bookViewClicked");
    BookInfoViewController *bookInfoVC = [[BookInfoViewController alloc] init];
    bookInfoVC.expertId = self.expertId;
    [self.navigationController pushViewController:bookInfoVC animated:YES];
}

-(void)stretchButtonClicked{
    DLog(@"stretchButtonClicked");
}

-(void)filterViewClicked{
    DLog(@"filterViewClicked");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择筛选条件"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"最近医院", @"服务最佳",@"价格最低",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0){
//        self.expertHeadView.fiterLabel.text = @"最近医院";
//        self.fiterType = 1;
//        [self sendClinicInfoRequest:self.fiterType];
//    }else if (buttonIndex == 1){
//        self.expertHeadView.fiterLabel.text = @"服务最佳";
//        self.fiterType = 2;
//        [self sendClinicInfoRequest:self.fiterType];
//    }else if(buttonIndex == 2){
//        self.expertHeadView.fiterLabel.text = @"价格最低";
//        self.fiterType = 3;
//        [self sendClinicInfoRequest:self.fiterType];
//    }else if (buttonIndex == 3){
//        
//    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }
//    else if (section == 2){
//        return 1;
//    }else if (section == 3){
//        return 1;
//    }
//    else if (section == 2){
//        return self.clinicArray.count;
//    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        return 120;
        return 190;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
//            return 98;
//            return 74;
            return 95;
        }
//        else if (indexPath.row == 1){
//            return 74;
//        }else if (indexPath.row == 2){
//            return 74;
//        }
    else if (indexPath.row == 1){
//            return 185;
            TextEntity *entity = nil;
//            if ([self.dataArr count] > indexPath.row)
//            {
//                entity = [self.dataArr objectAtIndex:0];
//            }
            
            entity = [self.dataArr objectAtIndex:0];
            
            //根据isShowMoreText属性判断cell的高度
            if (entity.isShowMoreText)
            {
                return [ExpertAdvantageFixTableCell cellMoreHeight:entity];
            }
            else
            {
                return [ExpertAdvantageFixTableCell cellDefaultHeight:entity];
            }
            return 0;
        }
    }
//    else if (indexPath.section == 2){
//        return 106;
//    }else if (indexPath.section == 3){
//        return 200;
//    }
//    else if (indexPath.section == 2){
//        return 150;
//    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    self.expertHeadView = [[ExpertHeadView alloc] init];
//    self.expertHeadView.tag = section;
//    if (section == 2) {
//        self.expertHeadView.fiterViewClickDelegate = self;
//        
//        if (self.fiterType == 1) {
//            self.expertHeadView.fiterLabel.text = @"最近医院";
//        }else if (self.fiterType == 2){
//            self.expertHeadView.fiterLabel.text = @"服务最佳";
//        }else if (self.fiterType == 3){
//            self.expertHeadView.fiterLabel.text = @"价格最低";
//        }
//        
//    }else{
//        self.expertHeadView.fiterView.hidden = YES;
//    }
//    return self.expertHeadView;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    self.expertFootView = [[ExpertFootView alloc] init];
//    self.expertFootView.tag = section;
//    if (section == 1) {
//        
//    }else{
//        self.expertFootView.button.hidden = YES;
//    }
//    return self.expertFootView;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString *cellName = @"ExpertDetailTableCell";
        ExpertDetailTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ExpertDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        [cell.expertImageView sd_setImageWithURL:[NSURL URLWithString:self.expertImageString] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.expertNameLabel.text = self.expertNameString;
        cell.expertTitleLabel1.text = self.expertTitleString1;
        cell.expertTitleLabel2.text = self.expertTitleString2;
        cell.expertUnitLabel.text = self.expertUnitString;
        cell.expertDepartLabel.text = self.expertDepartString;
        
        [cell.expertMoneyImageView1 setImage:[UIImage imageNamed:@"info_expert_info_money_image1"]];
        cell.expertMoneyLabel1_1.text = @"咨询费 ¥";
        cell.expertMoneyLabel1_2.text = [NSString stringWithFormat:@"%.2f",self.expertMoney1];
        cell.expertMoneyLabel1_3.text = @"元";
        [cell.expertMoneyImageView2 setImage:[UIImage imageNamed:@"info_expert_info_money_image2"]];
        cell.expertMoneyLabel2_1.text = @"预约费 ¥";
        cell.expertMoneyLabel2_2.text = [NSString stringWithFormat:@"%.2f",self.expertMoney2];
        cell.expertMoneyLabel2_3.text = @"元";
        
        [cell.expertFocusImageView setImage:[UIImage imageNamed:@"info_expert_info_focus_image"]];
        cell.expertFocusLabel.text = [NSString stringWithFormat:@"关注数  %d",self.expertFocus];
        [cell.expertServiceImageView setImage:[UIImage imageNamed:@"info_expert_info_service_image"]];
        cell.expertServiceLabel.text = [NSString stringWithFormat:@"服务人次  %d",self.expertService];
        
        //填充数据
//        cell.label1_1.text = [NullUtil judgeStringNull:self.detailLabel1];
//        cell.label1_2.text = [NullUtil judgeStringNull:self.detailLabel2];
//        cell.label1_3.text = [NullUtil judgeStringNull:self.detailLabel3];
//        if (self.detailNumber == 1) {
//            //已关注
//            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_selected"] forState:UIControlStateNormal];
//            cell.label2_1.text = @"已关注";
//        }else{
//            //未关注
//            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_normal"] forState:UIControlStateNormal];
//            cell.label2_1.text = @"未关注";
//        }
        
//        if (self.isFocused == YES) {
//            //已关注
//            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_selected"] forState:UIControlStateNormal];
//            cell.label2_1.text = @"已关注";
//        }else if(self.isFocused == NO){
//            //未关注
//            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_normal"] forState:UIControlStateNormal];
//            cell.label2_1.text = @"关注";
//        }
        
//        [cell.button addTarget:self action:@selector(focusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        
//        cell.lable3_1.text = @"特需服务费";
//        cell.lable3_2.text = [NullUtil judgeStringNull:[NSString stringWithFormat:@"¥ %@",self.detailMoney]];
        
        return cell;
    }else if (indexPath.section == 1){
//        static NSString *cellName = @"ExpertAdvantageTableCell";
//        ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
        //填充数据
        if (indexPath.row == 0) {
//            static NSString *cellName = @"ExpertAdvantageTableCell";
//            ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//            if (!cell) {
//                cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            }
//            
//            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_zhuzhi_image"]];
//            cell.titleLabel.text = @"主治";
//            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel1];
//            
//            return cell;
            
            static NSString *cellName = @"ExpertAdvantageTableCell";
            ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_zhuzhi_image"]];
            cell.titleLabel.text = @"擅长";
            if (![self.shanchang isEqualToString:@""]) {
                cell.bodyLabel.text = self.shanchang;
            }else{
                 cell.bodyLabel.text = @"暂无";
            }
           
            return cell;
        }
//        else if (indexPath.row == 1){
//            static NSString *cellName = @"ExpertAdvantageTableCell";
//            ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//            if (!cell) {
//                cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            }
//            
//            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_shanchang_image"]];
//            cell.titleLabel.text = @"擅长";
//            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel2];
//            
//            return cell;
//        }else if (indexPath.row == 2){
//            static NSString *cellName = @"ExpertAdvantageTableCell";
//            ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//            if (!cell) {
//                cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//            }
//            
//            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_yanjiufangxiang_image"]];
//            cell.titleLabel.text = @"研究方向";
//            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel3];
//            
//            return cell;
//        }
        else if (indexPath.row == 1){
            static NSString *cellName = @"ExpertAdvantageFixTableCell";
            ExpertAdvantageFixTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
            if (!cell) {
                cell = [[ExpertAdvantageFixTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            }
            
//            if ([self.dataArr count] > indexPath.row)
//            {
//                //这里的判断是为了防止数组越界
////                cell.entity = [self.dataArr objectAtIndex:indexPath.row];
//                cell.entity = [self.dataArr objectAtIndex:0];
//            }
            
            cell.entity = [self.dataArr objectAtIndex:0];
            //自定义cell的回调，获取要展开/收起的cell。刷新点击的cell
            cell.showMoreTextBlock = ^(UITableViewCell *currentCell){
                NSIndexPath *indexRow = [self.tableView indexPathForCell:currentCell];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
            return cell;
            
//            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_jingli_image"]];
//            cell.titleLabel.text = @"经历";
//            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel4];
//            [cell.button setImage:[UIImage imageNamed:@"info_expert_xiangxia_image"] forState:UIControlStateNormal];
//            [cell.button addTarget:self action:@selector(stretchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
//        return cell;
    }
//    else if (indexPath.section == 2){
//        static NSString *cellName = @"ExpertCommentTableCell";
//        ExpertCommentTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[ExpertCommentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        //填充数据
//        
//        return cell;
//    }else if (indexPath.section == 3){
//        static NSString *cellName = @"ExpertProcessTableCell";
//        ExpertProcessTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[ExpertProcessTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        //填充数据
//        cell.ProcessLabel.text = @"看病流程介绍图";
//        [cell.ProcessImageView setImage:[UIImage imageNamed:@"default_image_big"]];
//        
//        return cell;
//    }
//    else if (indexPath.section == 2){
//        static NSString *cellName = @"ExpertClinicTableCell";
//        ExpertClinicTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
//        if (!cell) {
//            cell = [[ExpertClinicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        }
//        
//        
//        
//        //填充数据
//        for (int i = 0; i<self.clinicArray.count; i++) {
//            cell.label1.text = self.clinicNameArray[indexPath.row];
//            
//            if (![[self.data2[indexPath.row] objectForKey:@"address"] isEqualToString:@""]) {
//                cell.label2.text = [self.data2[indexPath.row] objectForKey:@"address"];
//            }
//            
//            if ([self.clinicStarArray[indexPath.row] integerValue] == 0) {
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>0 && [self.clinicStarArray[indexPath.row] integerValue]<11){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>10 && [self.clinicStarArray[indexPath.row] integerValue]<21){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>20 && [self.clinicStarArray[indexPath.row] integerValue]<31){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>30 && [self.clinicStarArray[indexPath.row] integerValue]<41){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>40 && [self.clinicStarArray[indexPath.row] integerValue]<51){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>50 && [self.clinicStarArray[indexPath.row] integerValue]<61){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>60 && [self.clinicStarArray[indexPath.row] integerValue]<71){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>70 && [self.clinicStarArray[indexPath.row] integerValue]<81){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>80 && [self.clinicStarArray[indexPath.row] integerValue]<91){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
//            }else if ([self.clinicStarArray[indexPath.row] integerValue]>90 && [self.clinicStarArray[indexPath.row] integerValue]<101){
//                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
//            }
//            
//            cell.label3.text = [NSString stringWithFormat:@"距离%@km",self.clinicDistanceArray[indexPath.row]];
//            cell.label4.text = @"特需服务费";
//            cell.label5.text = [NSString stringWithFormat:@"¥ %@",self.detailMoney];
//            
////            if ([self.clinicCouponArray[indexPath.row] integerValue] == 0) {
////                cell.couponButton.hidden = YES;
////            }else{
////                [cell.couponButton setTitle:[NSString stringWithFormat:@"立减%@元",self.clinicCouponArray[indexPath.row]] forState:UIControlStateNormal];
////            }
//            
//            [cell.couponButton setTitle:[NSString stringWithFormat:@"立减%@元",self.clinicCouponArray[indexPath.row]] forState:UIControlStateNormal];
//        }
//        
//        return cell;
//    }
    return nil;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 2) {
////        ClinicInfoViewController *clincInfoVC = [[ClinicInfoViewController alloc] init];
////        clincInfoVC.expertId = self.expertId;
////        clincInfoVC.clinicId = self.clinicIdArray[indexPath.row];
////        
////        clincInfoVC.clinicName = self.clinicNameArray[indexPath.row];
//////        clincInfoVC.couponMoney = self.clinicCouponArray[indexPath.row];
////        [self.navigationController pushViewController:clincInfoVC animated:YES];
//        
//        ClinicInfoFixViewController *clincInfoFixVC = [[ClinicInfoFixViewController alloc] init];
//        clincInfoFixVC.expertId = self.expertId;
//        clincInfoFixVC.clinicId = self.clinicIdArray[indexPath.row];
//        
//        clincInfoFixVC.clinicName = self.clinicNameArray[indexPath.row];
//        [self.navigationController pushViewController:clincInfoFixVC animated:YES];
//    }
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

#pragma mark Network Request
-(void)sendExpertInfoRequestFix{
    DLog(@"sendExpertInfoRequestFix");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.expertId forKey:@"doctor_id"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    
    [[NetworkUtil sharedInstance] getResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_EXPERT_INFORMATION_FIX] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self expertInfoDataParseFix];
        }else{
            DLog(@"%@",self.message);
            [HudUtil showSimpleTextOnlyHUD:self.message withDelaySeconds:kHud_DelayTime];
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

-(void)sendExpertInfoRequest{
    DLog(@"sendExpertInfoRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.expertId forKey:@"doctorId"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_EXPERT_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
//            [self expertInfoDataParse];
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

//-(void)sendClinicInfoRequest:(NSUInteger)type{
//    DLog(@"sendClinicInfoRequest");
//    
//    self.pageSize += 10;
//    
//    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [parameter setValue:self.latitude forKey:@"x"];
//    [parameter setValue:self.longtitude forKey:@"y"];
//    [parameter setValue:@"1" forKey:@"currentPage"];
//    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
//    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.fiterType] forKey:@"type"];
//    
//    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CLINIC_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
//        DLog(@"responseObject-->%@",responseObject);
//        self.result2 = (NSMutableDictionary *)responseObject;
//        
//        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
//        self.message2 = [self.result2 objectForKey:@"message"];
//        self.data2 = [self.result2 objectForKey:@"data"];
//        
//        if (self.code2 == kSUCCESS) {
//            [self clinicInfoDataParse];
//        }else{
//            
//        }
//        
//    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
//        NSString *errorStr2 = [error.userInfo objectForKey:@"NSLocalizedDescription"];
//        DLog(@"errorStr2-->%@",errorStr2);
//    }];
//}

-(void)sendExpertFocusRequest:(NSString *)type{
    DLog(@"sendExpertFocusRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.expertId forKey:@"doctor_id"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] forKey:@"token"];
    [parameter setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_userId] forKey:@"user_id"];
    [parameter setValue:type forKey:@"type"];
    
    DLog(@"parameter-->%@",parameter);
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_EXPERT_FOCUS] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        DLog(@"responseObject-->%@",responseObject);
        self.result3 = (NSMutableDictionary *)responseObject;
        
        self.code3 = [[self.result3 objectForKey:@"code"] integerValue];
        self.message3 = [self.result3 objectForKey:@"message"];
        self.data3 = [self.result3 objectForKey:@"data"];
        
        if (self.code3 == kSUCCESS) {
            self.isFocused = !self.isFocused;
            DLog(@"self.isFocused-->%@",self.isFocused ? @"YES" : @"NO");
            if (self.isFocused == YES) {
//                [HudUtil showSimpleTextOnlyHUD:@"关注成功！" withDelaySeconds:kHud_DelayTime];
            }else if (self.isFocused == NO){
//                [HudUtil showSimpleTextOnlyHUD:@"取消关注成功！" withDelaySeconds:kHud_DelayTime];
            }
            
            [self sendExpertInfoRequestFix];
        }else{
            DLog(@"%@",self.message3);
            if (self.code3 == kTOKENINVALID) {
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
-(void)expertInfoDataParseFix{
    self.videoUrlFix = [NullUtil judgeStringNull:[self.data objectForKey:@"introduce_url"]];
    [self.playView setUrlString:self.videoUrlFix];
    
    self.expertImageString = [NullUtil judgeStringNull:[self.data objectForKey:@"heand_url"]];
    self.expertNameString = [NullUtil judgeStringNull:[self.data objectForKey:@"doctor_name"]];
    self.expertTitleString1 = [NullUtil judgeStringNull:[self.data objectForKey:@"title_name"]];
    self.expertTitleString2 = [NullUtil judgeStringNull:[self.data objectForKey:@"touxian"]];
    self.expertUnitString = [NullUtil judgeStringNull:[self.data objectForKey:@"company"]];
    self.expertDepartString = [NullUtil judgeStringNull:[self.data objectForKey:@"depart_name"]];
    
    self.expertMoney1 = [[self.data objectForKey:@"consultation_money"] doubleValue];
    self.expertMoney2 = [[self.data objectForKey:@"money"] doubleValue];
    
    self.expertFocus = [[self.data objectForKey:@"atteations"] intValue];
    self.expertService = [[self.data objectForKey:@"conus"] intValue];
    
    self.shanchang = [NullUtil judgeStringNull:[self.data objectForKey:@"shanchang"]];
    self.jianjie = [NullUtil judgeStringNull:[self.data objectForKey:@"doctor_descr"]];
    
    TextEntity *entity = [[TextEntity alloc]initWithTextName:@"简介" textContent:self.jianjie];
    //    [self.dataArr addObject:entity];
    self.dataArr = [NSMutableArray arrayWithObjects:entity, nil];
    
    if ([[self.data objectForKey:@"is_atteation"] intValue] == 0) {
        self.isFocused = NO;
        
        if ([self.sourceVC isEqualToString:@"ScanViewController"]) {
            [self sendExpertFocusRequest:@"3"];
        }
    }else if ([[self.data objectForKey:@"is_atteation"] intValue] == 1) {
        self.isFocused = YES;
    }
    
    if ([[self.data objectForKey:@"is_inter"] intValue] == 2) {
        self.isConsulted = NO;
    }else if ([[self.data objectForKey:@"is_inter"] intValue] == 1) {
        self.isConsulted = YES;
    }
    
    if ([[self.data objectForKey:@"is_yuyue"] intValue] == 2) {
        self.isBooked = NO;
    }else if ([[self.data objectForKey:@"is_yuyue"] intValue] == 1) {
        self.isBooked = YES;
    }
    
    

    [self initView];
    
    [self.tableView reloadData];
    
    [self expertInfoDataFillingFix];
}

//-(void)expertInfoDataParse{
//    self.videoUrl = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"vedioURL"];
//    [self.playView setUrlString:self.videoUrl];
//    
//    self.detailLabel1 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"doctor_name"];
//    self.detailLabel2 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"title_name"];
//    self.detailLabel3 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"org_name"];
//    
////    self.detailNumber = [[self.data objectForKey:@"docotrDetail"] integerForKey:@"atteation"];
////    if (self.detailNumber == 0) {
////        self.isFocused = NO;
////    }else if (self.detailNumber == 1) {
////        self.isFocused = YES;
////    }
//    
//    self.detailNumber = [[[self.data objectForKey:@"docotrDetail"] objectForKey:@"attention"] intValue];
//    if (self.detailNumber == 0) {
//        self.isFocused = NO;
//    }else if (self.detailNumber == 1) {
//        self.isFocused = YES;
//    }
//
//    self.detailMoney = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"money"];
//    
//    self.advantageLabel1 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"mainly"];
//    self.advantageLabel2 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"diseaseName"];
//    self.advantageLabel3 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"research"];
//    self.advantageLabel4 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"exper"];
//    DLog(@"self.advantageLabel4-->%@",self.advantageLabel4);
//    
//    TextEntity *entity = [[TextEntity alloc]initWithTextName:@"经历" textContent:self.advantageLabel4];
////    [self.dataArr addObject:entity];
//    self.dataArr = [NSMutableArray arrayWithObjects:entity, nil];
//    
//    self.commentArray = [ExpertCommentData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"comments"]];
//    for (ExpertCommentData *commentData in self.commentArray) {
//        [self.commentExpertIdArray addObject:[NullUtil judgeStringNull:commentData.doctor_id]];
//        [self.commentPatientArray addObject:[NullUtil judgeStringNull:commentData.user_name]];
//        [self.commentExpertArray addObject:[NullUtil judgeStringNull:commentData.doctor_name]];
//        [self.commentPraiseArray addObject:[NullUtil judgeStringNull:commentData.flag_name]];
//    }
//    
//    if (!self.fiterType) {
//        self.fiterType = 1;
//        [self sendClinicInfoRequest:self.fiterType];
//    }
//    
//    [self expertInfoDataFilling];
//}

-(void)clinicInfoDataParse{
    self.clinicArray = [ExpertClinicData mj_objectArrayWithKeyValuesArray:self.data2];
    [self.clinicIdArray removeAllObjects];
    [self.clinicNameArray removeAllObjects];
    [self.clinicStarArray removeAllObjects];
    [self.clinicDistanceArray removeAllObjects];
    [self.clinicCouponArray removeAllObjects];
    for (ExpertClinicData *clinicData in self.clinicArray) {
        [self.clinicIdArray addObject:clinicData.outpat_id];
        [self.clinicNameArray addObject:clinicData.outpat_name];
        [self.clinicStarArray addObject:clinicData.commenResult];
        [self.clinicDistanceArray addObject:[NSString stringWithFormat:@"%.1f",clinicData.juli/1000]];
        [self.clinicCouponArray addObject:[NSString stringWithFormat:@"%ld",(long)clinicData.money]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark Data Filling
-(void)expertInfoDataFillingFix{
    if (self.isFocused == YES) {
        //已关注
        [self.focusImageView setImage:[UIImage imageNamed:@"info_expert_guanzhu_selected"]];
        self.focusLabel.text = @"已关注";
    }else if(self.isFocused == NO){
        //未关注
        [self.focusImageView setImage:[UIImage imageNamed:@"info_expert_guanzhu_normal"]];
        self.focusLabel.text = @"关注";
    }
    
    if (self.isConsulted == YES) {
        //可提问
        self.inquiryBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *inquiryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inquiryViewClicked)];
        [self.inquiryBackView addGestureRecognizer:inquiryTap];
        [self.inquiryBackView setBackgroundColor:ColorWithHexRGB(0xf5f5f5)];
        [self.inquiryImageView setImage:[UIImage imageNamed:@"info_expert_inquiry_image"]];
        self.inquiryLabel.text = @"问问";
    }else if(self.isConsulted == NO){
        //不可提问
        self.inquiryBackView.userInteractionEnabled = NO;
        self.inquiryBackView.backgroundColor = ColorWithHexRGB(0xdddddd);
        [self.inquiryImageView setImage:[UIImage imageNamed:@"info_expert_inquiry_image_no"]];
        self.inquiryLabel.text = @"不可问问";
        self.inquiryLabel.textColor = ColorWithHexRGB(0xa2a2a2);
    }
    
    if (self.isBooked == YES) {
        //可预约
        self.bookBackView.userInteractionEnabled = YES;
        UITapGestureRecognizer *bookTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bookViewClicked)];
        [self.bookBackView addGestureRecognizer:bookTap];
        [self.bookBackView setBackgroundColor:ColorWithHexRGB(0x0fcf41)];
        [self.bookImageView setImage:[UIImage imageNamed:@"info_expert_book_image"]];
        self.bookLabel.text = @"预约";
        self.bookLabel.textColor = kWHITE_COLOR;
    }else if(self.isBooked == NO){
        //不可预约
        self.bookBackView.userInteractionEnabled = NO;
        self.bookBackView.backgroundColor = ColorWithHexRGB(0xdddddd);
        [self.bookImageView setImage:[UIImage imageNamed:@"info_expert_book_image_no"]];
        self.bookLabel.text = @"不可预约";
        self.bookLabel.textColor = ColorWithHexRGB(0xa2a2a2);
    }
}

-(void)expertInfoDataFilling{
    if (self.isFocused == YES) {
        //已关注
        [self.focusImageView setImage:[UIImage imageNamed:@"info_expert_guanzhu_selected"]];
        self.focusLabel.text = @"已关注";
    }else if(self.isFocused == NO){
        //未关注
        [self.focusImageView setImage:[UIImage imageNamed:@"info_expert_guanzhu_normal"]];
        self.focusLabel.text = @"关注";
    }
}

@end
