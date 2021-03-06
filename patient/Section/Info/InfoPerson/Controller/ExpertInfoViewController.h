//
//  ExpertInfoViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "ExpertHeadView.h"
#import "ExpertFootView.h"

@interface ExpertInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSString *sourceVC;

@property (strong,nonatomic)NSString *expertId;
@property (strong,nonatomic)NSString *expertName;

@property (strong,nonatomic)NSString *longtitude;
@property (strong,nonatomic)NSString *latitude;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)ExpertHeadView *expertHeadView;
@property (strong,nonatomic)ExpertFootView *expertFootView;

@property (strong,nonatomic)NSMutableArray *commentArray;
@property (strong,nonatomic)NSMutableArray *commentExpertIdArray;
@property (strong,nonatomic)NSMutableArray *commemtImageArray;
@property (strong,nonatomic)NSMutableArray *commentPatientArray;
@property (strong,nonatomic)NSMutableArray *commentExpertArray;
@property (strong,nonatomic)NSMutableArray *commentPraiseArray;

@property (assign,nonatomic)NSInteger fiterType;

@property (strong,nonatomic)NSMutableArray *clinicArray;
@property (strong,nonatomic)NSMutableArray *clinicIdArray;
@property (strong,nonatomic)NSMutableArray *clinicNameArray;
@property (strong,nonatomic)NSMutableArray *clinicAddressArray;
@property (strong,nonatomic)NSMutableArray *clinicStarArray;
@property (strong,nonatomic)NSMutableArray *clinicDistanceArray;
@property (strong,nonatomic)NSMutableArray *clinicMoneyArray;
@property (strong,nonatomic)NSMutableArray *clinicCouponArray;

@property (strong,nonatomic)UIView *bottomLineView;
@property (strong,nonatomic)UIImageView *focusBackView;
@property (strong,nonatomic)UIImageView *focusImageView;
@property (strong,nonatomic)UILabel *focusLabel;
@property (strong,nonatomic)UIImageView *inquiryBackView;
@property (strong,nonatomic)UIImageView *inquiryImageView;
@property (strong,nonatomic)UILabel *inquiryLabel;
@property (strong,nonatomic)UIImageView *bookBackView;
@property (strong,nonatomic)UIImageView *bookImageView;
@property (strong,nonatomic)UILabel *bookLabel;

@end
