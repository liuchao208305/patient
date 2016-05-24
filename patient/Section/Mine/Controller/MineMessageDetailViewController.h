//
//  MineMessageDetailViewController.h
//  patient
//
//  Created by ChaosLiu on 16/5/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface MineMessageDetailViewController : BaseViewController

@property (strong,nonatomic)NSString *messageId;

@property (strong,nonatomic)UILabel *timeLabel;
@property (strong,nonatomic)UIImageView *contentImageView;
@property (strong,nonatomic)UILabel *contentLabel;

@end
