//
//  DiseaseExpertTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "DiseaseExpertTableCell.h"

@implementation DiseaseExpertTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.expertNameLabel];
    
    self.expertTitleLabel = [[UILabel alloc] init];
    self.expertTitleLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.expertTitleLabel];
    
    self.expertUnitLabel = [[UILabel alloc] init];
    self.expertUnitLabel.font = [UIFont systemFontOfSize:14];
    self.expertUnitLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.expertUnitLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView).offset(60+10);
        make.top.equalTo(self.expertImageView).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(70);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.expertUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.bottom.equalTo(self.expertImageView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-12-60-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
