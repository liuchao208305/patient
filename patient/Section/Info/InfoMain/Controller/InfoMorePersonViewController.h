//
//  InfoMorePersonViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface InfoMorePersonViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *sourceVC;
@property (strong,nonatomic)NSString *departID;

@property (strong,nonatomic)UIView *searchView;
@property (strong,nonatomic)UIView *cityViewFix;
@property (strong,nonatomic)UILabel *cityLabel;
@property (strong,nonatomic)UIImageView *cityImage;

@property (strong,nonatomic)UIView *cityView;

@property (strong,nonatomic)UIView *citySubView1;
@property (strong,nonatomic)UILabel *label1;
@property (strong,nonatomic)UIView *shuLineView1;
@property (strong,nonatomic)UIView *citySubView2;
@property (strong,nonatomic)UILabel *label2;
@property (strong,nonatomic)UIView *shuLineView2;
@property (strong,nonatomic)UIView *citySubView3;
@property (strong,nonatomic)UILabel *label3;
@property (strong,nonatomic)UIView *shuLineView3;
@property (strong,nonatomic)UIView *citySubView4;
@property (strong,nonatomic)UILabel *label4;
@property (strong,nonatomic)UIView *shuLineView4;
@property (strong,nonatomic)UIView *citySubView5;
@property (strong,nonatomic)UILabel *label5;
@property (strong,nonatomic)UIView *shuLineView5;
@property (strong,nonatomic)UIView *citySubView6;
@property (strong,nonatomic)UILabel *label6;
@property (strong,nonatomic)UIImageView *imageView6;

@property (strong,nonatomic)UIView *hengLineView;

@property (strong,nonatomic)UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *expertArray;
@property (strong,nonatomic)NSMutableArray *expertIdArray;
@property (strong,nonatomic)NSMutableArray *expertImageArray;
@property (strong,nonatomic)NSMutableArray *expertNameArray;
@property (strong,nonatomic)NSMutableArray *expertTitleArray;
@property (strong,nonatomic)NSMutableArray *expertUnitArray;
@property (strong,nonatomic)NSMutableArray *expertStopFlagArray;
@property (strong,nonatomic)NSMutableArray *expertFlagArray;
@property (strong,nonatomic)NSMutableArray *expertFlagNameArray;
@property (strong,nonatomic)NSMutableArray *expertFlagNumberArray;

@end
