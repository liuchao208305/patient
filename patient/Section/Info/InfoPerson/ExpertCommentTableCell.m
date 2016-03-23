//
//  ExpertCommentTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertCommentTableCell.h"

@implementation ExpertCommentTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.bannerImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bannerImageView];
    
    self.label1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] init];
    [self.contentView addSubview:self.label3];
    
    self.label4 = [[UILabel alloc] init];
    [self.contentView addSubview:self.label4];
    
    [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView).offset(20+40);
        make.centerY.equalTo(self.bannerImageView).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(45+10);
        make.centerY.equalTo(self.label1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2).offset(45+1);
        make.centerY.equalTo(self.label2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3).offset(45+10);
        make.centerY.equalTo(self.label3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
}

@end
