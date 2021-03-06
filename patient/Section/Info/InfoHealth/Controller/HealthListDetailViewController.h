//
//  HealthListDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "HealthListHeaderView.h"

@protocol HealthListDelegate <NSObject>

-(void)healthListChoosed:(NSString *)hid time:(NSString *)time type:(NSString *)type;

@end

@interface HealthListDetailViewController : BaseViewController

@property (strong,nonatomic)NSString *sourceVC;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)HealthListHeaderView *healthListHeaderView;

@property (strong,nonatomic)NSMutableArray *healthListDetailArray;
@property (strong,nonatomic)NSMutableArray *healthListDetailIdArray;
@property (strong,nonatomic)NSMutableArray *healthListDetailTimeArray;
@property (strong,nonatomic)NSMutableArray *healthListDetailResultArray;
@property (strong,nonatomic)NSMutableArray *healthListDetailPhotoArray;

@property (weak,nonatomic)id<HealthListDelegate> healthListDelegate;

@end
