//
//  HealthSelfInspectionFixViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "SelfInspectionHeaderView.h"
#import "SelfInspectionFootView.h"
#import "SelfInspectionTiwenPopView.h"

@interface HealthSelfInspectionFixViewController : BaseViewController

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)SelfInspectionFootView *selfInspectionFootView;
@property(nonatomic,strong)UICollectionView *pictureCollectonView;
@property(nonatomic,strong)NSMutableArray *itemsSectionPictureArray;

@property (strong,nonatomic)SelfInspectionHeaderView *selfInspectionHeaderView;

@property (strong,nonatomic)NSMutableArray *shuimianGroupArray;
@property (strong,nonatomic)NSMutableArray *yinshiGroupArray;
@property (strong,nonatomic)NSMutableArray *yinshuiGroupArray;
@property (strong,nonatomic)NSMutableArray *bianzhiGroupArray;
@property (strong,nonatomic)NSMutableArray *paibianganGroupArray;
@property (strong,nonatomic)NSMutableArray *sezhiGroupArray;
@property (strong,nonatomic)NSMutableArray *painiaoganGroupArray;

@property (strong,nonatomic)NSMutableArray *hanreGroupArray;
@property (strong,nonatomic)NSMutableArray *chuhanGroupArray;

@property (strong,nonatomic)SelfInspectionTiwenPopView *selfInspectionTiwenPopView;

@property (strong,nonatomic)NSMutableArray *tiwenArray;

@end
