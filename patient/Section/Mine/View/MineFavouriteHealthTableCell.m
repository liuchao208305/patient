//
//  MineFavouriteHealthTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/19.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFavouriteHealthTableCell.h"

@implementation MineFavouriteHealthTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.healthImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.healthImageView];
    
    self.healthNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.healthNameLabel];
    
    self.healthPropertyLabel = [[UILabel alloc] init];
    //    self.healthPropertyLabel.font = [UIFont systemFontOfSize:13];
    self.healthPropertyLabel.textColor = ColorWithHexRGB(0x66cc00);
    [self.contentView addSubview:self.healthPropertyLabel];
    
    self.healthFunctionLabel = [[UILabel alloc] init];
    //    self.healthFunctionLabel.font = [UIFont systemFontOfSize:13];
    self.healthFunctionLabel.textColor = ColorWithHexRGB(0xff99cc);
    [self.contentView addSubview:self.healthFunctionLabel];
    
    self.healthCommentImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.healthCommentImageView];
    
    self.healthCommentLabel = [[UILabel alloc] init];
    self.healthCommentLabel.textColor = kLIGHT_GRAY_COLOR;
    [self.contentView addSubview:self.healthCommentLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    [self.healthImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(75);
    }];
    
    [self.healthNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.healthImageView).offset(0);
        make.leading.equalTo(self.healthImageView).offset(75+12);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.healthPropertyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthNameLabel).offset(0);
        make.top.equalTo(self.healthNameLabel).offset(15+15);
        make.width.mas_equalTo(SCREEN_WIDTH-75-12-12);
        make.height.mas_equalTo(13);
    }];
    
    [self.healthFunctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthPropertyLabel).offset(0);
        make.bottom.equalTo(self.healthImageView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH-75-12-12);
    }];
    
    [self.healthCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthNameLabel).offset(80+54);
        make.centerY.equalTo(self.healthNameLabel).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.healthCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.healthCommentImageView).offset(15+6);
        make.centerY.equalTo(self.healthCommentImageView).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
