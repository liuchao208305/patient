//
//  InfoMoreStudioViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface InfoMoreStudioViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *studioArray;
@property (strong,nonatomic)NSMutableArray *studioIdArray;
@property (strong,nonatomic)NSMutableArray *studioImageArray;
@property (strong,nonatomic)NSMutableArray *studioNameArray;
@property (strong,nonatomic)NSMutableArray *studioFeatureArray;

@end
