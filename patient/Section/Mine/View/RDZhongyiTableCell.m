//
//  RDZhongyiTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RDZhongyiTableCell.h"

@implementation RDZhongyiTableCell

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
    
    self.shuLineView = [[UIView alloc] init];
    self.shuLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.shuLineView];
    
    self.bianzhengLabel = [[UILabel alloc] init];
    self.bianzhengLabel.text = @"test";
    self.bianzhengLabel.font = [UIFont systemFontOfSize:12];
    self.bianzhengLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.bianzhengLabel];
    
    self.hengLineView = [[UIView alloc] init];
    self.hengLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.hengLineView];
    
    self.bianbingLabel = [[UILabel alloc] init];
    self.bianbingLabel.text = @"test";
    self.bianbingLabel.font = [UIFont systemFontOfSize:12];
    self.bianbingLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.bianbingLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.centerY.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(14);
    }];
    
    [self.shuLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel).offset(100);
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(1);
    }];
    
    [self.bianzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(14);
        make.leading.equalTo(self.shuLineView).offset(1+12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(12);
    }];
    
    [self.hengLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.shuLineView).offset(1);
        make.centerY.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bianbingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hengLineView).offset(1+14);
        make.leading.equalTo(self.shuLineView).offset(1+12);
        make.trailing.equalTo(self.contentView).offset(-12);
        make.height.mas_equalTo(12);
    }];
}

@end
