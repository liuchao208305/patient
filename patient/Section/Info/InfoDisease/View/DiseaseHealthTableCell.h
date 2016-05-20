//
//  DiseaseHealthTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiseaseHealthTableCell : UITableViewCell

@property (strong,nonatomic)UIImageView *healthImageView;
@property (strong,nonatomic)UILabel *healthNameLabel;
@property (strong,nonatomic)UILabel *healthPropertyLabel;
@property (strong,nonatomic)UILabel *healthFunctionLabel;
@property (strong,nonatomic)UIImageView *healthCommentImageView;
@property (strong,nonatomic)UILabel *healthCommentLabel;
@property (strong,nonatomic)UIView *lineView;

@end
