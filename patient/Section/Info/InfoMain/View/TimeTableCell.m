//
//  TimeTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/16.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TimeTableCell.h"

@implementation TimeTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.timeImage = [[UIImageView alloc] init];
    self.timeImage.layer.cornerRadius = 5;
    [self.contentView addSubview:self.timeImage];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = ColorWithHexRGB(0x909090);
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.timeLabel];
    
    [self.timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeImage).offset(10+6);
        make.centerY.equalTo(self.timeImage).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(13);
    }];
    
}

@end
