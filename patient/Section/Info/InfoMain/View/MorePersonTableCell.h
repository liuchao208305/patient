//
//  MorePersonTableCell.h
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorePersonTableCell : UITableViewCell

@property (strong,nonatomic)UIImageView *expertImageView;
@property (strong,nonatomic)UILabel *expertNameLabel;
@property (strong,nonatomic)UILabel *expertTitleLabel;
@property (strong,nonatomic)UILabel *expertUnitLabel;
@property (strong,nonatomic)UILabel *expertDepartLabel;
@property (strong,nonatomic)UILabel *expertDetailLabel;

@property (strong,nonatomic)UILabel *expertShanchangLabel;

@property (strong,nonatomic)UIImageView *expertAnswserImageView;
@property (strong,nonatomic)UILabel *expertAnswerLabel;
@property (strong,nonatomic)UIImageView *expertFocusImageView;
@property (strong,nonatomic)UILabel *expertFocusLabel;

//@property (strong,nonatomic)UIButton *expertStatusButton;
//@property (strong,nonatomic)UIImageView *expertFlagImageView1;
//@property (strong,nonatomic)UILabel *expertFlagNameLabel1;
//@property (strong,nonatomic)UIImageView *expertFlagImageView2;
//@property (strong,nonatomic)UIImageView *expertFlagImageView3;
//@property (strong,nonatomic)UIImageView *expertFlagImageView4;
//@property (strong,nonatomic)UIImageView *expertFlagImageView5;
@property (strong,nonatomic)UIView *lineView;

@end
