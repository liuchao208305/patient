//
//  MRPatientTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/3.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MRPatientTableCell.h"

@implementation MRPatientTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"test";
    [self.contentView addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"test";
    [self.contentView addSubview:self.label1_2];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"test";
    [self.contentView addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"test";
    [self.contentView addSubview:self.label2_2];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.text = @"test";
    [self.contentView addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.text = @"test";
    [self.contentView addSubview:self.label3_2];
    
    self.label4_1 = [[UILabel alloc] init];
    self.label4_1.text = @"test";
    [self.contentView addSubview:self.label4_1];
    
    self.label4_2 = [[UILabel alloc] init];
    self.label4_2.text = @"test";
    [self.contentView addSubview:self.label4_2];
    
    self.label4_3 = [[UILabel alloc] init];
    self.label4_3.text = @"test";
    [self.contentView addSubview:self.label4_3];
    
    self.label4_4 = [[UILabel alloc] init];
    self.label4_4.text = @"test";
    [self.contentView addSubview:self.label4_4];
    
    self.label5_1 = [[UILabel alloc] init];
    self.label5_1.text = @"test";
    [self.contentView addSubview:self.label5_1];
    
    self.label5_2 = [[UILabel alloc] init];
    self.label5_2.text = @"test";
    [self.contentView addSubview:self.label5_2];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(16);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12+80+17);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(0);
        make.top.equalTo(self.label1_1).offset(15+32);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(0);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(0);
        make.top.equalTo(self.label2_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(0);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(0);
        make.top.equalTo(self.label3_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(0);
        make.centerY.equalTo(self.label4_1).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.label4_2).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_3).offset(60+17);
        make.centerY.equalTo(self.label4_3).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_1).offset(0);
        make.top.equalTo(self.label4_1).offset(15+32);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4_2).offset(0);
        make.centerY.equalTo(self.label5_1).offset(0);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(15);
    }];
}

@end
