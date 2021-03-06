//
//  ClinicInfoViewController.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicInfoViewController.h"
#import "ClinicDetailTableCell.h"
#import "ClinicExpertTableCell.h"
#import "ClinicDoctorTableCell.h"
#import "ClinicScheduleTableCell.h"
#import "ClinicHeaderView.h"
#import "TreatmentInfoViewController.h"
#import "NetworkUtil.h"
#import "NullUtil.h"
#import "DateUtil.h"
#import "HudUtil.h"
#import "AnalyticUtil.h"

@interface ClinicInfoViewController ()

@property (strong,nonatomic)UIImageView *clinicImageView;
@property (strong,nonatomic)ClinicHeaderView *clinicHeadView;

@property (strong,nonatomic)NSMutableDictionary *result;
@property (assign,nonatomic)NSInteger code;
@property (strong,nonatomic)NSString *message;
@property (strong,nonatomic)NSMutableDictionary *data;
@property (assign,nonatomic)NSError *error;

@property (strong,nonatomic)NSMutableDictionary *result2_1;
@property (assign,nonatomic)NSInteger code2_1;
@property (strong,nonatomic)NSString *message2_1;
@property (strong,nonatomic)NSMutableDictionary *data2_1;
@property (assign,nonatomic)NSError *error2_1;

@property (strong,nonatomic)NSMutableDictionary *result2_2;
@property (assign,nonatomic)NSInteger code2_2;
@property (strong,nonatomic)NSString *message2_2;
@property (strong,nonatomic)NSMutableDictionary *data2_2;
@property (assign,nonatomic)NSError *error2_2;

@property (strong,nonatomic)NSMutableDictionary *result2_3;
@property (assign,nonatomic)NSInteger code2_3;
@property (strong,nonatomic)NSString *message2_3;
@property (strong,nonatomic)NSMutableDictionary *data2_3;
@property (assign,nonatomic)NSError *error2_3;

@property (strong,nonatomic)NSMutableDictionary *result2_4;
@property (assign,nonatomic)NSInteger code2_4;
@property (strong,nonatomic)NSString *message2_4;
@property (strong,nonatomic)NSMutableDictionary *data2_4;
@property (assign,nonatomic)NSError *error2_4;

@property (strong,nonatomic)NSString *clinicImage;
@property (strong,nonatomic)NSString *clinicAdress;
@property (strong,nonatomic)NSString *clinicComment;

@property (strong,nonatomic)NSString *expertIdTest;
@property (strong,nonatomic)NSString *expertImage;
@property (strong,nonatomic)NSString *expertName;
@property (strong,nonatomic)NSString *expertTitle;
@property (strong,nonatomic)NSString *expertGroup;
@property (assign,nonatomic)double formerMoney;
@property (assign,nonatomic)double couponMoney;
@property (assign,nonatomic)double latterMoney;

@property (strong,nonatomic)NSString *defaultDoctorId;

@property (strong,nonatomic)NSString *appointmentUpTime;
@property (strong,nonatomic)NSString *appointmentDownTime;

@property (strong,nonatomic)NSString *forenoonBookStatus1;
@property (strong,nonatomic)NSString *afternoonBookStatus1;

@property (strong,nonatomic)NSString *forenoonBookStatus2;
@property (strong,nonatomic)NSString *afternoonBookStatus2;

@property (strong,nonatomic)NSString *forenoonBookStatus3;
@property (strong,nonatomic)NSString *afternoonBookStatus3;

@property (strong,nonatomic)NSString *forenoonBookStatus4;
@property (strong,nonatomic)NSString *afternoonBookStatus4;

@end

@implementation ClinicInfoViewController

#pragma mark Life Circle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBACKGROUND_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self lazyLoading];
//    [self sendClinicDoctorRequest];
    
    [self initNavBar];
    [self initTabBar];
    [self initView];
    [self initRecognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [AnalyticUtil UMBeginLogPageView:@"ClinicInfoViewController"];
    
    [self sendClinicDoctorRequest];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [AnalyticUtil UMEndLogPageView:@"ClinicInfoViewController"];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark Lazy Loading
-(void)lazyLoading{
    
}

#pragma mark Init Section
-(void)initNavBar{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 20)];
//    label.text = self.clinicName;
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont systemFontOfSize:20];
//    label.textAlignment = NSTextAlignmentCenter;
//    self.navigationItem.titleView = label;
    self.title = self.clinicName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:kWHITE_COLOR}];
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
    
    self.clinicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    [self.clinicImageView sd_setImageWithURL:[NSURL URLWithString:self.clinicImage] placeholderImage:[UIImage imageNamed:@"default_image_big"]];
    
    [self.headView addSubview:self.clinicImageView];
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
    [self.view addSubview:self.tableView];
}

-(void)initRecognizer{
    
}

#pragma mark Target Action
-(void)reservationButtonClicked{
    self.hidesBottomBarWhenPushed = YES;
    TreatmentInfoViewController *treatVC = [[TreatmentInfoViewController alloc] init];
    treatVC.expertId = self.expertId;
    treatVC.clinicId = self.clinicId;
    treatVC.doctorId = self.defaultDoctorId;
    [self.navigationController pushViewController:treatVC animated:YES];
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
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
        default:
            return 1;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
        case 1:
            return 150;
            break;
        case 2:
            return 175;
            break;
        case 3:
            return 154;
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
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 0.1;
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
    self.clinicHeadView = [[ClinicHeaderView alloc] init];
    if (section == 0|| section == 3) {
        self.clinicHeadView.titleImage.hidden = YES;
        self.clinicHeadView.titleLabel.hidden = YES;
    }
    if (section == 1) {
        [self.clinicHeadView.titleImage setImage:[UIImage imageNamed:@"info_clinic_expert_title_image"]];
        self.clinicHeadView.titleLabel.text = @"特需服务专家";
    }
    if (section == 2) {
        [self.clinicHeadView.titleImage setImage:[UIImage imageNamed:@"info_clinic_doctor_title_image"]];
        self.clinicHeadView.titleLabel.text = @"线下门诊医生";
    }
    return self.clinicHeadView;
}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellName = @"ClinicDetailTableCell";
        ClinicDetailTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ClinicDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.titleImage setImage:[UIImage imageNamed:@"info_clinic_clinic_title_image"]];
        cell.label.text = self.clinicAdress;
        
        if ([self.clinicComment integerValue] == 0) {
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>0 && [self.clinicComment integerValue]<11){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>10 && [self.clinicComment integerValue]<21){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>20 && [self.clinicComment integerValue]<31){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>30 && [self.clinicComment integerValue]<41){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>40 && [self.clinicComment integerValue]<51){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>50 && [self.clinicComment integerValue]<61){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>60 && [self.clinicComment integerValue]<71){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>70 && [self.clinicComment integerValue]<81){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_zero"]];
        }else if ([self.clinicComment integerValue]>80 && [self.clinicComment integerValue]<91){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_half"]];
        }else if ([self.clinicComment integerValue]>90 && [self.clinicComment integerValue]<101){
            [cell.starImage1 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage2 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage3 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage4 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
            [cell.starImage5 setImage:[UIImage imageNamed:@"info_expert_xingxing_full"]];
        }
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"ClinicExpertTableCell";
        ClinicExpertTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ClinicExpertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        [cell.expertImage sd_setImageWithURL:[NSURL URLWithString:self.expertImage] placeholderImage:[UIImage imageNamed:@"default_image_small"]];
        cell.expertLabel1.text = self.expertName;
        cell.expertLabel2.text = self.expertTitle;
        cell.expertLabel3.text = [NullUtil judgeStringNull:self.expertGroup];
        cell.moneyLabel1.text = [NSString stringWithFormat:@"¥ %ld",(long)self.formerMoney];
        cell.moneyLabel2.text = [NSString stringWithFormat:@"%ld",(long)self.latterMoney];
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellName = @"ClinicDoctorTableCell";
        ClinicDoctorTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ClinicDoctorTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        return cell;
    }else if (indexPath.section == 3){
        static NSString *cellName = @"ClinicScheduleTableCell";
        ClinicScheduleTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ClinicScheduleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
        
        /*
         ==============================================================================================
         */
        cell.label1_1.text = @"上午";
        cell.label1_2.text = @"预计";
        cell.label1_3.text = self.appointmentUpTime;
        if ([self.forenoonBookStatus1 integerValue] == 0) {
            [cell.button1_1 setTitle:@"预约" forState:UIControlStateNormal];
            [cell.button1_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
            [cell.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
        }else if ([self.forenoonBookStatus1 integerValue] == 1){
            [cell.button1_1 setTitle:@"已约满" forState:UIControlStateNormal];
            [cell.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }else if ([self.forenoonBookStatus1 integerValue] == 2){
            [cell.button1_1 setTitle:@"未排班" forState:UIControlStateNormal];
            [cell.button1_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button1_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }
        
        cell.label1_4.text = @"下午";
        cell.label1_5.text = @"预计";
        cell.label1_6.text = self.appointmentDownTime;
        if ([self.afternoonBookStatus1 integerValue] == 0) {
            [cell.button1_2 setTitle:@"预约" forState:UIControlStateNormal];
            [cell.button1_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
            [cell.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
        }else if ([self.afternoonBookStatus1 integerValue] == 1){
            [cell.button1_2 setTitle:@"已约满" forState:UIControlStateNormal];
            [cell.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }else if ([self.afternoonBookStatus1 integerValue] == 2){
            [cell.button1_2 setTitle:@"未排班" forState:UIControlStateNormal];
            [cell.button1_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button1_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }
        /*
         ==============================================================================================
         */
        cell.label2_1.text = @"上午";
        cell.label2_2.text = @"预计";
        cell.label2_3.text = self.appointmentUpTime;
        if ([self.forenoonBookStatus2 integerValue] == 0) {
            [cell.button2_1 setTitle:@"预约" forState:UIControlStateNormal];
            [cell.button2_1 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
            [cell.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
        }else if ([self.forenoonBookStatus2 integerValue] == 1){
            [cell.button2_1 setTitle:@"已约满" forState:UIControlStateNormal];
            [cell.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }else if ([self.forenoonBookStatus2 integerValue] == 2){
            [cell.button2_1 setTitle:@"未排班" forState:UIControlStateNormal];
            [cell.button2_1 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button2_1 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }
        
        cell.label2_4.text = @"下午";
        cell.label2_5.text = @"预计";
        cell.label2_6.text = self.appointmentDownTime;
        if ([self.afternoonBookStatus1 integerValue] == 0) {
            [cell.button2_2 setTitle:@"预约" forState:UIControlStateNormal];
            [cell.button2_2 setTitleColor:kMAIN_COLOR forState:UIControlStateNormal];
            [cell.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
        }else if ([self.afternoonBookStatus1 integerValue] == 1){
            [cell.button2_2 setTitle:@"已约满" forState:UIControlStateNormal];
            [cell.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }else if ([self.afternoonBookStatus1 integerValue] == 2){
            [cell.button2_2 setTitle:@"未排班" forState:UIControlStateNormal];
            [cell.button2_2 setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
            [cell.button2_2 setBackgroundImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
        }

        /*
         ==============================================================================================
         */
        
        /*
         ==============================================================================================
         */
        
        [cell.button1_2 addTarget:self action:@selector(reservationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        case 3:
            
            break;
        default:
            break;
    }
}

#pragma mark Network Request
-(void)sendClinicDoctorRequest{
    DLog(@"sendClinicDoctorRequest");
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDAnimationFade;
    hud.labelText = kNetworkStatusLoadingText;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.clinicId forKey:@"outpatId"];
    [parameter setValue:self.expertId forKey:@"doctorId"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_DOCTOR_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.result = (NSMutableDictionary *)responseObject;
        
        self.code = [[self.result objectForKey:@"code"] integerValue];
        self.message = [self.result objectForKey:@"message"];
        self.data = [self.result objectForKey:@"data"];
        
        if (self.code == kSUCCESS) {
            [self clinicDoctorDataParse];
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


-(void)sendRequestAccordingSelection:(NSInteger)selection{
//    ClinicScheduleTableCell *cell = [[ClinicScheduleTableCell alloc] init];
    static NSString *cellName = @"ClinicScheduleTableCell";
    ClinicScheduleTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[ClinicScheduleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    switch (selection) {
        case 0:
            DLog(@"此处应该进行第一个选项卡的数据填充");
            DLog(@"forenoonBookStatus1-->%@afternoonBookStatus1-->%@",self.forenoonBookStatus1,self.afternoonBookStatus1);
//            [cell initBackView1];
//            [cell.backUpView2 removeFromSuperview];
//            [cell.backDownView2 removeFromSuperview];
//            [cell.backUpView3 removeFromSuperview];
//            [cell.backDownView3 removeFromSuperview];
//            [cell.backUpView4 removeFromSuperview];
//            [cell.backDownView4 removeFromSuperview];
            break;
        case 1:
            DLog(@"此处应该进行第二个选项卡的数据填充");
            DLog(@"forenoonBookStatus2-->%@afternoonBookStatus2-->%@",self.forenoonBookStatus2,self.afternoonBookStatus2);
//            [cell initBackView2];
//            [cell.backUpView1 removeFromSuperview];
//            [cell.backDownView1 removeFromSuperview];
//            [cell.backUpView3 removeFromSuperview];
//            [cell.backDownView3 removeFromSuperview];
//            [cell.backUpView4 removeFromSuperview];
//            [cell.backDownView4 removeFromSuperview];
            
//            cell.backUpView1.backgroundColor = [UIColor redColor];
//            cell.backDownView1.backgroundColor = [UIColor redColor];
            break;
        case 2:
            DLog(@"此处应该进行第三个选项卡的数据填充");
            DLog(@"forenoonBookStatus3-->%@afternoonBookStatus3-->%@",self.forenoonBookStatus3,self.afternoonBookStatus3);
//            [cell initBackView3];
//            [cell.backUpView1 removeFromSuperview];
//            [cell.backDownView1 removeFromSuperview];
//            [cell.backUpView2 removeFromSuperview];
//            [cell.backDownView2 removeFromSuperview];
//            [cell.backUpView4 removeFromSuperview];
//            [cell.backDownView4 removeFromSuperview];
            break;
        case 3:
            DLog(@"此处应该进行第四个选项卡的数据填充");
            DLog(@"forenoonBookStatus4-->%@afternoonBookStatus4-->%@",self.forenoonBookStatus4,self.afternoonBookStatus4);
//            [cell initBackView4];
//            [cell.backUpView1 removeFromSuperview];
//            [cell.backDownView1 removeFromSuperview];
//            [cell.backUpView2 removeFromSuperview];
//            [cell.backDownView2 removeFromSuperview];
//            [cell.backUpView3 removeFromSuperview];
//            [cell.backDownView3 removeFromSuperview];
            break;
        default:
            break;
    }
}

-(void)sendClinicScheduleRequest1{
    DLog(@"sendClinicScheduleRequest1");
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getFirstTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result2_1 = (NSMutableDictionary *)responseObject;
        
        self.code2_1 = [[self.result2_1 objectForKey:@"code"] integerValue];
        self.message2_1 = [self.result2_1 objectForKey:@"message"];
        self.data2_1 = [self.result2_1 objectForKey:@"data"];
        
        if (self.code2_1 == kSUCCESS) {
            [self clinicScheduleDataParse1];
        }else{
            DLog(@"%@",self.message2_1);
        }
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

-(void)sendClinicScheduleRequest2{
    DLog(@"sendClinicScheduleRequest2");
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getSecondTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result2_2 = (NSMutableDictionary *)responseObject;
        
        self.code2_2 = [[self.result2_2 objectForKey:@"code"] integerValue];
        self.message2_2 = [self.result2_2 objectForKey:@"message"];
        self.data2_2 = [self.result2_2 objectForKey:@"data"];
        
        if (self.code2_2 == kSUCCESS) {
            [self clinicScheduleDataParse2];
        }else{
            DLog(@"%@",self.message2_2);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

-(void)sendClinicScheduleRequest3{
    DLog(@"sendClinicScheduleRequest3");
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getThirdTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result2_3 = (NSMutableDictionary *)responseObject;
        
        self.code2_3 = [[self.result2_3 objectForKey:@"code"] integerValue];
        self.message2_3 = [self.result2_3 objectForKey:@"message"];
        self.data2_3 = [self.result2_3 objectForKey:@"data"];
        
        if (self.code2_3 == kSUCCESS) {
            [self clinicScheduleDataParse3];
        }else{
            DLog(@"%@",self.message2_3);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}

-(void)sendClinicScheduleRequest4{
    DLog(@"sendClinicScheduleRequest4");
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:self.defaultDoctorId forKey:@"minDoctorId"];
    [parameter setValue:self.expertId forKey:@"maxDoctorId"];
    [parameter setValue:[DateUtil getFourthTime] forKey:@"date"];
    
    [[NetworkUtil sharedInstance] postResultWithParameter:parameter url:[NSString stringWithFormat:@"%@%@",kServerAddress,kJZK_SCHEDULE_INFORMATION] successBlock:^(NSURLSessionDataTask *task,id responseObject){
        DLog(@"responseObject-->%@",responseObject);
        self.result2_4 = (NSMutableDictionary *)responseObject;
        
        self.code2_4 = [[self.result2_4 objectForKey:@"code"] integerValue];
        self.message2_4 = [self.result2_4 objectForKey:@"message"];
        self.data2_4 = [self.result2_4 objectForKey:@"data"];
        
        if (self.code2_4 == kSUCCESS) {
            [self clinicScheduleDataParse4];
        }else{
            DLog(@"%@",self.message2_4);
        }
        
    }failureBlock:^(NSURLSessionDataTask *task,NSError *error){
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        DLog(@"errorStr-->%@",errorStr);
    }];
}



#pragma mark Data Parse
-(void)clinicDoctorDataParse{
    
    self.clinicImage = [[self.data objectForKey:@"outpats"] objectForKey:@"coverUrl"];
    self.clinicAdress = [[self.data objectForKey:@"outpats"] objectForKey:@"address"];
    self.clinicComment = [[self.data objectForKey:@"outpats"] objectForKey:@"commonResult"];
    self.couponMoney = [[[self.data objectForKey:@"outpats"] objectForKey:@"money"] doubleValue];
    
    self.expertIdTest = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"doctor_id"];
    self.expertImage = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"heandUrl"];
    self.expertName = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"doctorName"];
    self.expertTitle = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"zhicheng"];
    if (![[self.data objectForKey:@"zhuanjia"] objectForKey:@"orgName"]) {
        self.expertGroup = [[self.data objectForKey:@"zhuanjia"] objectForKey:@"orgName"];
    }
    self.formerMoney = [[[self.data objectForKey:@"zhuanjia"] objectForKey:@"serviceMoney"] doubleValue];
    self.latterMoney = self.formerMoney - self.couponMoney;
    
    self.defaultDoctorId = [self.data objectForKey:@"default_doctorId"];
    
    self.appointmentUpTime = [[self.data objectForKey:@"outpats"] objectForKey:@"up_date"];
    self.appointmentDownTime = [[self.data objectForKey:@"outpats"] objectForKey:@"down_date"];
    
    [self sendClinicScheduleRequest1];
    [self sendClinicScheduleRequest2];
    [self sendClinicScheduleRequest3];
    [self sendClinicScheduleRequest4];
    
    [self.tableView reloadData];
}

-(void)clinicScheduleDataParse1{
    self.forenoonBookStatus1 = [self.data2_1 objectForKey:@"up"];
    self.afternoonBookStatus1 = [self.data2_1 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus1-->%@afternoonBookStatus1-->%@",self.forenoonBookStatus1,self.afternoonBookStatus1);
    
//    [self.tableView reloadData];
}

-(void)clinicScheduleDataParse2{
    self.forenoonBookStatus2 = [self.data2_2 objectForKey:@"up"];
    self.afternoonBookStatus2 = [self.data2_2 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus2-->%@afternoonBookStatus2-->%@",self.forenoonBookStatus2,self.afternoonBookStatus2);
    
//    [self.tableView reloadData];
}

-(void)clinicScheduleDataParse3{
    self.forenoonBookStatus3 = [self.data2_3 objectForKey:@"up"];
    self.afternoonBookStatus3 = [self.data2_3 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus3-->%@afternoonBookStatus3-->%@",self.forenoonBookStatus3,self.afternoonBookStatus3);
    
//    [self.tableView reloadData];
}

-(void)clinicScheduleDataParse4{
    self.forenoonBookStatus4 = [self.data2_4 objectForKey:@"up"];
    self.afternoonBookStatus4 = [self.data2_4 objectForKey:@"down"];
    
    DLog(@"forenoonBookStatus4-->%@afternoonBookStatus4-->%@",self.forenoonBookStatus4,self.afternoonBookStatus4);
    
//    [self.tableView reloadData];
}

@end
