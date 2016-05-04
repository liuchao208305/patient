//
//  MRDoctorTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRDoctorTableCell : UITableViewCell

@property (strong,nonatomic)UIView *imageBackView;
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UIImageView *doctorImageView;
@property (strong,nonatomic)UILabel *expertLabel;
@property (strong,nonatomic)UILabel *doctorLabel;
@property (strong,nonatomic)UILabel *clinicLabel;
@property (strong,nonatomic)UILabel *addressLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UIImageView *timeImage;
@property (strong,nonatomic)UILabel *timeLabel;

@end
