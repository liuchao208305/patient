//
//  BookClinicAddressTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BookClinicAddressTableCell.h"

@implementation BookClinicAddressTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    self.addressLabel.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.addressLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.contentView addSubview:self.lineView];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
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
