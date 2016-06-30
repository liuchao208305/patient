//
//  SelfInspectionHeaderViewOne.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionHeaderView.h"

@interface SelfInspectionHeaderView ()<UITextViewDelegate>

@end

@implementation SelfInspectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)initView:(NSString *)title{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initView:(NSString *)title titleFix:(NSString *)titleFix{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    self.titleLabelFix = [[UILabel alloc] init];
    self.titleLabelFix.font = [UIFont systemFontOfSize:16];
    self.titleLabelFix.text = titleFix;
    self.titleLabelFix.textColor = ColorWithHexRGB(0x909090);
    [self addSubview:self.titleLabelFix];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.titleLabelFix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initView:(NSString *)title content:(NSString *)content array:(NSArray *)segmentedArray hideFlag:(BOOL)hideFlag{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    if (hideFlag == NO) {
        self.contentTextField = [[UITextField alloc] init];
        self.contentTextField.text = content;
        self.contentTextField.textColor = kMAIN_COLOR;
        [self addSubview:self.contentTextField];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.text = @"℃";
        self.contentLabel.textColor = ColorWithHexRGB(0x646464);
        [self addSubview:self.contentLabel];
    }
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 90, 30);
    if (hideFlag == YES) {
        self.segmentedControl.selectedSegmentIndex = 0;
    }else{
        self.segmentedControl.selectedSegmentIndex = 1;
    }
    
    self.segmentedControl.tintColor = kMAIN_COLOR;
    [self addSubview:self.segmentedControl];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(0);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentTextField.mas_trailing).offset(5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initView:(NSString *)title array:(NSArray *)segmentedArray leftHideFlag:(BOOL)leftHideFlag{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 90, 30);
    if (leftHideFlag == YES) {
        self.segmentedControl.selectedSegmentIndex = 0;
    }else{
        self.segmentedControl.selectedSegmentIndex = 1;
    }
    
    self.segmentedControl.tintColor = kMAIN_COLOR;
    [self addSubview:self.segmentedControl];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initView:(NSString *)title array:(NSArray *)segmentedArray righHideFlag:(BOOL)righHideFlag{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, 90, 30);
    if (righHideFlag == YES) {
        self.segmentedControl.selectedSegmentIndex = 1;
    }else{
        self.segmentedControl.selectedSegmentIndex = 0;
    }
    
    self.segmentedControl.tintColor = kMAIN_COLOR;
    [self addSubview:self.segmentedControl];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)initView:(NSString *)title content1_1:(NSString *)content1_1 content1_2:(NSString *)content1_2 content1_3:(NSString *)content1_3 content2_1:(NSString *)content2_1 content2_2:(NSString *)content2_2 content2_3:(NSString *)content2_3{
    self.backgroundColor = kWHITE_COLOR;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.text = title;
    self.titleLabel.textColor = ColorWithHexRGB(0x646464);
    [self addSubview:self.titleLabel];
    
    if (![content1_1 isEqualToString:@""]) {
        self.contentLabel1_1 = [[UILabel alloc] init];
        self.contentLabel1_1.font = [UIFont systemFontOfSize:14];
        self.contentLabel1_1.text = content1_1;
        [self addSubview:self.contentLabel1_1];
        
        self.contentTextField1 = [[UITextField alloc] init];
        self.contentTextField1.text = content1_2;
        self.contentTextField1.textColor = kMAIN_COLOR;
        self.contentTextField1.delegate = self;
        [self addSubview:self.contentTextField1];
        
        self.contentLabel1_2 = [[UILabel alloc] init];
        self.contentLabel1_2.font = [UIFont systemFontOfSize:14];
        self.contentLabel1_2.text = content1_3;
        [self addSubview:self.contentLabel1_2];
    }
    
    self.contentLabel2_1 = [[UILabel alloc] init];
    self.contentLabel2_1.font = [UIFont systemFontOfSize:14];
    self.contentLabel2_1.text = content2_1;
    [self addSubview:self.contentLabel2_1];
    
    self.contentTextField2 = [[UITextField alloc] init];
    self.contentTextField2.text = content2_2;
    self.contentTextField2.textColor = kMAIN_COLOR;
    self.contentTextField2.delegate = self;
    [self addSubview:self.contentTextField2];
    
    self.contentLabel2_2 = [[UILabel alloc] init];
    self.contentLabel2_2.font = [UIFont systemFontOfSize:14];
    self.contentLabel2_2.text = content2_3;
    [self addSubview:self.contentLabel2_2];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentLabel1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentTextField1.mas_leading).offset(-5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentLabel1_2.mas_leading).offset(-5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentLabel1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentLabel2_1.mas_leading).offset(-44);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentLabel2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentTextField2.mas_leading).offset(-5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentLabel2_2.mas_leading).offset(-5);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.contentLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-12);
        make.centerY.equalTo(self).offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark UITextViewDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.contentTextField1 resignFirstResponder];
    [self.contentTextField2 resignFirstResponder];
    if (self.daBianCountDelegate && [self.daBianCountDelegate respondsToSelector:@selector(sendDabianCount:)]) {
        [self.daBianCountDelegate sendDabianCount:self.contentTextField2.text];
    }
    
    if (self.xiaoBianCountDelegate && [self.xiaoBianCountDelegate respondsToSelector:@selector(sendXiaobianBaitianCount:)]) {
        [self.xiaoBianCountDelegate sendXiaobianBaitianCount:self.contentTextField1.text];
    }
    
    if (self.xiaoBianCountDelegate && [self.xiaoBianCountDelegate respondsToSelector:@selector(sendXiaobianWanshangCount:)]) {
        [self.xiaoBianCountDelegate sendXiaobianWanshangCount:self.contentTextField2.text];
    }
    return YES;
}

@end
