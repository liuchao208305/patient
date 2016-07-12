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

@property (strong,nonatomic)UIView *diagnoseBackView;

@property (strong,nonatomic)UIView *prescriptionBackView;

@property (strong,nonatomic)UIView *medicineBackView;

@end
