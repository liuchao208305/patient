//
//  MineExpertFixViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineExpertFixViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *expertArray;
@property (strong,nonatomic)NSMutableArray *expertIdArray;
@property (strong,nonatomic)NSMutableArray *expertImageArray;
@property (strong,nonatomic)NSMutableArray *expertNameArray;
@property (strong,nonatomic)NSMutableArray *expertTitleArray;
@property (strong,nonatomic)NSMutableArray *expertUnitArray;
@property (strong,nonatomic)NSMutableArray *expertDepartArray;
@property (strong,nonatomic)NSMutableArray *expertDetailArray;
@property (strong,nonatomic)NSMutableArray *expertShanchangArray;
//@property (strong,nonatomic)NSMutableArray *expertAnswerArray;
//@property (strong,nonatomic)NSMutableArray *expertFocusArray;

@end
