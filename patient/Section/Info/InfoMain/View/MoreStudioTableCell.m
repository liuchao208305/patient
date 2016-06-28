//
//  MoreStudioTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MoreStudioTableCell.h"

@implementation MoreStudioTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
//    self.backImageView = [[UIImageView alloc] init];
//    [self.contentView addSubview:self.backImageView];
//    
//    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.contentView).offset(0);
//        make.trailing.equalTo(self.contentView).offset(0);
//        make.top.equalTo(self.contentView).offset(0);
//        make.bottom.equalTo(self.contentView).offset(0);
//    }];
    
    self.expertImageView = [[UIImageView alloc] init];
    self.expertImageView.layer.cornerRadius = 33;
    [self.contentView addSubview:self.expertImageView];
    
    self.label1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.font = [UIFont systemFontOfSize:11];
    self.label2.textColor = ColorWithHexRGB(0x909090);
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.font = [UIFont systemFontOfSize:12];
    self.label3.textColor = ColorWithHexRGB(0x646464);
    self.label3.numberOfLines = 0;
    [self.contentView addSubview:self.label3];
    
    [self.expertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(66);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.expertImageView.mas_trailing).offset(20);
        make.top.equalTo(self.expertImageView).offset(0);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1.mas_trailing).offset(10);
        make.centerY.equalTo(self.label1).offset(0);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1).offset(0);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.top.equalTo(self.label1.mas_bottom).offset(12);
        make.bottom.equalTo(self.contentView).offset(-16);
    }];
    
}

@end
