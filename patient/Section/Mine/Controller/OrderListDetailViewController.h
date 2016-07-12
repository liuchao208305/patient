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

@property (strong,nonatomic)UIView *patientBackView1;

@property (strong,nonatomic)UIView *patientBackView2;

@property (strong,nonatomic)UIView *patientBackView3;

@property (strong,nonatomic)UIView *diagnoseBackView;

@property (strong,nonatomic)UIView *prescriptionBackView;

@property (strong,nonatomic)UIView *medicineBackView;

@end
