//
//  MRRecordGeneralTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/5/5.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRTemplateGeneralTableCell : UITableViewCell

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIView *lineView;
@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UIView *lineViewFix;

@property (strong,nonatomic)UIImageView *detailImageView;

@end
