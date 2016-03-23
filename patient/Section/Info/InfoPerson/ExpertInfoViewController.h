//
//  ExpertInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpertHeadView.h"
#import "ExpertFootView.h"

@interface ExpertInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)ExpertHeadView *expertHeadView;
@property (strong,nonatomic)ExpertFootView *expertFootView;

@end
