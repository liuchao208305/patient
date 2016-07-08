//
//  HealthDiseaseHistoryViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfInspectionHeaderView.h"

@interface HealthDiseaseHistoryViewController : BaseViewController

@property (strong,nonatomic)NSString *sourceVC;

@property (strong,nonatomic)NSString *diseaseHistoryId;

@property (assign,nonatomic)int marryStatus;
@property (assign,nonatomic)int erziCount;
@property (assign,nonatomic)int nverCount;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)SelfInspectionHeaderView *selfInspectionHeaderView;

@end
