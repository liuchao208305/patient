//
//  CouponTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "CouponTableCell.h"

@implementation CouponTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.contentView.backgroundColor = kBACKGROUND_COLOR;
    
    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.layer.cornerRadius = 5;
//    [self.backImageView setImage:[UIImage imageNamed:@"info_coupon_blue_back_image"]];
    [self.contentView addSubview:self.backImageView];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [self initSubView];
}

-(void)initSubView{
    self.moneySmallLabel = [[UILabel alloc] init];
//    self.moneySmallLabel.text = @"¥";
    self.moneySmallLabel.textColor = kWHITE_COLOR;
    self.moneySmallLabel.font = [UIFont systemFontOfSize:12];
    [self.backImageView addSubview:self.moneySmallLabel];
    
    self.moneyBigLabel = [[UILabel alloc] init];
//    self.moneyBigLabel.text = @"120";
    self.moneyBigLabel.textColor = kWHITE_COLOR;
    self.moneyBigLabel.font = [UIFont systemFontOfSize:27];
    [self.backImageView addSubview:self.moneyBigLabel];
    
    self.moneyBottomLabel = [[UILabel alloc] init];
//    self.moneyBottomLabel.text = @"无金额门槛";
//    self.moneyBottomLabel.textColor = ColorWithHexRGB(0x59a2bc);
    self.moneyBottomLabel.font = [UIFont systemFontOfSize:13];
    [self.backImageView addSubview:self.moneyBottomLabel];
    
    self.dateLabel = [[UILabel alloc] init];
//    self.dateLabel.text = @"2016.03.20到期（仅剩5天）";
//    self.dateLabel.textColor = ColorWithHexRGB(0x59a2bc);
    self.dateLabel.font = [UIFont systemFontOfSize:13];
    [self.backImageView addSubview:self.dateLabel];
    
    self.conditionLabel = [[UILabel alloc] init];
//    self.conditionLabel.text = @"适用于在线咨询";
//    self.conditionLabel.textColor = ColorWithHexRGB(0x59a2bc);
    self.conditionLabel.font = [UIFont systemFontOfSize:13];
    [self.backImageView addSubview:self.conditionLabel];
    
    self.nameLabelLeft = [[UILabel alloc] init];
//    self.nameLabelLeft.text = @"优惠券礼包－120";
    self.nameLabelLeft.font = [UIFont systemFontOfSize:16];
    [self.backImageView addSubview:self.nameLabelLeft];
    
    self.nameLabelRight = [[UILabel alloc] init];
//    self.nameLabelRight.text = @"立即使用";
    self.nameLabelRight.textAlignment = NSTextAlignmentRight;
    self.nameLabelRight.font = [UIFont systemFontOfSize:16];
    [self.backImageView addSubview:self.nameLabelRight];
    
    [self.moneySmallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backImageView).offset(15);
        make.top.equalTo(self.backImageView).offset(45);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(12);
    }];
    
    [self.moneyBigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moneySmallLabel).offset(10);
        make.bottom.equalTo(self.moneySmallLabel).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(27);
    }];
    
    [self.moneyBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moneySmallLabel).offset(10);
        make.top.equalTo(self.moneySmallLabel).offset(12+5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(13);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backImageView).offset(-15);
        make.top.equalTo(self.backImageView).offset(30);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(13);
    }];
    
    [self.conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.dateLabel).offset(0);
        make.top.equalTo(self.dateLabel).offset(13+5);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(13);
    }];
    
    [self.nameLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backImageView).offset(10);
        make.bottom.equalTo(self.backImageView).offset(-15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
    }];
    
    [self.nameLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backImageView).offset(-10);
        make.centerY.equalTo(self.nameLabelLeft).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
    }];
}

@end
