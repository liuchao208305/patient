//
//  ContactTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ContactTableCell.h"

@implementation ContactTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.nameLabel = [[UILabel alloc] init];
//    self.nameLabel.text = @"张三丰";
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    
    self.sexLabel = [[UILabel alloc] init];
//    self.sexLabel.text = @"女";
    self.sexLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.sexLabel];
    
    self.ageLabel = [[UILabel alloc] init];
//    self.ageLabel.text = @"20";
    self.ageLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.ageLabel];
    
    self.recordStatusLabel = [[UILabel alloc] init];
//    self.recordStatusLabel.text = @"已有病历本";
    self.recordStatusLabel.textAlignment = NSTextAlignmentRight;
    self.recordStatusLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.recordStatusLabel];
    
    self.idTitleLabel = [[UILabel alloc] init];
//    self.idTitleLabel.text = @"身份证号";
    self.idTitleLabel.textColor = kMAIN_COLOR;
    self.idTitleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.idTitleLabel];
    
    self.idNumberLabel = [[UILabel alloc] init];
//    self.idNumberLabel.text = @"35075198706440244";
    self.idNumberLabel.textColor = kMAIN_COLOR;
    self.idNumberLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.idNumberLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(16);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel).offset(100+30);
        make.centerY.equalTo(self.nameLabel).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.sexLabel).offset(50+30);
        make.centerY.equalTo(self.sexLabel).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(16);
    }];
    
    [self.recordStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.ageLabel).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
    }];
    
    [self.idTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel).offset(0);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(12);
    }];
    
    [self.idNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.sexLabel).offset(0);
        make.centerY.equalTo(self.idTitleLabel).offset(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(12);
    }];
}

@end
