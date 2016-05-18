//
//  MineExpertTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineExpertTableCell.h"

@implementation MineExpertTableCell

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
    //    [self.expertImageView setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.expertImageView];
    
    self.expertNameLabel = [[UILabel alloc] init];
    //    self.expertNameLabel.text = @"有卫平";
    [self.contentView addSubview:self.expertNameLabel];
    
    self.expertTitleLabel = [[UILabel alloc] init];
    //    self.expertTitleLabel.text = @"主人中医";
    [self.contentView addSubview:self.expertTitleLabel];
    
    self.expertUnitLabel = [[UILabel alloc] init];
    //    self.expertUnitLabel.text = @"浙江胜利同德医院";
    self.expertUnitLabel.textColor = kLIGHT_GRAY_COLOR;
    [self.contentView addSubview:self.expertUnitLabel];
    
    self.expertFlagImageView1 = [[UIImageView alloc] init];
    [self.expertFlagImageView1 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.contentView addSubview:self.expertFlagImageView1];
    
    self.expertFlagImageView2 = [[UIImageView alloc] init];
    [self.expertFlagImageView2 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.contentView addSubview:self.expertFlagImageView2];
    
    self.expertFlagImageView3 = [[UIImageView alloc] init];
    [self.expertFlagImageView3 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.contentView addSubview:self.expertFlagImageView3];
    
    self.expertFlagImageView4 = [[UIImageView alloc] init];
    [self.expertFlagImageView4 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.contentView addSubview:self.expertFlagImageView4];
    
    self.expertFlagImageView5 = [[UIImageView alloc] init];
    [self.expertFlagImageView5 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
    [self.contentView addSubview:self.expertFlagImageView5];
    
    self.lineView  = [[UIView alloc] init];
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
        make.top.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(14);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(80+10);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(14);
    }];
    
    [self.expertUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
        make.bottom.equalTo(self.contentView).offset(-25);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(14);
    }];
    
    [self.expertFlagImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(88-20);
    }];
    
    [self.expertFlagImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertFlagImageView1).offset(-20-5);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(88-20);
    }];
    
    [self.expertFlagImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertFlagImageView2).offset(-20-5);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(88-20);
    }];
    
    [self.expertFlagImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertFlagImageView3).offset(-20-5);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(88-20);
    }];
    
    [self.expertFlagImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertFlagImageView4).offset(-20-5);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(88-20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-1);
        make.leading.equalTo(self.expertImageView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
