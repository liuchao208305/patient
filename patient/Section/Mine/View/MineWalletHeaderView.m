//
//  MineWalletHeaderView.m
//  patient
//
//  Created by ChaosLiu on 16/7/8.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineWalletHeaderView.h"

@implementation MineWalletHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = ColorWithHexRGB(0xf5f5f5);
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
}

@end
