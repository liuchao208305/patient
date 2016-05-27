//
//  RecordListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/26.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *recordId;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *recordArray;
@property (strong,nonatomic)NSMutableArray *recordIdArray;
@property (strong,nonatomic)NSMutableArray *recordIdFixArray;
@property (strong,nonatomic)NSMutableArray *recordTimeArray;
@property (strong,nonatomic)NSMutableArray *recordExpertNameArray;
@property (strong,nonatomic)NSMutableArray *recordExpertImageArray;
@property (strong,nonatomic)NSMutableArray *recordDoctorNameArray;
@property (strong,nonatomic)NSMutableArray *recordDoctorImageArray;
@property (strong,nonatomic)NSMutableArray *recordMoneyArray;
@property (strong,nonatomic)NSMutableArray *recordSymptomArray;
@property (strong,nonatomic)NSMutableArray *testIdArray;
@property (strong,nonatomic)NSMutableArray *testTimeArray;
@property (strong,nonatomic)NSMutableArray *testImageArray;
@property (strong,nonatomic)NSMutableArray *testMainTizhiArray;
@property (strong,nonatomic)NSMutableArray *testTrendTizhiArray;

@end
