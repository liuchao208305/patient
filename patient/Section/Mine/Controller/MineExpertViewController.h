//
//  MineExpertViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineExpertViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *expertArray;
@property (strong,nonatomic)NSMutableArray *expertIdArray;
@property (strong,nonatomic)NSMutableArray *expertImageArray;
@property (strong,nonatomic)NSMutableArray *expertNameArray;
@property (strong,nonatomic)NSMutableArray *expertTitleArray;
@property (strong,nonatomic)NSMutableArray *expertUnitArray;
@property (strong,nonatomic)NSMutableArray *expertFlagArray;

@end
