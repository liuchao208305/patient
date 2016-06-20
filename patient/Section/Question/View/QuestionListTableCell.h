//
//  QuestionTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/6/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionListTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UIImageView *publicImageView;

@property (strong,nonatomic)UILabel *expertLabel;
@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UIImageView *expertSoundImageView;
@property (strong,nonatomic)UILabel *expertSoundLengthLabel;
@property (strong,nonatomic)UILabel *audienceNumberLabel;

@property (strong,nonatomic)UILabel *payStatusLabel;
@property (strong,nonatomic)UIButton *deleteButton;
@property (strong,nonatomic)UIButton *confirmButton;

@end
