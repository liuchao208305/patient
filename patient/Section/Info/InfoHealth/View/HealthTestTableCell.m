//
//  HealthTestTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "HealthTestTableCell.h"

@implementation HealthTestTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.timeLabel];
    
    self.tizhiLabel = [[UILabel alloc] init];
    self.tizhiLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.tizhiLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    [self.tizhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLabel.mas_trailing).offset(10);
        make.centerY.equalTo(self.timeLabel).offset(0);
    }];
}

@end
