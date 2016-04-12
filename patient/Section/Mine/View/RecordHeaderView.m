//
//  RecordHeaderView.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RecordHeaderView.h"

@implementation RecordHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
    self.label = [[UILabel alloc] init];
    self.label.text = @"病历本";
    [self addSubview:self.label];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = kBACKGROUND_COLOR;
    [self addSubview:self.bottomLineView];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(16);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.centerX.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
}

@end
