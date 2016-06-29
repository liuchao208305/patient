//
//  HealthSelfInspectionViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfInspectionHeaderViewOne.h"
#import "SelfInspectionHeaderViewTwo.h"

@interface HealthSelfInspectionViewController : BaseViewController

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)SelfInspectionHeaderViewOne *selfInspectionHeaderViewOne;
@property (strong,nonatomic)SelfInspectionHeaderViewTwo *selfInspectionHeaderViewTwo;

@end
