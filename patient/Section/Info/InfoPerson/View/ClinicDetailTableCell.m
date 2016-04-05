//
//  ClinicDetailTabelCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicDetailTableCell.h"

@implementation ClinicDetailTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.titleImage = [[UIImageView alloc] init];
    [self.titleImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.titleImage];
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"test";
    [self.contentView addSubview:self.label];
    
    self.starImage1 = [[UIImageView alloc] init];
    [self.starImage1 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.starImage1];
    
    self.starImage2 = [[UIImageView alloc] init];
    [self.starImage2 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.starImage2];
    
    self.starImage3 = [[UIImageView alloc] init];
    [self.starImage3 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.starImage3];
    
    self.starImage4 = [[UIImageView alloc] init];
    [self.starImage4 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.starImage4];
    
    self.starImage5 = [[UIImageView alloc] init];
    [self.starImage5 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.starImage5];
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(8);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleImage).offset(15+6);
        make.centerY.equalTo(self.titleImage).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-12-15-6);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleImage).offset(15+6);
        make.top.equalTo(self.label).offset(15+10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImage1).offset(15+5);
        make.centerY.equalTo(self.starImage1).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImage2).offset(15+5);
        make.centerY.equalTo(self.starImage2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImage4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImage3).offset(15+5);
        make.centerY.equalTo(self.starImage3).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.starImage5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.starImage4).offset(15+5);
        make.centerY.equalTo(self.starImage4).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
}

@end
