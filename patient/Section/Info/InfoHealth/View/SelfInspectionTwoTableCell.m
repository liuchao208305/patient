//
//  SelfInspectionTwoTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/6/29.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "SelfInspectionTwoTableCell.h"
#import "AdaptionUtil.h"

@interface SelfInspectionTwoTableCell ()

@end

@implementation SelfInspectionTwoTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView:(NSInteger)count string1:(NSString *)string1 string2:(NSString *)string2 string3:(NSString *)string3 string4:(NSString *)string4 string5:(NSString *)string5 string6:(NSString *)string6{
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
    
    if (count > 2) {
        self.button3 = [[UIButton alloc] init];
        [self.button3 setTitle:string3 forState:UIControlStateNormal];
        [self.button3 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button3.layer.cornerRadius = 5;
        self.button3.layer.borderWidth = 1;
        self.button3.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.contentView addSubview:self.button3];
        
        self.button4 = [[UIButton alloc] init];
        [self.button4 setTitle:string4 forState:UIControlStateNormal];
        [self.button4 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
        self.button4.layer.cornerRadius = 5;
        self.button4.layer.borderWidth = 1;
        self.button4.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
        [self.contentView addSubview:self.button4];
        
        if (count > 4) {
            self.button5 = [[UIButton alloc] init];
            [self.button5 setTitle:string5 forState:UIControlStateNormal];
            [self.button5 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button5.layer.cornerRadius = 5;
            self.button5.layer.borderWidth = 1;
            self.button5.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button5];
            
            self.button6 = [[UIButton alloc] init];
            [self.button6 setTitle:string6 forState:UIControlStateNormal];
            [self.button6 setTitleColor:ColorWithHexRGB(0x646464) forState:UIControlStateNormal];
            self.button6.layer.cornerRadius = 5;
            self.button6.layer.borderWidth = 1;
            self.button6.layer.borderColor = ColorWithHexRGB(0xc8c7cc).CGColor;
            [self.contentView addSubview:self.button6];
        }
    }
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(11);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
        make.height.mas_equalTo(34);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button1).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
        make.height.mas_equalTo(34);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.button1.mas_bottom).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
        make.height.mas_equalTo(34);
    }];
    
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button3).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
        make.height.mas_equalTo(34);
    }];
    
    [self.button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.button3.mas_bottom).offset(15);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
        make.height.mas_equalTo(34);
    }];
    
    [self.button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.button5).offset(0);
        make.width.mas_equalTo((SCREEN_WIDTH-36)/2);
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
    }
}

@end
