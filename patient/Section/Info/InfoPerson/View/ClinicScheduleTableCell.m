//
//  ClinicScheduleTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicScheduleTableCell.h"
#import "DateUtil.h"
#import "ClinicInfoViewController.h"

@interface ClinicScheduleTableCell ()

@end

@implementation ClinicScheduleTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:[DateUtil getFirstDate], [DateUtil getSecondDate], [DateUtil getThirdDate],[DateUtil getFourthDate],nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self];
    [self.contentView addSubview:self.segmentControl];
    
    self.segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 1)];
    self.segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.contentView addSubview:self.segmentBottomLineView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 154-43)];
    self.backView.backgroundColor = kBACKGROUND_COLOR;
    
    [self initBackView1];
    
    [self.contentView addSubview:self.backView];
}
/*==================================================================================================*/
-(void)initBackView1{
    self.backUpView1 = [[UIView alloc] init];
    self.backUpView1.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView1];
    
    self.backDownView1 = [[UIView alloc] init];
    self.backDownView1.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView1];

    [self.backUpView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView1];
}

-(void)initSubView1{
    self.label1_1 = [[UILabel alloc] init];
//    self.label1_1.text = @"上午";
    [self.backUpView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
//    self.label1_2.text = @"预计";
    [self.backUpView1 addSubview:self.label1_2];
    
    self.label1_3  = [[UILabel alloc] init];
//    self.label1_3.text = @"08:00-12:00";
    [self.backUpView1 addSubview:self.label1_3];
    
    self.couponButton1_1 = [[UIButton alloc] init];
//    self.couponButton1_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView1 addSubview:self.couponButton1_1];
    
    self.button1_1  = [[UIButton alloc] init];
//    [self.button1_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    [self.backUpView1 addSubview:self.button1_1];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView1).offset(10);
        make.centerY.equalTo(self.backUpView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(50+10);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(50+10);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(100+10);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView1).offset(-10);
        make.centerY.equalTo(self.backUpView1).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
/*
 =====================================================================
 */
    self.label1_4 = [[UILabel alloc] init];
//    self.label1_4.text = @"下午";
    [self.backDownView1 addSubview:self.label1_4];
    
    self.label1_5 = [[UILabel alloc] init];
//    self.label1_5.text = @"预计";
    [self.backDownView1 addSubview:self.label1_5];
    
    self.label1_6  = [[UILabel alloc] init];
//    self.label1_6.text = @"14:00-18:00";
    [self.backDownView1 addSubview:self.label1_6];
    
    self.couponButton1_2 = [[UIButton alloc] init];
//    self.couponButton1_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView1 addSubview:self.couponButton1_2];
    
    self.button1_2  = [[UIButton alloc] init];
//    [self.button1_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    [self.backDownView1 addSubview:self.button1_2];
    
    [self.label1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView1).offset(10);
        make.centerY.equalTo(self.backDownView1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_4).offset(50+10);
        make.centerY.equalTo(self.label1_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_5).offset(50+10);
        make.centerY.equalTo(self.label1_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_6).offset(100+10);
        make.centerY.equalTo(self.label1_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView1).offset(-10);
        make.centerY.equalTo(self.backDownView1).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initBackView2{
    self.backUpView2 = [[UIView alloc] init];
    self.backUpView2.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView2];
    
    self.backDownView2 = [[UIView alloc] init];
    self.backDownView2.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView2];
    
    [self.backUpView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView2];
}

-(void)initSubView2{
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"2_1";
    [self.backUpView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"2_2";
    [self.backUpView2 addSubview:self.label2_2];
    
    self.label2_3  = [[UILabel alloc] init];
    self.label2_3.text = @"2_3";
    [self.backUpView2 addSubview:self.label2_3];
    
    self.couponButton2_1 = [[UIButton alloc] init];
//    self.couponButton2_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView2 addSubview:self.couponButton2_1];
    
    self.button2_1  = [[UIButton alloc] init];
//    [self.button2_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    [self.backUpView2 addSubview:self.button2_1];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView2).offset(10);
        make.centerY.equalTo(self.backUpView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(50+10);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(50+10);
        make.centerY.equalTo(self.label2_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_3).offset(100+10);
        make.centerY.equalTo(self.label2_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView2).offset(-10);
        make.centerY.equalTo(self.backUpView2).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label2_4 = [[UILabel alloc] init];
    self.label2_4.text = @"2_4";
    [self.backDownView2 addSubview:self.label2_4];
    
    self.label2_5 = [[UILabel alloc] init];
    self.label2_5.text = @"2_5";
    [self.backDownView2 addSubview:self.label2_5];
    
    self.label2_6  = [[UILabel alloc] init];
    self.label2_6.text = @"2_6";
    [self.backDownView2 addSubview:self.label2_6];
    
    self.couponButton2_2 = [[UIButton alloc] init];
//    self.couponButton2_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView2 addSubview:self.couponButton2_2];
    
    self.button2_2  = [[UIButton alloc] init];
//    [self.button2_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    [self.backDownView2 addSubview:self.button2_2];
    
    [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView2).offset(10);
        make.centerY.equalTo(self.backDownView2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_4).offset(50+10);
        make.centerY.equalTo(self.label2_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_5).offset(50+10);
        make.centerY.equalTo(self.label2_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_6).offset(100+10);
        make.centerY.equalTo(self.label2_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView2).offset(-10);
        make.centerY.equalTo(self.backDownView2).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initBackView3{
    self.backUpView3 = [[UIView alloc] init];
    self.backUpView3.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView3];
    
    self.backDownView3 = [[UIView alloc] init];
    self.backDownView3.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView3];
    
    [self.backUpView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView3];
}

-(void)initSubView3{
    self.label3_1 = [[UILabel alloc] init];
//    self.label3_1.text = @"3_1";
    [self.backUpView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
//    self.label3_2.text = @"3_2";
    [self.backUpView3 addSubview:self.label3_2];
    
    self.label3_3  = [[UILabel alloc] init];
//    self.label3_3.text = @"3_3";
    [self.backUpView3 addSubview:self.label3_3];
    
    self.couponButton3_1 = [[UIButton alloc] init];
//    self.couponButton3_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView3 addSubview:self.couponButton3_1];
    
    self.button3_1  = [[UIButton alloc] init];
//    [self.button3_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    [self.backUpView3 addSubview:self.button3_1];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView3).offset(10);
        make.centerY.equalTo(self.backUpView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(50+10);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(50+10);
        make.centerY.equalTo(self.label3_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_3).offset(100+10);
        make.centerY.equalTo(self.label3_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView3).offset(-10);
        make.centerY.equalTo(self.backUpView3).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label3_4 = [[UILabel alloc] init];
//    self.label3_4.text = @"3_4";
    [self.backDownView3 addSubview:self.label3_4];
    
    self.label3_5 = [[UILabel alloc] init];
//    self.label3_5.text = @"3_5";
    [self.backDownView3 addSubview:self.label3_5];
    
    self.label3_6  = [[UILabel alloc] init];
//    self.label3_6.text = @"3_6";
    [self.backDownView3 addSubview:self.label3_6];
    
    self.couponButton3_2 = [[UIButton alloc] init];
//    self.couponButton3_2.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backDownView3 addSubview:self.couponButton3_2];
    
    self.button3_2  = [[UIButton alloc] init];
//    [self.button3_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    [self.backDownView3 addSubview:self.button3_2];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView3).offset(10);
        make.centerY.equalTo(self.backDownView3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_4).offset(50+10);
        make.centerY.equalTo(self.label3_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_5).offset(50+10);
        make.centerY.equalTo(self.label3_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_6).offset(100+10);
        make.centerY.equalTo(self.label3_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView3).offset(-10);
        make.centerY.equalTo(self.backDownView3).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}
/*==================================================================================================*/
-(void)initBackView4{
    self.backUpView4 = [[UIView alloc] init];
    self.backUpView4.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backUpView4];
    
    self.backDownView4 = [[UIView alloc] init];
    self.backDownView4.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backDownView4];
    
    [self.backUpView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backDownView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView4];
}

-(void)initSubView4{
    self.label4_1 = [[UILabel alloc] init];
//    self.label4_1.text = @"4_1";
    [self.backUpView4 addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
//    self.label4_2.text = @"4_2";
    [self.backUpView4 addSubview:self.label4_2];
    
    self.label4_3  = [[UILabel alloc] init];
//    self.label4_3.text = @"4_3";
    [self.backUpView4 addSubview:self.label4_3];
    
    self.couponButton4_1 = [[UIButton alloc] init];
//    self.couponButton4_1.backgroundColor = ColorWithHexRGB(0xc36743);
    [self.backUpView4 addSubview:self.couponButton4_1];
    
    self.button4_1  = [[UIButton alloc] init];
//    [self.button4_1 setImage:[UIImage imageNamed:@"info_clinic_schedule_unbookable_button"] forState:UIControlStateNormal];
    [self.backUpView4 addSubview:self.button4_1];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backUpView4).offset(10);
        make.centerY.equalTo(self.backUpView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_1).offset(50+10);
        make.centerY.equalTo(self.label4_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_2).offset(50+10);
        make.centerY.equalTo(self.label4_2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_3).offset(100+10);
        make.centerY.equalTo(self.label4_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backUpView4).offset(-10);
        make.centerY.equalTo(self.backUpView4).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    /*
     =====================================================================
     */
    self.label4_4 = [[UILabel alloc] init];
//    self.label4_4.text = @"4_4";
    [self.backDownView4 addSubview:self.label4_4];
    
    self.label4_5 = [[UILabel alloc] init];
//    self.label4_5.text = @"4_5";
    [self.backDownView4 addSubview:self.label4_5];
    
    self.label4_6  = [[UILabel alloc] init];
//    self.label4_6.text = @"4_6";
    [self.backDownView4 addSubview:self.label4_6];
    
    self.couponButton4_2 = [[UIButton alloc] init];
//    self.couponButton4_2.backgroundColor = ColorWithHexRGB(0xC36743);
    [self.backDownView4 addSubview:self.couponButton4_2];
    
    self.button4_2  = [[UIButton alloc] init];
//    [self.button4_2 setImage:[UIImage imageNamed:@"info_clinic_schedule_bookable_button"] forState:UIControlStateNormal];
    [self.backDownView4 addSubview:self.button4_2];
    
    [self.label4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backDownView4).offset(10);
        make.centerY.equalTo(self.backDownView4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_4).offset(50+10);
        make.centerY.equalTo(self.label4_4).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_5).offset(50+10);
        make.centerY.equalTo(self.label4_5).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponButton4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_6).offset(100+10);
        make.centerY.equalTo(self.label4_6).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backDownView4).offset(-10);
        make.centerY.equalTo(self.backDownView4).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    
    ClinicInfoViewController *clinicInfoVC = [[ClinicInfoViewController alloc] init];
    [clinicInfoVC sendRequestAccordingSelection:selection];
    
    if (selection == 0) {
        [self initBackView1];
        [self.backUpView2 removeFromSuperview];
        [self.backDownView2 removeFromSuperview];
        [self.backUpView3 removeFromSuperview];
        [self.backDownView3 removeFromSuperview];
        [self.backUpView4 removeFromSuperview];
        [self.backDownView4 removeFromSuperview];
    }else if (selection == 1){
        [self initBackView2];
        [self.backUpView1 removeFromSuperview];
        [self.backDownView1 removeFromSuperview];
        [self.backUpView3 removeFromSuperview];
        [self.backDownView3 removeFromSuperview];
        [self.backUpView4 removeFromSuperview];
        [self.backDownView4 removeFromSuperview];
    }else if (selection == 2){
        [self initBackView3];
        [self.backUpView1 removeFromSuperview];
        [self.backDownView1 removeFromSuperview];
        [self.backUpView2 removeFromSuperview];
        [self.backDownView2 removeFromSuperview];
        [self.backUpView4 removeFromSuperview];
        [self.backDownView4 removeFromSuperview];
    }else if (selection == 3){
        [self initBackView4];
        [self.backUpView1 removeFromSuperview];
        [self.backDownView1 removeFromSuperview];
        [self.backUpView2 removeFromSuperview];
        [self.backDownView2 removeFromSuperview];
        [self.backUpView3 removeFromSuperview];
        [self.backDownView3 removeFromSuperview];
    }
}

@end
