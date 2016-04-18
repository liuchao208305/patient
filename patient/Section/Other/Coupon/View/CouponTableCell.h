//
//  CouponTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableCell : UITableViewCell

@property (strong,nonatomic)UIImageView *backImageView;
@property (strong,nonatomic)UILabel *moneySmallLabel;
@property (strong,nonatomic)UILabel *moneyBigLabel;
@property (strong,nonatomic)UILabel *moneyBottomLabel;
@property (strong,nonatomic)UILabel *dateLabel;
@property (strong,nonatomic)UILabel *conditionLabel;
@property (strong,nonatomic)UILabel *nameLabelLeft;
@property (strong,nonatomic)UILabel *nameLabelRight;

@end
