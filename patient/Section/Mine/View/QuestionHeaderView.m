//
//  QuestionHeaderView.m
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "QuestionHeaderView.h"

@implementation QuestionHeaderView

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
    self.leftLabel.font = [UIFont systemFontOfSize:16];
    self.leftLabel.text = @"我的问答";
    [self addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.font = [UIFont systemFontOfSize:13];
    self.rightLabel.text = @"查看全部";
    self.rightLabel.textColor = ColorWithHexRGB(0x909090);
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
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(10);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.rightImageView.mas_leading).offset(-5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.centerX.equalTo(self).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
    }];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *orderHeadViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderHeadViewClicked)];
    [self addGestureRecognizer:orderHeadViewTap];
}

-(void)orderHeadViewClicked{
    if (self.questionHeadViewClickedDelegate && [self.questionHeadViewClickedDelegate respondsToSelector:@selector(questionHeadViewClicked)]) {
        [self.questionHeadViewClickedDelegate questionHeadViewClicked];
    }
}

@end
