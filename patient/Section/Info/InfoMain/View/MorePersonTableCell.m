//
//  MorePersonTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MorePersonTableCell.h"

@implementation MorePersonTableCell

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
    self.expertTitleLabel.font = [UIFont systemFontOfSize:13];
    self.expertTitleLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.expertTitleLabel];
    
    self.expertUnitLabel = [[UILabel alloc] init];
//    self.expertUnitLabel.text = @"浙江胜利同德医院";
    [self.contentView addSubview:self.expertUnitLabel];
    
    self.expertDepartLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.expertDepartLabel];
    
    self.expertDetailLabel = [[UILabel alloc] init];
    self.expertDetailLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.expertDetailLabel];
    
    self.expertAnswserImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.expertAnswserImageView];
    
    self.expertAnswerLabel = [[UILabel alloc] init];
    self.expertAnswerLabel.font = [UIFont systemFontOfSize:13];
    self.expertAnswerLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.expertAnswerLabel];
    
    self.expertFocusImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.expertFocusImageView];
    
    self.expertFocusLabel = [[UILabel alloc] init];
    self.expertFocusLabel.font = [UIFont systemFontOfSize:13];
    self.expertFocusLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.expertFocusLabel];
    
//    self.expertStatusButton = [[UIButton alloc] init];
//    [self.expertStatusButton setBackgroundImage:[UIImage imageNamed:@"info_expert_status_stop"] forState:UIControlStateNormal];
//    [self.expertStatusButton setTitle:@"已停诊" forState:UIControlStateNormal];
//    [self.expertStatusButton setFont:[UIFont systemFontOfSize:13]];
//    [self.expertStatusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.contentView addSubview:self.expertStatusButton];
    
//    self.expertFlagImageView1 = [[UIImageView alloc] init];
//    [self.expertFlagImageView1 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
//    [self.contentView addSubview:self.expertFlagImageView1];
//    
//    self.expertFlagNameLabel1 = [[UILabel alloc] init];
//    self.expertFlagNameLabel1.numberOfLines = 0;
////    self.expertFlagNameLabel1.text = @"妙手回春";
//    self.expertFlagNameLabel1.font = [UIFont systemFontOfSize:10];
//    [self.expertFlagImageView1 addSubview:self.expertFlagNameLabel1];
//    
//    [self.expertFlagNameLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.expertFlagImageView1).offset(5);
//        make.bottom.equalTo(self.expertFlagImageView1).offset(-5);
//        make.leading.equalTo(self.expertFlagImageView1).offset(5);
//        make.trailing.equalTo(self.expertFlagImageView1).offset(-5);
//    }];
    
//    self.expertFlagImageView2 = [[UIImageView alloc] init];
//    [self.expertFlagImageView2 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
//    [self.contentView addSubview:self.expertFlagImageView2];
//    
//    self.expertFlagImageView3 = [[UIImageView alloc] init];
//    [self.expertFlagImageView3 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
//    [self.contentView addSubview:self.expertFlagImageView3];
//    
//    self.expertFlagImageView4 = [[UIImageView alloc] init];
//    [self.expertFlagImageView4 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
//    [self.contentView addSubview:self.expertFlagImageView4];
//    
//    self.expertFlagImageView5 = [[UIImageView alloc] init];
//    [self.expertFlagImageView5 setImage:[UIImage imageNamed:@"info_expert_comment_image_default"]];
//    [self.contentView addSubview:self.expertFlagImageView5];
    
    self.lineView  = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
//        make.centerY.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView).offset(60+10);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.expertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.expertNameLabel).offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(14);
    }];
    
    [self.expertUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertNameLabel).offset(0);
//        make.bottom.equalTo(self.contentView).offset(-25);
//        make.top.equalTo(self.expertNameLabel).offset(14+10);
        make.top.equalTo(self.expertNameLabel.mas_bottom).offset(5);
    }];
    
    [self.expertDepartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertUnitLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.expertUnitLabel).offset(0);
    }];
    
    [self.expertDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expertUnitLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.expertUnitLabel).offset(0);
        make.trailing.equalTo(self.contentView).offset(-10);
    }];
    
    [self.expertAnswserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertUnitLabel).offset(0);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.expertAnswerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertAnswserImageView.mas_trailing).offset(5);
        make.centerY.equalTo(self.expertAnswserImageView).offset(0);
    }];
    
    [self.expertFocusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.expertFocusLabel.mas_leading).offset(-5);
        make.centerY.equalTo(self.expertAnswserImageView).offset(0);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.expertFocusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.expertAnswserImageView).offset(0);
    }];
    
    
//    [self.expertStatusButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.expertUnitLabel).offset(0);
//        make.top.equalTo(self.expertUnitLabel).offset(14+10);
//        make.width.mas_equalTo(56);
//        make.height.mas_equalTo(25);
//    }];
//    
//    [self.expertFlagImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.contentView).offset(-12);
//        make.centerY.equalTo(self.contentView).offset(0);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(88-20);
//    }];
//    
//    [self.expertFlagImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.expertFlagImageView1).offset(-20-5);
//        make.centerY.equalTo(self.contentView).offset(0);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(88-20);
//    }];
//    
//    [self.expertFlagImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.expertFlagImageView2).offset(-20-5);
//        make.centerY.equalTo(self.contentView).offset(0);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(88-20);
//    }];
//    
//    [self.expertFlagImageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.expertFlagImageView3).offset(-20-5);
//        make.centerY.equalTo(self.contentView).offset(0);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(88-20);
//    }];
//    
//    [self.expertFlagImageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.expertFlagImageView4).offset(-20-5);
//        make.centerY.equalTo(self.contentView).offset(0);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(88-20);
//    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-1);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
