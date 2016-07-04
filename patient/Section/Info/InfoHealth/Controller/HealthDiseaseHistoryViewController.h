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

@property (assign,nonatomic)int hunfou;
@property (assign,nonatomic)int erzi;
@property (assign,nonatomic)int nver;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)SelfInspectionHeaderView *selfInspectionHeaderView;

@end
