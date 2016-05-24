//
//  MineMessageTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineMessageTableCell : UITableViewCell

@property (strong,nonatomic)UIImageView *messageImageView;
@property (strong,nonatomic)UILabel *messageNameLabel;
@property (strong,nonatomic)UILabel *messageTitleLabel;
@property (strong,nonatomic)UILabel *messageTimeLabel;

@property (strong,nonatomic)UIView *lineView;

@end
