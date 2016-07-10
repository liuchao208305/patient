//
//  BookExpertTimeTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "BookExpertTimeTableCell.h"

@implementation BookExpertTimeTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.timeLabel1 = [[UILabel alloc] init];
    self.timeLabel1.font = [UIFont systemFontOfSize:13];
    self.timeLabel1.textColor = ColorWithHexRGB(0x646464);
    [self.contentView addSubview:self.timeLabel1];
    
    self.timeLabel2 = [[UILabel alloc] init];
    self.timeLabel2.font = [UIFont systemFontOfSize:14];
    self.timeLabel2.textColor = [UIColor redColor];
    [self.contentView addSubview:self.timeLabel2];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xd6d6d6);
    [self.contentView addSubview:self.lineView];
    
    [self.timeLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.timeLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel1.mas_trailing).offset(0);
        make.centerY.equalTo(self.timeLabel1).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
}

@end
