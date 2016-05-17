//
//  HealthInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface HealthInfoViewController : BaseViewController

@property (assign,nonatomic)NSInteger healthType;
@property (strong,nonatomic)NSString *healthId;
@property (strong,nonatomic)NSString *healthName;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)UIView *bottomView;

@end
