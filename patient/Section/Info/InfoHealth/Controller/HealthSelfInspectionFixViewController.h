//
//  HealthSelfInspectionFixViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfInspectionHeaderView.h"

@interface HealthSelfInspectionFixViewController : BaseViewController

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)SelfInspectionHeaderView *selfInspectionHeaderView;

@property (strong,nonatomic)NSMutableArray *shuimianGroupArray;
@property (strong,nonatomic)NSMutableArray *yinshiGroupArray;
@property (strong,nonatomic)NSMutableArray *yinshuiGroupArray;
@property (strong,nonatomic)NSMutableArray *bianzhiGroupArray;
@property (strong,nonatomic)NSMutableArray *paibianganGroupArray;
@property (strong,nonatomic)NSMutableArray *sezhiGroupArray;
@property (strong,nonatomic)NSMutableArray *painiaoganGroupArray;

@property (strong,nonatomic)NSMutableArray *daixiaqiweiGroupArray;
@property (strong,nonatomic)NSMutableArray *daixiazhidiGroupArray;
@property (strong,nonatomic)NSMutableArray *yuejingjingliangGroupArray;
@property (strong,nonatomic)NSMutableArray *yuejingzhidiGroupArray;

@property (strong,nonatomic)NSMutableArray *hanreGroupArray;
@property (strong,nonatomic)NSMutableArray *chuhanGroupArray;

@end
