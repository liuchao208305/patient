//
//  DishFoodCollectionCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "DishFoodCollectionCell.h"
#import "AdaptionUtil.h"

@implementation DishFoodCollectionCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = kWHITE_COLOR;
    
    self.button = [[UIButton alloc] init];
    self.button.layer.cornerRadius = 5;
    self.button.layer.borderWidth = 1;
    self.button.layer.borderColor = kBLACK_COLOR.CGColor;
    [self.contentView addSubview:self.button];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(7);
        make.trailing.equalTo(self.contentView).offset(-7);
        make.top.equalTo(self.contentView).offset(7);
        make.bottom.equalTo(self.contentView).offset(-7);
    }];
}

@end
