//
//  MineQuestionListTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineQuestionListTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UIImageView *publicImageView;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UILabel *askTimeLabel;
@property (strong,nonatomic)UILabel *answerTimeLabel;
@property (strong,nonatomic)UILabel *payTimeLabel;
@property (strong,nonatomic)UILabel *moneyLabel1;
@property (strong,nonatomic)UILabel *moneyLabel2;
@property (strong,nonatomic)UILabel *moneyLabel3;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *audienceLabel;

@end
