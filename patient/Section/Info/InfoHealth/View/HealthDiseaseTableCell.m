//
//  HealthDiseaseTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthDiseaseTableCell.h"

@implementation HealthDiseaseTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.jiwangshiLabel1 = [[UILabel alloc] init];
    self.jiwangshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.jiwangshiLabel1];
    
    self.jiwangshiLabel2 = [[UILabel alloc] init];
    self.jiwangshiLabel2.font = [UIFont systemFontOfSize:14];
    self.jiwangshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.jiwangshiLabel2];
    
    self.shoushushiLabel1 = [[UILabel alloc] init];
    self.shoushushiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shoushushiLabel1];
    
    self.shoushushiLabel2 = [[UILabel alloc] init];
    self.shoushushiLabel2.font = [UIFont systemFontOfSize:14];
    self.shoushushiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.shoushushiLabel2];
    
    self.guomingshiLabel1 = [[UILabel alloc] init];
    self.guomingshiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.guomingshiLabel1];
    
    self.guomingshiLabel2 = [[UILabel alloc] init];
    self.guomingshiLabel2.font = [UIFont systemFontOfSize:14];
    self.guomingshiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.guomingshiLabel2];
    
    self.jiazushiLabel1 = [[UILabel alloc] init];
    self.jiazushiLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.jiazushiLabel1];
    
    self.jiazushiLabel2 = [[UILabel alloc] init];
    self.jiazushiLabel2.font = [UIFont systemFontOfSize:14];
    self.jiazushiLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.jiazushiLabel2];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.contentView addSubview:self.lineView];
    
    self.hunfouLabel1 = [[UILabel alloc] init];
    self.hunfouLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.hunfouLabel1];
    
    self.hunfouLabel2 = [[UILabel alloc] init];
    self.hunfouLabel2.font = [UIFont systemFontOfSize:14];
    self.hunfouLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.hunfouLabel2];
    
    self.erziLabel1 = [[UILabel alloc] init];
    self.erziLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.erziLabel1];
    
    self.erziLabel2 = [[UILabel alloc] init];
    self.erziLabel2.font = [UIFont systemFontOfSize:14];
    self.erziLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.erziLabel2];
    
    self.nverLabel1 = [[UILabel alloc] init];
    self.nverLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nverLabel1];
    
    self.nverLabel2 = [[UILabel alloc] init];
    self.nverLabel2.font = [UIFont systemFontOfSize:14];
    self.nverLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.nverLabel2];
    
    [self.jiwangshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.jiwangshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.jiwangshiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.jiwangshiLabel1).offset(0);
    }];
    
    [self.shoushushiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.shoushushiLabel2.mas_leading).offset(-10);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.shoushushiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-25);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.guomingshiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.jiwangshiLabel1.mas_bottom).offset(20);
    }];
    
    [self.guomingshiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.guomingshiLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.guomingshiLabel1).offset(0);
    }];
    
    [self.jiazushiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.jiazushiLabel2.mas_leading).offset(-10);
        make.centerY.equalTo(self.jiazushiLabel2).offset(0);
    }];
    
    [self.jiazushiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-25);
        make.centerY.equalTo(self.guomingshiLabel1).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.guomingshiLabel1.mas_bottom).offset(20);
        make.height.mas_equalTo(1);
    }];
    
    [self.hunfouLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(25);
        make.top.equalTo(self.lineView.mas_bottom).offset(15);
    }];
    
    [self.hunfouLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.hunfouLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.hunfouLabel1).offset(0);
    }];
    
    [self.erziLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.hunfouLabel1).offset(0);
    }];
    
    [self.erziLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.erziLabel1.mas_trailing).offset(10);
        make.centerY.equalTo(self.hunfouLabel1).offset(0);
    }];
    
    [self.nverLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.nverLabel2.mas_leading).offset(-10);
        make.centerY.equalTo(self.hunfouLabel1).offset(0);
    }];
    
    [self.nverLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-25);
        make.centerY.equalTo(self.hunfouLabel1).offset(0);
    }];
}

@end
