//
//  FoodCookView.m
//  patient
//
//  Created by ChaosLiu on 16/5/18.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "FoodCookView.h"

@implementation FoodCookView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.dishImageView = [[UIImageView alloc] init];
    [self addSubview:self.dishImageView];
    
    self.dishNameLabel = [[UILabel alloc] init];
    self.dishNameLabel.font = [UIFont systemFontOfSize:12];
    self.dishNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dishNameLabel];
    
    [self.dishImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(66);
    }];
    
    [self.dishNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dishImageView).offset(0);
        make.top.equalTo(self.dishImageView).offset(66+10);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(12);
    }];
}


@end
