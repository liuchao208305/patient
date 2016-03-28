//
//  ClinicHeaderView.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicHeaderView.h"

@implementation ClinicHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
    self.mainView = [[UIView alloc] init];
    [self initMainView];
    [self addSubview:self.mainView];
    
    self.lineView = [[UIView alloc] init];
    [self initLineView];
    [self addSubview:self.lineView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.top.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self.lineView).offset(-1);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initMainView{
    self.titleImage = [[UIImageView alloc] init];
    [self.titleImage setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.mainView addSubview: self.titleImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"test";
    [self.mainView addSubview:self.titleLabel];
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mainView).offset(12);
        make.top.equalTo(self.mainView).offset(16);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleImage).offset(15+6);
        make.centerY.equalTo(self.titleImage).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
}

-(void)initLineView{
    self.lineView.backgroundColor = kBACKGROUND_COLOR;
}

@end
