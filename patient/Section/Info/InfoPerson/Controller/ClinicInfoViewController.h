//
//  ClinicInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ClinicInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *clinicName;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@end
