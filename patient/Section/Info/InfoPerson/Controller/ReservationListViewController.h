//
//  ReservationListViewController.h
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface ReservationListViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *scrollView;

@property (strong,nonatomic)UIView *backView1;
@property (strong,nonatomic)UIView *imageBackView;
@property (strong,nonatomic)UIImageView *expertImage;
@property (strong,nonatomic)UIImageView *doctorImage;
@property (strong,nonatomic)UILabel *expertLabel;
@property (strong,nonatomic)UILabel *doctorLabel;
@property (strong,nonatomic)UILabel *clinicLabel;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UILabel *timeLabel;

@end
