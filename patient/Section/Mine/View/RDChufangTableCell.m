//
//  RDChufangTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RDChufangTableCell.h"

@implementation RDChufangTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"test";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(14);
    }];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"test1";
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"test2";
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"test3";
    self.label3.textAlignment  = NSTextAlignmentCenter;
    self.label3.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.label3];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.text = @"test4";
    self.label4.textAlignment = NSTextAlignmentCenter;
    self.label4.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.label4];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2).offset(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3).offset(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.height.mas_equalTo(12);
    }];
}

@end
