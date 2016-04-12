//
//  OrderHeadView.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "OrderHeadView.h"

@implementation OrderHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.text = @"我的订单";
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.text = @"查看全部订单";
    [self addSubview:self.rightLabel];
    
    self.rightImageView = [[UIImageView alloc] init];
    [self.rightImageView setImage:[UIImage imageNamed:@"mine_headview_more"]];
    [self addSubview:self.rightImageView];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = kBACKGROUND_COLOR;
    [self addSubview:self.bottomLineView];
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(16);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.rightImageView).offset(-15-5);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(110);
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
