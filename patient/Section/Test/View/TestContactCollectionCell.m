//
//  TestContactCollectionCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestContactCollectionCell.h"

@implementation TestContactCollectionCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = kWHITE_COLOR;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.layer.cornerRadius = 44;
    [self.contentView addSubview:self.imageView];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.textColor = kLIGHT_GRAY_COLOR;
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label1];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(17);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(88);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.imageView).offset(88+9);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(15);
    }];
}

@end
