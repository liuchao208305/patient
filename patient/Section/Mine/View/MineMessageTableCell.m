//
//  MineMessageTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/24.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineMessageTableCell.h"

@implementation MineMessageTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.messageImageView = [[UIImageView alloc] init];
    self.messageImageView.layer.cornerRadius = 20;
    [self.contentView addSubview:self.messageImageView];
    
    self.messageNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.messageNameLabel];
    
    self.messageTitleLabel = [[UILabel alloc] init];
    self.messageTitleLabel.textColor = kLIGHT_GRAY_COLOR;
    self.messageTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.messageTitleLabel];
    
    self.messageTimeLabel = [[UILabel alloc] init];
    self.messageTimeLabel.textColor = kLIGHT_GRAY_COLOR;
    self.messageTimeLabel.font = [UIFont systemFontOfSize:13];
    self.messageTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.messageTimeLabel];
    
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.messageNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageImageView).offset(0);
        make.leading.equalTo(self.messageImageView).offset(40+12);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.messageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.messageImageView).offset(0);
        make.leading.equalTo(self.messageNameLabel).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(15);
    }];
    
    [self.messageTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.messageNameLabel).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(13);
    }];
}

@end
