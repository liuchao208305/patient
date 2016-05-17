//
//  InfoMoreHealthViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface InfoMoreHealthViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *healthArray;
@property (strong,nonatomic)NSMutableArray *healthTypeArray;
@property (strong,nonatomic)NSMutableArray *healthIdArray;
@property (strong,nonatomic)NSMutableArray *healthImageArray;
@property (strong,nonatomic)NSMutableArray *healthNameArray;
@property (strong,nonatomic)NSMutableArray *healthPropertyArray;
@property (strong,nonatomic)NSMutableArray *healthFunctionArray;
@property (strong,nonatomic)NSMutableArray *healthCommentArray;

@end
