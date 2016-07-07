//
//  MineQuestionListTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineQuestionListTableCell.h"

@implementation MineQuestionListTableCell

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
    [self.contentView addSubview:self.contentLabel];
    
    self.publicImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.publicImageView];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    self.askTimeLabel = [[UILabel alloc] init];
    self.askTimeLabel.font = [UIFont systemFontOfSize:14];
    self.askTimeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.askTimeLabel];
    
    self.answerTimeLabel = [[UILabel alloc] init];
    self.answerTimeLabel.font = [UIFont systemFontOfSize:14];
    self.answerTimeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.answerTimeLabel];

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
    
    self.expertNameLabel = [[UILabel alloc] init];
    self.expertNameLabel.font = [UIFont systemFontOfSize:14];
    self.expertNameLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.expertNameLabel];
    
    self.payTimeLabel = [[UILabel alloc] init];
    self.payTimeLabel.font = [UIFont systemFontOfSize:14];
    self.payTimeLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.payTimeLabel];
    
    self.audienceLabel = [[UILabel alloc] init];
    self.audienceLabel.font = [UIFont systemFontOfSize:14];
    self.audienceLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.audienceLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.publicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
    }];
    
    [self.askTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
    }];
    
    [self.answerTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.askTimeLabel.mas_bottom).offset(10);
    }];
    
    [self.moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel2.mas_leading).offset(0);
        make.bottom.equalTo(self.askTimeLabel).offset(0);
    }];
    
    [self.moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.moneyLabel3.mas_leading).offset(0);
        make.bottom.equalTo(self.askTimeLabel).offset(0);
    }];
    
    [self.moneyLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.askTimeLabel).offset(0);
    }];
    
    [self.expertNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.askTimeLabel.mas_bottom).offset(10);
    }];
    
    [self.payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.moneyLabel1.mas_bottom).offset(10);
    }];
    
    [self.audienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.askTimeLabel).offset(0);
    }];
}

@end
