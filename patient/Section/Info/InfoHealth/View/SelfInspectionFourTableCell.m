//
//  SelfInspectionFourTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionFourTableCell.h"

@implementation SelfInspectionFourTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)count color1:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 color4:(UIColor *)color4 color5:(UIColor *)color5 color6:(UIColor *)color6 color7:(UIColor *)color7 color8:(UIColor *)color8 color9:(UIColor *)color9 color10:(UIColor *)color10{
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.backgroundColor = color1;
    [self.contentView addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.backgroundColor = color2;
    [self.contentView addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc] init];
    self.imageView3.backgroundColor = color3;
    [self.contentView addSubview:self.imageView3];
    
    self.imageView4 = [[UIImageView alloc] init];
    self.imageView4.backgroundColor = color4;
    [self.contentView addSubview:self.imageView4];
    
    self.imageView5 = [[UIImageView alloc] init];
    self.imageView5.backgroundColor = color5;
    [self.contentView addSubview:self.imageView5];
    
    self.imageView6 = [[UIImageView alloc] init];
    self.imageView6.backgroundColor = color6;
    [self.contentView addSubview:self.imageView6];
    
    self.imageView7 = [[UIImageView alloc] init];
    self.imageView7.backgroundColor = color7;
    [self.contentView addSubview:self.imageView7];
    
    self.imageView8 = [[UIImageView alloc] init];
    self.imageView8.backgroundColor = color8;
    [self.contentView addSubview:self.imageView8];
    
    self.imageView9 = [[UIImageView alloc] init];
    self.imageView9.backgroundColor = color9;
    [self.contentView addSubview:self.imageView9];
    
    self.imageView10 = [[UIImageView alloc] init];
    self.imageView10.backgroundColor = color10;
    [self.contentView addSubview:self.imageView10];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView1.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView2.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView3.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.imageView1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.imageView1.mas_bottom).offset(5);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView6.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView6).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView7.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView6).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView8.mas_trailing).offset(5);
        make.centerY.equalTo(self.imageView6).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
    
    [self.imageView10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.imageView6).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-24-20)/5);
        make.height.mas_equalTo(34);
    }];
}

@end
