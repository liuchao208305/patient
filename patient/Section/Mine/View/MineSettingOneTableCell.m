//
//  MineSettingOneTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/7.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineSettingOneTableCell.h"

@implementation MineSettingOneTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.personLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.personLabel];
    
    self.personImageView = [[UIImageView alloc] init];
    self.personImageView.layer.cornerRadius = 28;
    [self.contentView addSubview:self.personImageView];
    
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.personImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(56);
    }];
}

@end
