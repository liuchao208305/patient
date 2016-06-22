//
//  QuestionViewController.h
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface QuestionListViewController : BaseViewController

@property (strong,nonatomic)UISegmentedControl *segmentedControl;

@property (strong,nonatomic)UIView *questionView;
@property (strong,nonatomic)UILabel *questionLabel;
@property (strong,nonatomic)UIImageView *questionImage;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;

@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;

@property (strong,nonatomic)NSMutableArray *questionMineArray;
@property (strong,nonatomic)NSMutableArray *questionIdMineArray;
@property (strong,nonatomic)NSMutableArray *questionStatusMineArray;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusMineArray;
@property (strong,nonatomic)NSMutableArray *questionContentMineArray;
@property (strong,nonatomic)NSMutableArray *questionExpertNameMineArray;
@property (strong,nonatomic)NSMutableArray *questionExpertUnitMineArray;
@property (strong,nonatomic)NSMutableArray *questionExpertTitleMineArray;
@property (strong,nonatomic)NSMutableArray *questionExpertImageMineArray;
@property (strong,nonatomic)NSMutableArray *questionExpertSoundMineArray;
@property (strong,nonatomic)NSMutableArray *questionAudienceNumberMineArray;
@property (strong,nonatomic)NSMutableArray *questionPayStatusMineArray;

@property (strong,nonatomic)NSMutableArray *questionOtherArray;
@property (strong,nonatomic)NSMutableArray *questionIdOtherArray;
@property (strong,nonatomic)NSMutableArray *questionStatusOtherArray;
@property (strong,nonatomic)NSMutableArray *questionPublicStatusOtherArray;
@property (strong,nonatomic)NSMutableArray *questionContentOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertNameOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertUnitOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertTitleOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertImageOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertSoundOtherArray;
@property (strong,nonatomic)NSMutableArray *questionExpertSoundUrlOtherArray;
@property (strong,nonatomic)NSMutableArray *questionAudienceNumberOtherArray;
@property (strong,nonatomic)NSMutableArray *questionPayStatusOtherArray;
@property (strong,nonatomic)NSMutableArray *questionShitingMoneyOtherArray;

@end
