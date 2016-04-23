//
//  TestQuestionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/20.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestQuestionTableCell.h"

@interface TestQuestionTableCell ()

@end

@implementation TestQuestionTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.topBackView = [[UIView alloc] init];
    self.topBackView.backgroundColor = kWHITE_COLOR;
    [self initTopView];
    [self.contentView addSubview:self.topBackView];
    
    self.separateLineView = [[UIView alloc] init];
    self.separateLineView.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.separateLineView];
    
    self.bottomBackView = [[UIView alloc] init];
    self.bottomBackView.backgroundColor = kWHITE_COLOR;
    [self initBottomView];
    [self.contentView addSubview:self.bottomBackView];
    
    [self.topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView).offset(44);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(0);
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(80);
    }];
}

-(void)initTopView{
    self.quesionLabel = [[UILabel alloc] init];
    self.quesionLabel.text = @"您比一般人耐受不了寒冷（冬天的寒冷，夏天的冷空调、电扇等）吗？";
    self.quesionLabel.font = [UIFont systemFontOfSize:12];
    [self.topBackView addSubview:self.quesionLabel];
    
    [self.quesionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBackView).offset(10);
        make.bottom.equalTo(self.topBackView).offset(-10);
        make.leading.equalTo(self.topBackView).offset(15);
        make.trailing.equalTo(self.topBackView).offset(-15);
    }];
}

-(void)initBottomView{
    self.noneButton = [[UIButton alloc] init];
    self.noneButton.layer.cornerRadius = 25;
    [self.noneButton setTitle:@"没有" forState:UIControlStateNormal];
    [self.noneButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.noneButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.bottomBackView addSubview:self.noneButton];
    
    [self.noneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomBackView).offset((SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.fewButton = [[UIButton alloc] init];
    self.fewButton.layer.cornerRadius = 25;
    [self.fewButton setTitle:@"很少" forState:UIControlStateNormal];
    [self.fewButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.fewButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.bottomBackView addSubview:self.fewButton];
    
    [self.fewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.noneButton).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.occasionButton = [[UIButton alloc] init];
    self.occasionButton.layer.cornerRadius = 25;
    [self.occasionButton setTitle:@"有时" forState:UIControlStateNormal];
    [self.occasionButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.occasionButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.bottomBackView addSubview:self.occasionButton];
    
    [self.occasionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.fewButton).offset((SCREEN_WIDTH-200)/5+50);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    self.alwaysButton = [[UIButton alloc] init];
    self.alwaysButton.layer.cornerRadius = 25;
    [self.alwaysButton setTitle:@"总是" forState:UIControlStateNormal];
    [self.alwaysButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.alwaysButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.bottomBackView addSubview:self.alwaysButton];
    
    [self.alwaysButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bottomBackView).offset(-(SCREEN_WIDTH-200)/5);
        make.centerY.equalTo(self.bottomBackView).offset(0);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.noneButton addTarget:self action:@selector(noneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.fewButton addTarget:self action:@selector(fewButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.occasionButton addTarget:self action:@selector(occasionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.alwaysButton addTarget:self action:@selector(alwaysButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Target Action
-(void)noneButtonClicked{
    self.isNoneButtonClicked = YES;
    self.isFewButtonClicked = NO;
    self.isOccasionButtonClicked = NO;
    self.isAlwaysButtonClicked = NO;
    [self changeButtonPresentation];
    [self recordQuestionAnsweredStatus];
}

-(void)fewButtonClicked{
    self.isNoneButtonClicked = NO;
    self.isFewButtonClicked = YES;
    self.isOccasionButtonClicked = NO;
    self.isAlwaysButtonClicked = NO;
    [self changeButtonPresentation];
    [self recordQuestionAnsweredStatus];
}

-(void)occasionButtonClicked{
    self.isNoneButtonClicked = NO;
    self.isFewButtonClicked = NO;
    self.isOccasionButtonClicked = YES;
    self.isAlwaysButtonClicked = NO;
    [self changeButtonPresentation];
    [self recordQuestionAnsweredStatus];
}

-(void)alwaysButtonClicked{
    self.isNoneButtonClicked = NO;
    self.isFewButtonClicked = NO;
    self.isOccasionButtonClicked = NO;
    self.isAlwaysButtonClicked = YES;
    [self changeButtonPresentation];
    [self recordQuestionAnsweredStatus];
}

-(void)changeButtonPresentation{
    if (self.isNoneButtonClicked) {
        [self.noneButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.noneButton setBackgroundColor:kMAIN_COLOR];
        [self.fewButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.fewButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.occasionButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.occasionButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.alwaysButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.alwaysButton setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isFewButtonClicked){
        [self.noneButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.noneButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.fewButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.fewButton setBackgroundColor:kMAIN_COLOR];
        [self.occasionButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.occasionButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.alwaysButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.alwaysButton setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isOccasionButtonClicked){
        [self.noneButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.noneButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.fewButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.fewButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.occasionButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.occasionButton setBackgroundColor:kMAIN_COLOR];
        [self.alwaysButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.alwaysButton setBackgroundColor:kLIGHT_GRAY_COLOR];
    }else if (self.isAlwaysButtonClicked){
        [self.noneButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.noneButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.fewButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.fewButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.occasionButton setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
        [self.occasionButton setBackgroundColor:kLIGHT_GRAY_COLOR];
        [self.alwaysButton setTitleColor:kWHITE_COLOR forState:UIControlStateNormal];
        [self.alwaysButton setBackgroundColor:kMAIN_COLOR];
    }
}

-(void)recordQuestionAnsweredStatus{
    if (!self.isQuestionAnswered) {
        if (self.isNoneButtonClicked) {
            self.isQuestionAnswered = YES;
            [self passQuestionAnsweredStatus];
        }
    }
    
    if (!self.isQuestionAnswered) {
        if (self.isFewButtonClicked) {
            self.isQuestionAnswered = YES;
            [self passQuestionAnsweredStatus];
        }
    }
    
    if (!self.isQuestionAnswered) {
        if (self.isOccasionButtonClicked) {
            self.isQuestionAnswered = YES;
            [self passQuestionAnsweredStatus];
        }
    }
    
    if (!self.isQuestionAnswered) {
        if (self.isAlwaysButtonClicked) {
            self.isQuestionAnswered = YES;
            [self passQuestionAnsweredStatus];
        }
    }
}

-(void)passQuestionAnsweredStatus{
    if (self.questionDelegate && [self.questionDelegate respondsToSelector:@selector(changeAnsweredQuestionQuantity:)]) {
        [self.questionDelegate changeAnsweredQuestionQuantity:self.isQuestionAnswered];
    }
}

@end
