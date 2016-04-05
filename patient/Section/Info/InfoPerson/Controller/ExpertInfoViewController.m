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

@interface ExpertInfoViewController ()

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

@property (strong,nonatomic)FMGVideoPlayView *playView;
@property (strong,nonatomic)NSString *videoUrl;

@property (strong,nonatomic)NSString *detailLabel1;
@property (strong,nonatomic)NSString *detailLabel2;
@property (strong,nonatomic)NSString *detailLabel3;
@property (assign,nonatomic)NSInteger detailNumber;
@property (strong,nonatomic)NSString *detailMoney;

@property (strong,nonatomic)NSString *advantageLabel1;
@property (strong,nonatomic)NSString *advantageLabel2;
@property (strong,nonatomic)NSString *advantageLabel3;
@property (strong,nonatomic)NSString *advantageLabel4;

@property (assign,nonatomic)NSInteger currentPage;
@property (assign,nonatomic)NSInteger pageSize;
@property (strong,nonatomic)NSString *shaixuanType;

@end

@implementation ExpertInfoViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
    [self sendExpertInfoRequest];
    [self sendClinicInfoRequest];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.longtitude = [NSString stringWithFormat:@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:kJZK_longitude]];
    self.latitude = [NSString stringWithFormat:@"%f",[[NSUserDefaults standardUserDefaults] floatForKey:kJZK_latitude]];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
}

#pragma mark Init Section
-(void)initNavBar{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
    label.text = self.expertName;
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-140+STATUS_AND_NAVIGATION_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self sendClinicInfoRequest];
    }];
    
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)focusButtonClicked:(BOOL)isFocus{
    if ([CommonUtil judgeIsLoginSuccess] == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return 1;
    }else if (section == 4){
        return self.clinicArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 98;
        }else if (indexPath.row == 1){
            return 74;
        }else if (indexPath.row == 2){
            return 74;
        }else if (indexPath.row == 3){
            return 185;
        }
    }else if (indexPath.section == 2){
        return 106;
    }else if (indexPath.section == 3){
        return 200;
    }else if (indexPath.section == 4){
        return 150;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else if (section == 1){
        return 0.1;
    }else if (section == 2){
        return 0.1;
    }else if (section == 3){
        return 0.1;
    }else if (section == 4){
        return 46;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.expertHeadView = [[ExpertHeadView alloc] init];
    self.expertHeadView.tag = section;
    if (section == 4) {
        
    }else{
        self.expertHeadView.fiterView.hidden = YES;
    }
    return self.expertHeadView;
}

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
        //填充数据
        cell.label1_1.text = [NullUtil judgeStringNull:self.detailLabel1];
        cell.label1_2.text = [NullUtil judgeStringNull:self.detailLabel2];
        cell.label1_3.text = [NullUtil judgeStringNull:self.detailLabel3];
        if (self.detailNumber == 1) {
            //已关注
            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_selected"] forState:UIControlStateNormal];
            cell.label2_1.text = @"已关注";
        }else{
            //未关注
            [cell.button setImage:[UIImage imageNamed:@"info_expert_guanzhu_normal"] forState:UIControlStateNormal];
            cell.label2_1.text = @"未关注";
        }
        
        [cell.button addTarget:self action:@selector(focusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lable3_1.text = @"特需服务费";
        cell.lable3_2.text = [NSString stringWithFormat:@"¥ %@",self.detailMoney];
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"ExpertAdvantageTableCell";
        ExpertAdvantageTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ExpertAdvantageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        if (indexPath.row == 0) {
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_zhuzhi_image"]];
            cell.titleLabel.text = @"主治";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel1];
        }else if (indexPath.row == 1){
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_shanchang_image"]];
            cell.titleLabel.text = @"擅长";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel2];
        }else if (indexPath.row == 2){
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_yanjiufangxiang_image"]];
            cell.titleLabel.text = @"研究方向";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel3];
        }else if (indexPath.row == 3){
            [cell.titleImageView setImage:[UIImage imageNamed:@"info_expert_jingli_image"]];
            cell.titleLabel.text = @"经历";
            cell.bodyLabel.text = [NullUtil judgeStringNull:self.advantageLabel4];
            [cell.button setImage:[UIImage imageNamed:@"info_expert_xiangxia_image"] forState:UIControlStateNormal];
        }
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"ExpertCommentTableCell";
        ExpertCommentTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ExpertCommentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"ExpertProcessTableCell";
        ExpertProcessTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ExpertProcessTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        cell.ProcessLabel.text = @"看病流程介绍图";
        [cell.ProcessImageView setImage:[UIImage imageNamed:@"default_image_big"]];
        
        return cell;
    }else if (indexPath.section == 4){
        static NSString *cellName = @"ExpertClinicTableCell";
        ExpertClinicTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ExpertClinicTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        for (int i = 0; i<self.clinicArray.count; i++) {
            cell.label1.text = self.clinicNameArray[indexPath.row];
            
            if (![[self.data2[indexPath.row] objectForKey:@"address"] isEqualToString:@""]) {
                cell.label2.text = [self.data2[indexPath.row] objectForKey:@"address"];
            }
            
            if ([self.clinicStarArray[indexPath.row] integerValue] == 0) {
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>0 && [self.clinicStarArray[indexPath.row] integerValue]<11){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>10 && [self.clinicStarArray[indexPath.row] integerValue]<21){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>20 && [self.clinicStarArray[indexPath.row] integerValue]<31){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>30 && [self.clinicStarArray[indexPath.row] integerValue]<41){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>40 && [self.clinicStarArray[indexPath.row] integerValue]<51){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>50 && [self.clinicStarArray[indexPath.row] integerValue]<61){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>60 && [self.clinicStarArray[indexPath.row] integerValue]<71){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>70 && [self.clinicStarArray[indexPath.row] integerValue]<81){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>80 && [self.clinicStarArray[indexPath.row] integerValue]<91){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
            }else if ([self.clinicStarArray[indexPath.row] integerValue]>90 && [self.clinicStarArray[indexPath.row] integerValue]<101){
                [cell.starImageView1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
                [cell.starImageView5 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            }
            
            cell.label3.text = [NSString stringWithFormat:@"距离%@km",self.clinicDistanceArray[indexPath.row]];
            cell.label4.text = @"特需服务费";
            cell.label5.text = [NSString stringWithFormat:@"¥ %@",self.detailMoney];
            [cell.couponButton setTitle:[NSString stringWithFormat:@"立减%@元",self.clinicCouponArray[indexPath.row]] forState:UIControlStateNormal];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        self.hidesBottomBarWhenPushed = YES;
        ClinicInfoViewController *clincInfoVC = [[ClinicInfoViewController alloc] init];
        clincInfoVC.expertId = self.expertId;
        clincInfoVC.clinicId = self.clinicIdArray[indexPath.row];
        clincInfoVC.clinicName = self.clinicNameArray[indexPath.row];
//        clincInfoVC.couponMoney = self.clinicCouponArray[indexPath.row];
        [self.navigationController pushViewController:clincInfoVC animated:YES];
    }
}

#pragma mark Network Request
-(void)sendExpertInfoRequest{
    DLog(@"sendExpertInfoRequest");
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.expertId forKey:@"doctorId"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_EXPERT_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self expertInfoDataParse];
        }else{
            
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

-(void)sendClinicInfoRequest{
    DLog(@"sendClinicInfoRequest");
    
    self.pageSize += 10;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.longtitude forKey:@"x"];
    [parameter setValue:self.latitude forKey:@"y"];
    [parameter setValue:@"1" forKey:@"currentPage"];
    [parameter setValue:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameter setValue:@"1" forKey:@"type"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_CLINIC_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result2 = (NSMutableDictionary *)responseObject;
        
        self.code2 = [[self.result2 objectForKey:@"code"] integerValue];
        self.message2 = [self.result2 objectForKey:@"message"];
        self.data2 = [self.result2 objectForKey:@"data"];
        
        if (self.code2 == kSUCCESS) {
            [self clinicInfoDataParse];
        }else{
            
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr2 = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr2-->%@",errorStr2);
    }];
}

#pragma mark Data Parse
-(void)expertInfoDataParse{
    self.videoUrl = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"vedioURL"];
    [self.playView setUrlString:self.videoUrl];
    
    self.detailLabel1 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"doctor_name"];
    self.detailLabel2 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"title_name"];
    self.detailLabel3 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"org_name"];
    self.detailNumber = [[self.data objectForKey:@"docotrDetail"] integerForKey:@"atteation"];
    self.detailMoney = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"money"];
    
    self.advantageLabel1 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"mainly"];
    self.advantageLabel2 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"diseaseName"];
    self.advantageLabel3 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"research"];
    self.advantageLabel4 = [[self.data objectForKey:@"docotrDetail"] objectForKey:@"exper"];
    
    self.commentArray = [ExpertCommentData mj_objectArrayWithKeyValuesArray:[self.data objectForKey:@"comments"]];
    for (ExpertCommentData *commentData in self.commentArray) {
        [self.commentExpertIdArray addObject:commentData.doctor_id];
        [self.commentPatientArray addObject:commentData.user_name];
        [self.commentExpertArray addObject:commentData.doctor_name];
        [self.commentPraiseArray addObject:commentData.flag_name];
    }
    
    [self.tableView reloadData];
}

-(void)clinicInfoDataParse{
    self.clinicArray = [ExpertClinicData mj_objectArrayWithKeyValuesArray:self.data2];
    for (ExpertClinicData *clinicData in self.clinicArray) {
        [self.clinicIdArray addObject:clinicData.outpat_id];
        [self.clinicNameArray addObject:clinicData.outpat_name];
        [self.clinicStarArray addObject:clinicData.commenResult];
        [self.clinicDistanceArray addObject:[NSString stringWithFormat:@"%.1f",clinicData.juli]];
        [self.clinicCouponArray addObject:[NSString stringWithFormat:@"%ld",(long)clinicData.money]];
    }
    
    [self.tableView reloadData];
    
    [self.tableView.mj_footer endRefreshing];
}

@end
