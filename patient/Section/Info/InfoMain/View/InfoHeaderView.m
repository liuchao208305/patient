//
//  InfoHeaderView.m
//  patient
//
//  Created by ChaosLiu on 16/3/14.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "InfoHeaderView.h"

@implementation InfoHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleImage = [[UIImageView alloc] init];
    [self addSubview:self.titleImage];
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    self.moreLabel = [[UILabel alloc] init];
    self.moreLabel.font = [UIFont systemFontOfSize:14];
    self.moreLabel.textColor = ColorWithHexRGB(0x5a5a5a);
    [self addSubview:self.moreLabel];
    
    self.moreImage = [[UIImageView alloc] init];
    [self addSubview:self.moreImage];
    
    [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make){
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
//        make.width.mas_equalTo(16);
//        make.height.mas_equalTo(16);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
//        make.leading.equalTo(self.titleImage).offset(16+10);
        make.leading.equalTo(self.titleImage).offset(18+10);
        make.centerY.equalTo(self.titleImage).offset(0);
        make.height.mas_equalTo(13);
    }];
    
    [self.moreImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.trailing.equalTo(self).offset(-6);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(5);
        make.height.mas_equalTo(9);
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.trailing.equalTo(self.moreImage).offset(-5-5);
        make.centerY.equalTo(self.moreImage).offset(0);
        make.height.mas_equalTo(12);
    }];
}

@end
