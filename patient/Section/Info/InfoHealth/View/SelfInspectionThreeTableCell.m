//
//  SelfInspectionThreeTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionThreeTableCell.h"
#import "AdaptionUtil.h"

@implementation SelfInspectionThreeTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)count string1:(NSString *)string1 string2:(NSString *)string2 string3:(NSString *)string3 string4:(NSString *)string4 string5:(NSString *)string5 string6:(NSString *)string6 string7:(NSString *)string7 string8:(NSString *)string8 string9:(NSString *)string9 string10:(NSString *)string10 string11:(NSString *)string11{
    self.button1 = [[UIButton alloc] init];
    [self.button1 setTitle:string1 forState:UIControlStateNormal];
    [self.button1 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.borderWidth = 1;
    self.button1.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    [self.contentView addSubview:self.button1];
    
    self.button2 = [[UIButton alloc] init];
    [self.button2 setTitle:string2 forState:UIControlStateNormal];
    [self.button2 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    self.button2.layer.cornerRadius = 5;
    self.button2.layer.borderWidth = 1;
    self.button2.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    [self.contentView addSubview:self.button2];
    
    self.button3 = [[UIButton alloc] init];
    [self.button3 setTitle:string3 forState:UIControlStateNormal];
    [self.button3 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
    self.button3.layer.cornerRadius = 5;
    self.button3.layer.borderWidth = 1;
    self.button3.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
    [self.contentView addSubview:self.button3];
    
    if (count > 3) {
        self.button4 = [[UIButton alloc] init];
        [self.button4 setTitle:string4 forState:UIControlStateNormal];
        [self.button4 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button4.layer.cornerRadius = 5;
        self.button4.layer.borderWidth = 1;
        self.button4.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.contentView addSubview:self.button4];
        
        self.button5 = [[UIButton alloc] init];
        [self.button5 setTitle:string5 forState:UIControlStateNormal];
        [self.button5 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button5.layer.cornerRadius = 5;
        self.button5.layer.borderWidth = 1;
        self.button5.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.contentView addSubview:self.button5];
        
        if (count > 5) {
            self.button6 = [[UIButton alloc] init];
            [self.button6 setTitle:string6 forState:UIControlStateNormal];
            [self.button6 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button6.layer.cornerRadius = 5;
            self.button6.layer.borderWidth = 1;
            self.button6.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button6];
            
            self.button7 = [[UIButton alloc] init];
            [self.button7 setTitle:string7 forState:UIControlStateNormal];
            [self.button7 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button7.layer.cornerRadius = 5;
            self.button7.layer.borderWidth = 1;
            self.button7.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button7];
            
            self.button8 = [[UIButton alloc] init];
            [self.button8 setTitle:string8 forState:UIControlStateNormal];
            [self.button8 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button8.layer.cornerRadius = 5;
            self.button8.layer.borderWidth = 1;
            self.button8.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button8];
            
            self.button9 = [[UIButton alloc] init];
            [self.button9 setTitle:string9 forState:UIControlStateNormal];
            [self.button9 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button9.layer.cornerRadius = 5;
            self.button9.layer.borderWidth = 1;
            self.button9.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button9];
            
            self.button10 = [[UIButton alloc] init];
            [self.button10 setTitle:string10 forState:UIControlStateNormal];
            [self.button10 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button10.layer.cornerRadius = 5;
            self.button10.layer.borderWidth = 1;
            self.button10.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button10];
            
            self.button11 = [[UIButton alloc] init];
            [self.button11 setTitle:string11 forState:UIControlStateNormal];
            [self.button11 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button11.layer.cornerRadius = 5;
            self.button11.layer.borderWidth = 1;
            self.button11.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button11];
        }
    }
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button1.mas_trailing).offset(12);
        make.centerY.equalTo(self.button1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button2).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.button1.mas_bottom).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button4.mas_trailing).offset(12);
        make.centerY.equalTo(self.button4).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button5).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.button4.mas_bottom).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button7.mas_trailing).offset(12);
        make.centerY.equalTo(self.button7).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button8).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.button7.mas_bottom).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self.button11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button10.mas_trailing).offset(12);
        make.centerY.equalTo(self.button10).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-48)/3);
        make.height.mas_equalTo(34);
    }];
    
    [self fontAdaption];
}

-(void)fontAdaption{
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        [self.button1 setFont:[UIFont systemFontOfSize:14]];
        [self.button2 setFont:[UIFont systemFontOfSize:14]];
        [self.button3 setFont:[UIFont systemFontOfSize:14]];
        [self.button4 setFont:[UIFont systemFontOfSize:14]];
        [self.button5 setFont:[UIFont systemFontOfSize:14]];
        [self.button6 setFont:[UIFont systemFontOfSize:14]];
        [self.button7 setFont:[UIFont systemFontOfSize:14]];
        [self.button8 setFont:[UIFont systemFontOfSize:14]];
        [self.button9 setFont:[UIFont systemFontOfSize:14]];
        [self.button10 setFont:[UIFont systemFontOfSize:14]];
        [self.button11 setFont:[UIFont systemFontOfSize:14]];
    }
}

@end
