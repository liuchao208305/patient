//
//  SelfInspectionFootView.m
//  patient
//
//  Created by ChaosLiu on 16/7/11.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionFootView.h"

@implementation SelfInspectionFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel1 = [[UILabel alloc] init];
    self.titleLabel1.text = @"照片资料";
    self.titleLabel1.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel1];
    
    self.titleLabel2 = [[UILabel alloc] init];
    self.titleLabel2.text = @"（请在自然光下拍摄哦）";
    self.titleLabel2.font = [UIFont systemFontOfSize:16];
    self.titleLabel2.textColor = ColorWithHexRGB(0x909090);
    [self addSubview:self.titleLabel2];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.top.equalTo(self).offset(8);
    }];
    
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel1.mas_trailing).offset(5);
        make.centerY.equalTo(self.titleLabel1).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self.titleLabel1.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
    }];
}

@end
