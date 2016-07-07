//
//  OrderListFixTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListFixTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *createTimeLabel;
@property (strong,nonatomic)UILabel *statusLabel;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *bookTimeLabel;
@property (strong,nonatomic)UILabel *clinicAddressLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UILabel *moneyLabel3;
@property (strong,nonatomic)UIImageView *waitTimeImageView;
@property (strong,nonatomic)UILabel *waitTimeLabel;
@property (strong,nonatomic)UIButton *payButton;

@end
