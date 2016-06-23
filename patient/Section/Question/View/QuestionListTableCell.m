
//
//  QuestionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionListTableCell.h"

@implementation QuestionListTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.publicImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.publicImageView];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.publicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
    }];
    
    self.expertLabel = [[UILabel alloc] init];
    self.expertLabel.font = [UIFont systemFontOfSize:12];
    self.expertLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.expertLabel];
    
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.expertImageView];
    
    self.expertSoundImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.expertSoundImageView];
    
    self.expertSoundLabel = [[UILabel alloc] init];
    self.expertSoundLabel.font = [UIFont systemFontOfSize:12];
    self.expertSoundLabel.textColor = ColorWithHexRGB(0x909090);
    self.expertSoundLabel.textAlignment = NSTextAlignmentCenter;
    [self.expertSoundImageView addSubview:self.expertSoundLabel];
    
    self.expertSoundLengthLabel = [[UILabel alloc] init];
    self.expertSoundLengthLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.expertSoundLengthLabel];
    
    self.audienceNumberLabel = [[UILabel alloc] init];
    self.audienceNumberLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.audienceNumberLabel];
    
    [self.expertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);;
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
    }];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expertLabel.mas_bottom).offset(15);
        make.leading.equalTo(self.contentView).offset(12);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.expertSoundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.expertSoundImageView).offset(0);
        make.centerY.equalTo(self.expertSoundImageView).offset(0);
    }];
    
    [self.expertSoundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView).offset(60+10);
        make.centerY.equalTo(self.expertImageView).offset(0);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(40);
    }];
    
    [self.expertSoundLengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertSoundImageView).offset(140+8);
        make.centerY.equalTo(self.expertSoundImageView).offset(0);
    }];
    
    [self.audienceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-15);
        make.trailing.equalTo(self.contentView).offset(-12);
    }];
    
    self.payStatusLabel = [[UILabel alloc] init];
    self.payStatusLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.payStatusLabel];
    
    self.deleteButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.deleteButton];
    
    self.confirmButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.confirmButton];
    
    [self.payStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.bottom.equalTo(self.contentView).offset(-21);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-11);
        make.trailing.equalTo(self.confirmButton).offset(-80-8);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(32);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-11);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(32);
    }];
}

@end
