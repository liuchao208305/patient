//
//  OrderListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/4/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "YJSegmentedControl.h"

@interface OrderListViewController : BaseViewController<YJSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSString *sourceVC;

@property (assign,nonatomic)NSInteger orderType;

@property (assign,nonatomic)BOOL flag1;
@property (assign,nonatomic)BOOL flag2;
@property (assign,nonatomic)BOOL flag3;
@property (assign,nonatomic)BOOL flag4;
@property (assign,nonatomic)BOOL flag5;

@property (assign,nonatomic)BOOL isButtonHidden;

@property (strong,nonatomic)YJSegmentedControl *segmentControl;
@property (strong,nonatomic)UITableView *tableView1;
@property (strong,nonatomic)UITableView *tableView2;
@property (strong,nonatomic)UITableView *tableView3;
@property (strong,nonatomic)UITableView *tableView4;
@property (strong,nonatomic)UITableView *tableView5;
///*=========================================================================*/
//@property (strong,nonatomic)NSMutableArray *orderArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderIdArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderStatusArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderMoneyArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderClinicNameArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderDoctorIdArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderDoctorNameArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderDoctorImageArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderPatientIdArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderPatientNameArrayAll;
//
//@property (strong,nonatomic)NSMutableArray *orderPayIdArrayAll;
//@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayAll;
///*=========================================================================*/
//@property (strong,nonatomic)NSMutableArray *orderArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderIdArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderStatusArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderMoneyArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderClinicNameArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderDoctorIdArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderDoctorNameArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderDoctorImageArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderPatientIdArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderPatientNameArrayBooked;
//
//@property (strong,nonatomic)NSMutableArray *orderPayIdArrayBooked;
//@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayBooked;
///*=========================================================================*/
//@property (strong,nonatomic)NSMutableArray *orderArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderIdArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderStatusArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderMoneyArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderClinicNameArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderDoctorIdArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderDoctorNameArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderDoctorImageArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderPatientIdArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderPatientNameArrayProceeding;
//
//@property (strong,nonatomic)NSMutableArray *orderPayIdArrayProceeding;
//@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayProceeding;
///*=========================================================================*/
//@property (strong,nonatomic)NSMutableArray *orderArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderIdArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderStatusArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderMoneyArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderClinicNameArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderDoctorIdArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderDoctorNameArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderDoctorImageArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderPatientIdArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderPatientNameArrayEvaluating;
//
//@property (strong,nonatomic)NSMutableArray *orderPayIdArrayEvaluating;
//@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayEvaluating;
///*=========================================================================*/
//@property (strong,nonatomic)NSMutableArray *orderArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderIdArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderStatusArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderMoneyArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderClinicNameArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderDoctorIdArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderDoctorNameArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderDoctorImageArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderPatientIdArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderPatientNameArrayCompleted;
//
//@property (strong,nonatomic)NSMutableArray *orderPayIdArrayCompleted;
//@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayCompleted;

@property (strong,nonatomic)NSMutableArray *orderArrayAll;
@property (strong,nonatomic)NSMutableArray *orderIdArrayAll;
@property (strong,nonatomic)NSMutableArray *orderStatusArrayAll;
@property (strong,nonatomic)NSMutableArray *orderStatusFixArrayAll;
@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayAll;
@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayAll;
@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayAll;
@property (strong,nonatomic)NSMutableArray *orderMoneyArrayAll;
@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayAll;
@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayAll;
@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayAll;
@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayAll;
@property (strong,nonatomic)NSMutableArray *orderWaitTimeArrayAll;

@property (strong,nonatomic)NSMutableArray *orderArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderIdArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderStatusArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderStatusFixArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderMoneyArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayUnpayed;
@property (strong,nonatomic)NSMutableArray *orderWaitTimeArrayUnpayed;

@property (strong,nonatomic)NSMutableArray *orderArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderIdArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderStatusArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderStatusFixArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderMoneyArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayUntreated;
@property (strong,nonatomic)NSMutableArray *orderWaitTimeArrayUntreated;

@property (strong,nonatomic)NSMutableArray *orderArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderIdArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderStatusArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderStatusFixArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderMoneyArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayTreated;
@property (strong,nonatomic)NSMutableArray *orderWaitTimeArrayTreated;

@property (strong,nonatomic)NSMutableArray *orderArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderIdArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderStatusArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderStatusFixArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderPayStatusArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderCreatTimeArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderBookTimeArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderMoneyArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderExpertIdArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderExpertNameArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderExpertImageArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderClinicAddressArrayInvalid;
@property (strong,nonatomic)NSMutableArray *orderWaitTimeArrayInvalid;

@end
