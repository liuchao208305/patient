//
//  MineViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderHeadView.h"
#import "RecordHeaderView.h"

@interface MineViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UIImageView *backImageView;
@property (strong,nonatomic)UIButton *leftButton;
@property (strong,nonatomic)UIButton *rightButton;
@property (strong,nonatomic)UIImageView *patientImageView;
@property (strong,nonatomic)UILabel *patientLabel;

@property (strong,nonatomic)NSMutableArray *recordArray;
@property (strong,nonatomic)NSMutableArray *recordIdArray;
@property (strong,nonatomic)NSMutableArray *recordImageArray;
@property (strong,nonatomic)NSMutableArray *recordNameArray;
@property (strong,nonatomic)NSMutableArray *recordPatientNameArray;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)OrderHeadView *orderHeadView;
@property (strong,nonatomic)RecordHeaderView *recordHeaderView;

@property (strong,nonatomic)UIView *bottomBackView;

@end
