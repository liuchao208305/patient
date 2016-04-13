 //
//  MineFunctionCollectionCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/13.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineFunctionCollectionCell.h"

@implementation MineFunctionCollectionCell

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
    [self.contentView addSubview:self.imageView];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.label];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.label).offset(-15-8);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
}

@end
