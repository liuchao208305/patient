//
//  ClinicInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ClinicInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *clinicId;

@property (strong,nonatomic)NSString *clinicName;
//@property (strong,nonatomic)NSString *couponMoney;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

-(void)sendRequestAccordingSelection:(NSInteger)selection;

//-(void)sendClinicScheduleRequest1;
//-(void)sendClinicScheduleRequest2;
//-(void)sendClinicScheduleRequest3;
//-(void)sendClinicScheduleRequest4;
//
//-(void)clinicScheduleDataParse1;
//-(void)clinicScheduleDataParse2;
//-(void)clinicScheduleDataParse3;
//-(void)clinicScheduleDataParse4;

//-(void)clinicScheduleDataFilling1;
//-(void)clinicScheduleDataFilling2;
//-(void)clinicScheduleDataFilling3;
//-(void)clinicScheduleDataFilling4;

@end
