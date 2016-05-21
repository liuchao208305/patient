//
//  ClinicExpertTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicExpertTableCell.h"

@implementation ClinicExpertTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = kWHITE_COLOR;
    [self.contentView addSubview:self.backView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [self initMainView];
}

-(void)initMainView{
    self.expertImage = [[UIImageView alloc] init];
    self.expertImage.layer.cornerRadius = 39;
//    [self.expertImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView addSubview:self.expertImage];
    
    self.expertLabel1 = [[UILabel alloc] init];
//    self.expertLabel1.text = @"test";
    [self.backView addSubview:self.expertLabel1];
    
    self.expertLabel2 = [[UILabel alloc] init];
//    self.expertLabel2.text = @"test";
    [self.backView addSubview:self.expertLabel2];
    
    self.expertLabel3 = [[UILabel alloc] init];
//    self.expertLabel3.text = @"test";
    [self.backView addSubview:self.expertLabel3];
    
    self.moneyLabel1 = [[UILabel alloc] init];
//    self.moneyLabel1.text = @"test";
    [self.backView addSubview:self.moneyLabel1];
    
    self.moneyLabel2 = [[UILabel alloc] init];
//    self.expertLabel2.text =@"test";
    [self.backView addSubview:self.moneyLabel2];
    
    [self.expertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(12);
        make.top.equalTo(self.backView).offset(12);
//        make.centerY.equalTo(self.backView).offset(0);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(78);
    }];
    
    [self.expertLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImage).offset(78+10);
        make.top.equalTo(self.backView).offset(26);
//        make.top.equalTo(self.expertImage).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];

    [self.expertLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertLabel1).offset(100+10);
        make.centerY.equalTo(self.expertLabel1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView).offset(-10);
        make.centerY.equalTo(self.expertLabel2).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
    }];

    [self.expertLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertLabel1).offset(0);
        make.top.equalTo(self.expertLabel1).offset(15+22);
//        make.bottom.equalTo(self.expertImage).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView).offset(-10);
        make.centerY.equalTo(self.expertLabel3).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
    }];
}

@end
