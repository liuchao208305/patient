//
//  CouponCheckViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "YJSegmentedControl.h"
#import "CouponTableCell.h"
#import "CouponData.h"

@protocol CouponDelegate <NSObject>

-(void)couponSelected:(CouponData *)couponData;

@end

@interface CouponCheckViewController : BaseViewController<YJSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic)double treatmentMoney;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;
@property (assign,nonatomic)BOOL flag3;

@property (strong,nonatomic)UIView *headView;
@property (strong,nonatomic)UIView *footView;

@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;
@property (strong,nonatomic)UITableView *tableView3;

@property (strong,nonatomic)NSMutableArray *couponArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponIdArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponTypeArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponNameArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponDescriptionArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponMoneyArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponStatusArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponDayArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponMinMoneyArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponReasonArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponRebateArrayUnused;
@property (strong,nonatomic)NSMutableArray *couponEndArrayUnused;

@property (strong,nonatomic)NSMutableArray *couponArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponIdArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponTypeArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponNameArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponDescriptionArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponMoneyArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponStatusArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponDayArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponMinMoneyArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponReasonArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponRebateArrayUsed;
@property (strong,nonatomic)NSMutableArray *couponEndArrayUsed;

@property (strong,nonatomic)NSMutableArray *couponArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponIdArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponTypeArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponNameArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponDescriptionArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponMoneyArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponStatusArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponDayArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponMinMoneyArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponReasonArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponRebateArrayExpired;
@property (strong,nonatomic)NSMutableArray *couponEndArrayExpired;

@property (weak,nonatomic)id<CouponDelegate> couponDelegate;

@end
