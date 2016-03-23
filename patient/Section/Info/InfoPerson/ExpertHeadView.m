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
    
    self.buttonLeft = [[UIButton alloc] init];
    self.buttonLeft.backgroundColor = [UIColor redColor];
    [self addSubview:self.buttonLeft];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kDARK_GRAY_COLOR;
    [self addSubview:self.lineView];
    
    self.buttonRight = [[UIButton alloc] init];
    self.buttonRight.backgroundColor = [UIColor blueColor];
    [self addSubview:self.buttonRight];
    
    [self.buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.buttonRight).offset(-60-5);
        make.centerY.equalTo(self.buttonRight).offset(0);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(15);
    }];
    
    [self.buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.lineView).offset(-1-5);
        make.centerY.equalTo(self.lineView).offset(0);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
}

@end
