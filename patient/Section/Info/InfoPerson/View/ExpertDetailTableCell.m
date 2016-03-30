//
//  ExpertDetailTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertDetailTableCell.h"

@interface ExpertDetailTableCell ()

@end

@implementation ExpertDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 249*SCREEN_SCALE, 72)];
    [self initBackView1];
    [self.contentView addSubview:self.backView1];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(249*SCREEN_SCALE, 0, 1, 72)];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(249*SCREEN_SCALE+1, 0, SCREEN_WIDTH*SCREEN_SCALE-249*SCREEN_SCALE-1, 72)];
    [self initBackView2];
    [self.contentView addSubview:self.backView2];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 72, SCREEN_WIDTH*SCREEN_SCALE, 1)];
    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 72+1, SCREEN_WIDTH*SCREEN_SCALE, 120-72-1)];
    [self initBackView3];
    [self.contentView addSubview:self.backView3];
}

-(void)initBackView1{
    self.label1_1 = [[UILabel alloc] init];
    [self.backView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    [self.backView1 addSubview:self.label1_2];
    
    self.label1_3 = [[UILabel alloc] init];
    [self.backView1 addSubview:self.label1_3];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(12);
        make.top.equalTo(self.backView1).offset(16);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(18);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(90+13);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(13);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(12);
        make.bottom.equalTo(self.backView1).offset(-16);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
}

-(void)initBackView2{
    self.button = [[UIButton alloc] init];
    [self.button setImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button];
    
    self.label2_1 = [[UILabel alloc] init];
    [self.backView2 addSubview:self.label2_1];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.backView2).offset(0);
        make.leading.equalTo(self.backView2).offset(28);
        make.top.equalTo(self.backView2).offset(10);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.button).offset(32/2);
        make.top.equalTo(self.button).offset(32+5);
        make.width.mas_equalTo(80);
        make.bottom.equalTo(self.backView2).offset(-10);
    }];
}

-(void)initBackView3{
    self.lable3_1 = [[UILabel alloc] init];
    [self.backView3 addSubview:self.lable3_1];
    
    self.lable3_2 = [[UILabel alloc] init];
    [self.backView3 addSubview:self.lable3_2];
    
    [self.lable3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView3).offset(0);
        make.centerY.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.lable3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.lable3_1).offset(100+10);
        make.centerY.equalTo(self.lable3_1).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    
    
}

@end
