//
//  TestResultListTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestResultListTableCell : UITableViewCell

@property (strong,nonatomic)NSString *patientId;
@property (strong,nonatomic)NSString *resultId;
@property (strong,nonatomic)UIImageView *resultImageView;
@property (strong,nonatomic)UILabel *resultLabel1;
@property (strong,nonatomic)UILabel *resultLabel2;
@property (strong,nonatomic)UILabel *resultLabel3;
@property (strong,nonatomic)UIView *resultLineView;
@property (strong,nonatomic)UILabel *resultLabel4;

@property (strong,nonatomic)UILabel *resultLabelFix;

@end
