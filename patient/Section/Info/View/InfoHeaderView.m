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
    self.titleImage = [[UIImageView alloc] init];
    [self addSubview:self.titleImage];
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    self.moreLabel = [[UILabel alloc] init];
    [self addSubview:self.moreLabel];
    
    self.moreImage = [[UIImageView alloc] init];
    [self addSubview:self.moreImage];
    
    [self.titleImage mas_updateConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.titleImage).offset(0);
        make.centerY.equalTo(self.titleImage).offset(0);
        make.height.mas_equalTo(13);
    }];
    
    [self.moreImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(9);
    }];
    
    [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.moreImage).offset(0);
        make.centerY.equalTo(self.moreImage).offset(0);
        make.height.mas_equalTo(12);
    }];
}

@end
