//
//  SelfInspectionHeaderViewOne.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInspectionHeaderView : UIView

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UILabel *titleLabelFix;
@property (strong,nonatomic)UITextField *contentTextField;
@property (strong,nonatomic)UILabel *contentLabel;
@property (strong,nonatomic)UISegmentedControl *segmentedControl;
@property (strong,nonatomic)UILabel *contentLabel1_1;
@property (strong,nonatomic)UITextField *contentTextField1;
@property (strong,nonatomic)UILabel *contentLabel1_2;
@property (strong,nonatomic)UILabel *contentLabel2_1;
@property (strong,nonatomic)UITextField *contentTextField2;
@property (strong,nonatomic)UILabel *contentLabel2_2;
@property (strong,nonatomic)UIView *lineView;

-(void)initView:(NSString *)title;
-(void)initView:(NSString *)title titleFix:(NSString *)titleFix;
-(void)initView:(NSString *)title content:(NSString *)content array:(NSArray *)segmentedArray hideFlag:(BOOL)hideFlag;
-(void)initView:(NSString *)title array:(NSArray *)segmentedArray leftHideFlag:(BOOL)leftHideFlag;
-(void)initView:(NSString *)title array:(NSArray *)segmentedArray righHideFlag:(BOOL)righHideFlag;
-(void)initView:(NSString *)title content1_1:(NSString *)content1_1 content1_2:(NSString *)content1_2 content1_3:(NSString *)content1_3 content2_1:(NSString *)content2_1 content2_2:(NSString *)content2_2 content2_3:(NSString *)content2_3;

@end
