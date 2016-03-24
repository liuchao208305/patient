//
//  ExpertFootView.m
//  patient
//
//  Created by ChaosLiu on 16/3/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertFootView.h"

@implementation ExpertFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
//    self.backgroundColor = kWHITE_COLOR;
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = kBLACK_COLOR;
    [self addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(10);
    }];
}

@end
