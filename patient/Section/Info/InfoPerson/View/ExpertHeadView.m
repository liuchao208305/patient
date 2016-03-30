//
//  ExpertHeadView.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertHeadView.h"

@implementation ExpertHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
//    self.buttonLeft = [[UIButton alloc] init];
//    self.buttonLeft.backgroundColor = [UIColor redColor];
//    [self addSubview:self.buttonLeft];
//    
//    self.lineView = [[UIView alloc] init];
//    self.lineView.backgroundColor = kDARK_GRAY_COLOR;
//    [self addSubview:self.lineView];
    
//    self.buttonRight = [[UIButton alloc] init];
//    [self.buttonRight setImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
//    [self addSubview:self.buttonRight];
//    
//    [self.buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self).offset(-12);
//        make.centerY.equalTo(self).offset(0);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.buttonRight).offset(-60-5);
//        make.centerY.equalTo(self.buttonRight).offset(0);
//        make.width.mas_equalTo(1);
//        make.height.mas_equalTo(15);
//    }];
//    
//    [self.buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.lineView).offset(-1-5);
//        make.centerY.equalTo(self.lineView).offset(0);
//        make.width.mas_equalTo(60);
//        make.height.mas_equalTo(15);
//    }];
    
    self.fiterView = [[UIView alloc] init];
    [self addSubview:self.fiterView];
    
    [self.fiterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    self.fiterLabel = [[UILabel alloc] init];
    self.fiterLabel.text = @"最近医院";
    [self.fiterView addSubview:self.fiterLabel];
    
    self.fiterImage = [[UIImageView alloc] init];
    [self.fiterImage setImage:[UIImage imageNamed:@"info_expert_shaixuan_down"]];
    [self.fiterView addSubview:self.fiterImage];
    
    [self.fiterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fiterView).offset(0);
        make.centerY.equalTo(self.fiterView).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(15);
    }];
    
    [self.fiterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fiterView).offset(0);
        make.centerY.equalTo(self.fiterView).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
}

@end
