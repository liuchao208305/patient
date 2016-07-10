//
//  MineWalletTixianTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/10.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletTixianTableCell.h"

@implementation MineWalletTixianTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.titleImageView = [[UIImageView alloc] init];
    self.titleImageView.layer.cornerRadius = 16;
    [self.contentView addSubview:self.titleImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.nameLabel];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleImageView.mas_trailing).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
}

@end
