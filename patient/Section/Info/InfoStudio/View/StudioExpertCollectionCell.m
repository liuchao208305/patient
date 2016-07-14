
//
//  StudioExpertCollectionCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/17.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "StudioExpertCollectionCell.h"
#import "AdaptionUtil.h"

@implementation StudioExpertCollectionCell

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
    self.imageView.layer.cornerRadius = 39;
    [self.contentView addSubview:self.imageView];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.numberOfLines = 0;
    self.label2.font = [UIFont systemFontOfSize:13];
    self.label2.textColor = ColorWithHexRGB(0x909090);
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label2];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(78);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.label1.mas_bottom).offset(6);
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
//        make.bottom.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(40);
    }];
}

@end
