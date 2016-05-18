//
//  InfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoHeaderView.h"

@interface InfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)InfoHeaderView *infoHeadView;

@property (strong,nonatomic)UIImageView *timeImage;
@property (strong,nonatomic)UILabel *timeLabel;

@property (strong,nonatomic)NSMutableArray *localImageArray;
@property (strong,nonatomic)NSMutableArray *adArray;
@property (strong,nonatomic)NSMutableArray *adIdArray;
@property (strong,nonatomic)NSMutableArray *adUrlArray;
@property (strong,nonatomic)NSMutableArray *adImageArray;

@property (strong,nonatomic)NSMutableArray *diseaseArray;
@property (strong,nonatomic)NSMutableArray *diseaseIdArray;
@property (strong,nonatomic)NSMutableArray *diseaseImageArray;
@property (strong,nonatomic)NSMutableArray *diseaseLabelArray;

@property (strong,nonatomic)NSMutableArray *healthArray;
@property (strong,nonatomic)NSMutableArray *healthTypeArray;
@property (strong,nonatomic)NSMutableArray *healthIdArray;
@property (strong,nonatomic)NSMutableArray *healthImageArray;
@property (strong,nonatomic)NSMutableArray *healthNameArray;
@property (strong,nonatomic)NSMutableArray *healthSeasonArray;

//@property (strong,nonatomic)NSMutableArray *studioArray;
//@property (strong,nonatomic)NSMutableArray *studioImageArray;
//@property (strong,nonatomic)NSMutableArray *studioLableArray;

@property (strong,nonatomic)NSMutableArray *personArray;
@property (strong,nonatomic)NSMutableArray *personIdArray;
@property (strong,nonatomic)NSMutableArray *personImageArray;
@property (strong,nonatomic)NSMutableArray *personLable1Array;
@property (strong,nonatomic)NSMutableArray *personLable2Array;

@end
