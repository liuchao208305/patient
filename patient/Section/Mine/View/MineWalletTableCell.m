//
//  MineWalletTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletTableCell.h"

@implementation MineWalletTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.contentView.backgroundColor = ColorWithHexRGB(0xf5f5f5);
    
    self.typeLabel1 = [[UILabel alloc] init];
    self.typeLabel1.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.typeLabel1];
    
    self.typeLabel2 = [[UILabel alloc] init];
    self.typeLabel2.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.typeLabel2];
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.moneyLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView];
    
    [self.typeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.typeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.typeLabel1.mas_trailing).offset(22);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.typeLabel2.mas_trailing).offset(22);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
