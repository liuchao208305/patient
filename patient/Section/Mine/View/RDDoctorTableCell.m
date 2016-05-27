//
//  RDDoctorTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RDDoctorTableCell.h"

@implementation RDDoctorTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.imageBackView = [[UIView alloc] init];
    self.imageBackView.backgroundColor = kWHITE_COLOR;
    [self.contentView addSubview:self.imageBackView];
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(100);
    }];
    
    self.expertImageView = [[UIImageView alloc] init];
    [self.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.expertImageView];
    
    self.doctorImageView = [[UIImageView alloc] init];
    [self.doctorImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.imageBackView addSubview:self.doctorImageView];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.doctorImageView).offset(-4);
        make.centerY.equalTo(self.doctorImageView).offset(-22);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(65);
    }];
    
    [self.doctorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.imageBackView).offset(-12);
        make.bottom.equalTo(self.imageBackView).offset(-24);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    self.expertLabel = [[UILabel alloc] init];
    self.expertLabel.text = @"test";
    [self.contentView addSubview:self.expertLabel];
    
    self.doctorLabel = [[UILabel alloc] init];
    self.doctorLabel.text = @"test";
    [self.contentView addSubview:self.doctorLabel];
    
    self.clinicLabel = [[UILabel alloc] init];
    self.clinicLabel.text = @"test";
    [self.contentView addSubview:self.clinicLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.text = @"test";
    [self.contentView addSubview:self.addressLabel];
    
    [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.contentView).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.doctorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.expertLabel).offset(15+5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.doctorLabel).offset(15+5);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(15);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-25);
        make.top.equalTo(self.clinicLabel).offset(15+5);
        make.width.mas_equalTo(SCREEN_WIDTH-90);
        make.height.mas_equalTo(15);
    }];
}

@end
