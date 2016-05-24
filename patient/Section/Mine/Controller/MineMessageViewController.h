//
//  MineMessageViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *messageArray;
@property (strong,nonatomic)NSMutableArray *messageIdArray;
@property (strong,nonatomic)NSMutableArray *messageTimeArray;
@property (strong,nonatomic)NSMutableArray *messageImageArray;
@property (strong,nonatomic)NSMutableArray *messageNameArray;
@property (strong,nonatomic)NSMutableArray *messageTitleArray;
@property (strong,nonatomic)NSMutableArray *messageContentArray;

@end
