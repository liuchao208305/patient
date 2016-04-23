//
//  TestViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TestViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UIView *topFixedView;
@property (strong,nonatomic)UILabel *presentationLabel1;
@property (strong,nonatomic)UILabel *presentationLabel2;
@property (strong,nonatomic)UILabel *quantityLabel;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *questionArray;
@property (strong,nonatomic)NSMutableArray *questionGroupIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemIdArray;
@property (strong,nonatomic)NSMutableArray *questionItemNameArray;
@property (strong,nonatomic)NSMutableArray *questionItemStarArray;
@property (strong,nonatomic)NSMutableArray *questionItemRepeatArray;

@end
