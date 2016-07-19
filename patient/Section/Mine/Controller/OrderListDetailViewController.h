//
//  OrderListDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/7/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderListDetailViewController : BaseViewController

@property (strong,nonatomic)NSString *sourceVC;

@property (assign,nonatomic)int orderType;
@property (strong,nonatomic)NSString *orderId;

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *doctorBackView;
@property (strong,nonatomic)UIImageView *doctorImageView;
@property (strong,nonatomic)UILabel *doctorNameLabel;
@property (strong,nonatomic)UILabel *doctorTitleLabel;
@property (strong,nonatomic)UILabel *doctorMoneyLabel1;
@property (strong,nonatomic)UILabel *doctorMoneyLabel2;
@property (strong,nonatomic)UILabel *doctorMoneyLabel3;
@property (strong,nonatomic)UILabel *doctorTimeLabel1;
@property (strong,nonatomic)UILabel *doctorTimeLabel2;
@property (strong,nonatomic)UILabel *doctorAddressLabel1;
@property (strong,nonatomic)UILabel *doctorAddressLabel2;

@property (strong,nonatomic)UIView *patientBackView1;
@property (strong,nonatomic)UILabel *patientNameLabel1;
@property (strong,nonatomic)UILabel *patientNameLabel2;
@property (strong,nonatomic)UILabel *patientSexLabel;
@property (strong,nonatomic)UILabel *patientAgeLabel;
@property (strong,nonatomic)UIView *patientLineView1;
@property (strong,nonatomic)UILabel *patientIdNumberLabel1;
@property (strong,nonatomic)UILabel *patientIdNumberLabel2;
@property (strong,nonatomic)UIView *patientLineView2;
@property (strong,nonatomic)UILabel *patientPhoneLabel1;
@property (strong,nonatomic)UILabel *patientPhoneLabel2;
@property (strong,nonatomic)UIView *patientLineView3;

@property (strong,nonatomic)UIView *patientBackView2;
@property (strong,nonatomic)UILabel *patientProblemLabel;
@property (strong,nonatomic)UIView *patientLineView4;
@property (strong,nonatomic)UILabel *patientJiwangshiLabel;
@property (strong,nonatomic)UILabel *patientShoushushiLabel;
@property (strong,nonatomic)UILabel *patientGuominshiLabel;
@property (strong,nonatomic)UILabel *patientJiazushiLabel;
@property (strong,nonatomic)UIView *patientLineView5;
@property (strong,nonatomic)UILabel *patientTestLabel;
@property (strong,nonatomic)UIView *patientLineView6;

@property (strong,nonatomic)UIView *patientBackView3;
@property (strong,nonatomic)UILabel *timeLabel;
@property (strong,nonatomic)UILabel *complainLabel1;
@property (strong,nonatomic)UILabel *complainLabel2;
@property (strong,nonatomic)UIView *compalainLineView;
@property (strong,nonatomic)UILabel *shuimianLabel1;
@property (strong,nonatomic)UILabel *shuimianLabel2;
@property (strong,nonatomic)UIView *shuimianLineView;
@property (strong,nonatomic)UILabel *yinshiLabel1;
@property (strong,nonatomic)UILabel *yinshiLabel2;
@property (strong,nonatomic)UIView *yinshiLineView;
@property (strong,nonatomic)UILabel *yinshuiLabel1;
@property (strong,nonatomic)UILabel *yinshuiLabel2;
@property (strong,nonatomic)UIView *yinshuiLineView;
@property (strong,nonatomic)UILabel *dabianLabel1;
@property (strong,nonatomic)UILabel *dabianLabel2_1;
@property (strong,nonatomic)UILabel *dabianLabel2_2;
@property (strong,nonatomic)UILabel *dabianLabel2_3;
@property (strong,nonatomic)UIImageView *dabianImageView;
@property (strong,nonatomic)UIView *dabianLineView;
@property (strong,nonatomic)UILabel *xiaobianLabel1;
@property (strong,nonatomic)UILabel *xiaobianLabel2_1;
@property (strong,nonatomic)UILabel *xiaobianLabel2_1Fix;
@property (strong,nonatomic)UILabel *xiaobianLabel2_2;
@property (strong,nonatomic)UIView *xiaobianLineView;

@property (strong,nonatomic)UILabel *daixiaLabel1;
@property (strong,nonatomic)UILabel *daixiaLabel2;
@property (strong,nonatomic)UIView *daixiaLineView;

@property (strong,nonatomic)UILabel *yuejingLabel1;
@property (strong,nonatomic)UILabel *yuejingLabel2_1;
@property (strong,nonatomic)UILabel *yuejingLabel2_2;
@property (strong,nonatomic)UILabel *yuejingLabel2_3;
@property (strong,nonatomic)UILabel *yuejingLabel2_4;
@property (strong,nonatomic)UILabel *yuejingLabel2_5;
@property (strong,nonatomic)UILabel *yuejingLabel2_6;
@property (strong,nonatomic)UILabel *yuejingLabel2_7;
@property (strong,nonatomic)UILabel *yuejingLabel2_8;
@property (strong,nonatomic)UIView *yuejingLineView;

@property (strong,nonatomic)UILabel *hanreLabel1;
@property (strong,nonatomic)UILabel *hanreLabel2;
@property (strong,nonatomic)UIView *hanreLineView;
@property (strong,nonatomic)UILabel *tiwenLabel1;
@property (strong,nonatomic)UILabel *tiwenLabel2;
@property (strong,nonatomic)UIView *tiwenLineView;
@property (strong,nonatomic)UILabel *chuhanLabel1;
@property (strong,nonatomic)UILabel *chuhanLabel2;
@property (strong,nonatomic)UIView *chuhanLineView;
@property (strong,nonatomic)UILabel *zhaopianLabel1;
@property (strong,nonatomic)UILabel *zhaopianLabel2;

@property (strong,nonatomic)UIButton *payButton;

@property (strong,nonatomic)UIView *diagnoseBackView;
@property (strong,nonatomic)UILabel *diagnoseTitleLabel;
@property (strong,nonatomic)UILabel *bianzhengLabel1;
@property (strong,nonatomic)UILabel *bianzhengLabel2;
@property (strong,nonatomic)UILabel *bianbingLabel1;
@property (strong,nonatomic)UILabel *bianbingLabel2;
@property (strong,nonatomic)UILabel *shexiangLabel1;
@property (strong,nonatomic)UILabel *shexiangLabel2;
@property (strong,nonatomic)UILabel *maixiangLabel1;
@property (strong,nonatomic)UILabel *maixiangLabel2;

@property (strong,nonatomic)UITableView *prescriptionTableView;

@property (strong,nonatomic)UIView *medicineBackView;
@property (strong,nonatomic)UILabel *medicineTitleLabel;
@property (strong,nonatomic)UILabel *fuyaofangfaLabel1;
@property (strong,nonatomic)UILabel *fuyaofangfaLabel2;
@property (strong,nonatomic)UILabel *fuyaoshijianLabel1;
@property (strong,nonatomic)UILabel *fuyaoshijianLabel2;
@property (strong,nonatomic)UILabel *fuyaocishuLabel1;
@property (strong,nonatomic)UILabel *fuyaocishuLabel2;

@property (strong,nonatomic)NSMutableArray *chufangArray;
@property (strong,nonatomic)NSMutableArray *chufangNameArray;
@property (strong,nonatomic)NSMutableArray *chufangQuantityArray;
@property (strong,nonatomic)NSMutableArray *chufangUnitArray;
@property (strong,nonatomic)NSMutableArray *chufangUsageArray;

@end
