//
//  ContactTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *nameLabel;
@property (strong,nonatomic)UILabel *sexLabel;
@property (strong,nonatomic)UILabel *ageLabel;
@property (strong,nonatomic)UILabel *recordStatusLabel;
@property (strong,nonatomic)UILabel *idTitleLabel;
@property (strong,nonatomic)UILabel *idNumberLabel;

@end
