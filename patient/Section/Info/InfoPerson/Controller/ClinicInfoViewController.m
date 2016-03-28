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

@interface ClinicInfoViewController ()

@property (strong,nonatomic)UIImageView *clinicImage;
@property (strong,nonatomic)ClinicHeaderView *clinicHeadView;

@end

@implementation ClinicInfoViewController

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
    
}

#pragma mark Init Section
-(void)initNavBar{
    
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
    
    self.clinicImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    [self.clinicImage setImage:[UIImage imageNamed:@"default_image_big"]];
    
    [self.headView addSubview:self.clinicImage];
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
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellName = @"ClinicExpertTableCell";
        ClinicExpertTableCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[ClinicExpertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        //填充数据
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
        
        
        [cell.button2 addTarget:self action:@selector(reservationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
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

#pragma mark Data Parse

@end
