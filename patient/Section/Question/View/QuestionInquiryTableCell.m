//
//  QuestionInquiryTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/21.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionInquiryTableCell.h"

@implementation QuestionInquiryTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.inquiryImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.inquiryImageView];
    
    self.inquiryLabel1 = [[UILabel alloc] init];
    self.inquiryLabel1.font = [UIFont systemFontOfSize:14];
    self.inquiryLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.inquiryLabel1];
    
    self.inquiryLabel2 = [[UILabel alloc] init];
    self.inquiryLabel2.font = [UIFont systemFontOfSize:12];
    self.inquiryLabel2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.inquiryLabel2];
    
    self.inquiryButton = [[UIButton alloc] init];
    [self.contentView addSubview:self.inquiryButton];
    
    [self.inquiryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(5);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];
    
    [self.inquiryLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.inquiryImageView.mas_trailing).offset(13);
        make.centerY.equalTo(self.inquiryImageView).offset(0);
        make.trailing.equalTo(self.inquiryButton.mas_leading).offset(-13);
    }];
    
    [self.inquiryLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inquiryLabel1.mas_bottom).offset(0);
        make.leading.equalTo(self.inquiryLabel1).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.inquiryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.inquiryImageView).offset(0);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
}

@end
