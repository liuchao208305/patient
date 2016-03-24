//
//  ExpertClinicTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertClinicTableCell.h"

@implementation ExpertClinicTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.lineView = [[UIView alloc] init];
    [self initLineView];
    [self.contentView addSubview:self.lineView];
    
    self.mainView = [[UIView alloc] init];
    [self initMainView];
    [self.contentView addSubview:self.mainView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.lineView).offset(1);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

-(void)initLineView{
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
}

-(void)initMainView{
    self.label1 = [[UILabel alloc] init];
    [self.mainView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    [self.mainView addSubview:self.label2];
    
    self.starImageView1 = [[UIImageView alloc] init];
    [self.mainView addSubview:self.starImageView1];
    
    self.starImageView2 = [[UIImageView alloc] init];
    [self.mainView addSubview:self.starImageView2];
    
    self.starImageView3 = [[UIImageView alloc] init];
    [self.mainView addSubview:self.starImageView3];
    
    self.starImageView4 = [[UIImageView alloc] init];
    [self.mainView addSubview:self.starImageView4];
    
    self.starImageView5 = [[UIImageView alloc] init];
    [self.mainView addSubview:self.starImageView5];
    
    self.label3 = [[UILabel alloc] init];
    [self.mainView addSubview:self.label3];
    
    self.label4 = [[UILabel alloc] init];
    [self.mainView addSubview:self.label4];
    
    self.label5 = [[UILabel alloc] init];
    [self.mainView addSubview:self.label5];
    
    self.couponImageView = [[UIImageView alloc] init];
    [self.mainView addSubview:self.couponImageView];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(10);
        make.top.equalTo(self.mainView).offset(10);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(10);
        make.top.equalTo(self.label1).offset(15+10);
        make.width.mas_equalTo(175);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(10);
        make.top.equalTo(self.label2).offset(15+10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView1).offset(15+5);
        make.centerY.equalTo(self.starImageView1).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView2).offset(15+5);
        make.centerY.equalTo(self.starImageView2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView3).offset(15+5);
        make.centerY.equalTo(self.starImageView3).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImageView4).offset(15+5);
        make.centerY.equalTo(self.starImageView4).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mainView).offset(-10);
        make.centerY.equalTo(self.starImageView5).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(10);
        make.centerY.equalTo(self.starImageView1).offset(28);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label4).offset(80+10);
        make.centerY.equalTo(self.label4).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label5).offset(45+10);
        make.centerY.equalTo(self.label5).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(15);
    }];
}

@end
