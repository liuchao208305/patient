//
//  SelfInspectionHeaderViewOne.h
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfInspectionHeaderViewOne : UIView

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UISegmentedControl *segmentedControl;
@property (strong,nonatomic)UILabel *contentLabel1_1;
@property (strong,nonatomic)UITextField *contentTextField1;
@property (strong,nonatomic)UILabel *contentLabel1_2;
@property (strong,nonatomic)UILabel *contentLabel2_1;
@property (strong,nonatomic)UITextField *contentTextField2;
@property (strong,nonatomic)UILabel *contentLabel2_2;
@property (strong,nonatomic)UIView *lineView;

-(void)initView:(NSString *)title;
-(void)initView:(NSString *)title array:(NSArray *)segmentedArray;
-(void)initView:(NSString *)title content1_1:(NSString *)content1_1 content1_2:(NSString *)content1_2 content2_1:(NSString *)content2_1 content2_2:(NSString *)content2_2;

@end
