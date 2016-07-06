//
//  OrderListFixTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "OrderListFixTableCell.h"

@implementation OrderListFixTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.createTimeLabel = [[UILabel alloc] init];
    self.createTimeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.createTimeLabel];
    
    self.statusLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.statusLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 24;
    [self.contentView addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    self.expertNameLabel.font = [UIFont systemFontOfSize:14];
    self.expertNameLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.expertNameLabel];
    
    self.bookTimeLabel = [[UILabel alloc] init];
    self.bookTimeLabel.font = [UIFont systemFontOfSize:14];
    self.bookTimeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.bookTimeLabel];
    
    self.clinicAddressLabel = [[UILabel alloc] init];
    self.clinicAddressLabel.font = [UIFont systemFontOfSize:14];
    self.clinicAddressLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.clinicAddressLabel];
    
    self.moneyLabel1 = [[UILabel alloc] init];
    self.moneyLabel1.font = [UIFont systemFontOfSize:11];
    self.moneyLabel1.textColor = kMAIN_COLOR;
    [self.contentView addSubview:self.moneyLabel1];
    
    self.moneyLabel2 = [[UILabel alloc] init];
    self.moneyLabel2.font = [UIFont systemFontOfSize:14];
    self.moneyLabel2.textColor = kMAIN_COLOR;
    [self.contentView addSubview:self.moneyLabel2];
    
    self.moneyLabel3 = [[UILabel alloc] init];
    self.moneyLabel3.font = [UIFont systemFontOfSize:12];
    self.moneyLabel3.textColor = kMAIN_COLOR;
    [self.contentView addSubview:self.moneyLabel3];
    
    self.payButton = [[UIButton alloc] init];
    [self.payButton setFont:[UIFont systemFontOfSize:13]];
    [self.payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.payButton setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    [self.payButton setBackgroundColor:[UIColor orangeColor]];
    self.payButton.layer.cornerRadius = 3;
    [self.contentView addSubview:self.payButton];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.createTimeLabel).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.createTimeLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(48);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView.mas_trailing).offset(10);
        make.top.equalTo(self.expertImageView).offset(0);
    }];
    
    [self.bookTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(5);
    }];
    
    [self.clinicAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bookTimeLabel).offset(0);
        make.top.equalTo(self.bookTimeLabel.mas_bottom).offset(5);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel2.mas_leading).offset(0);
        make.bottom.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel3.mas_leading).offset(0);
        make.bottom.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.moneyLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.expertNameLabel).offset(0);
    }];
    
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clinicAddressLabel.mas_bottom).offset(5);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(32);
    }];
}

@end
