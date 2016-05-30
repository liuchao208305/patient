//
//  PersonTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/15.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "PersonTableCell.h"
#import "AdaptionUtil.h"

@implementation PersonTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        [self initRecognizer];
        [self fontAdaption];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 149)];
    [self initBackView1];
    [self.contentView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 149)];
    [self initBackView2];
    [self.contentView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 0, SCREEN_WIDTH/3, 149)];
    [self initBackView3];
    [self.contentView addSubview:self.backView3];
}

-(void)initBackView1{
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.layer.cornerRadius = 35;
    [self.backView1 addSubview:self.imageView1];
    
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.textAlignment = NSTextAlignmentCenter;
    [self.backView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.textColor = ColorWithHexRGB(0x909090);
    self.label1_2.numberOfLines = 0;
    self.label1_2.font = [UIFont systemFontOfSize:12];
    self.label1_2.textAlignment = NSTextAlignmentCenter;
    [self.backView1 addSubview:self.label1_2];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(8);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView1).offset(0);
        make.top.equalTo(self.imageView1).offset(70+10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1_1).offset(12+5);
        make.leading.equalTo(self.backView1).offset(10);
        make.trailing.equalTo(self.backView1).offset(-10);
    }];
    
}

-(void)initBackView2{
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.layer.cornerRadius = 35;
    [self.backView2 addSubview:self.imageView2];
    
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.textAlignment = NSTextAlignmentCenter;
    [self.backView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.textColor = ColorWithHexRGB(0x909090);
    self.label2_2.numberOfLines = 0;
    self.label2_2.font = [UIFont systemFontOfSize:12];
    self.label2_2.textAlignment = NSTextAlignmentCenter;
    [self.backView2 addSubview:self.label2_2];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(8);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView2).offset(0);
        make.top.equalTo(self.imageView2).offset(70+10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label2_1).offset(12+5);
        make.leading.equalTo(self.backView2).offset(10);
        make.trailing.equalTo(self.backView2).offset(-10);
    }];
}

-(void)initBackView3{
    self.imageView3 = [[UIImageView alloc] init];
    self.imageView3.layer.cornerRadius = 35;
    [self.backView3 addSubview:self.imageView3];
    
    self.label3_1 = [[UILabel alloc] init];
    self.label3_1.textAlignment = NSTextAlignmentCenter;
    [self.backView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    self.label3_2.textColor = ColorWithHexRGB(0x909090);
    self.label3_2.numberOfLines = 0;
    self.label3_2.font = [UIFont systemFontOfSize:12];
    self.label3_2.textAlignment = NSTextAlignmentCenter;
    [self.backView3 addSubview:self.label3_2];
    
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.backView3).offset(8);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(70);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView3).offset(0);
        make.top.equalTo(self.imageView3).offset(70+10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(12);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label3_1).offset(12+5);
        make.leading.equalTo(self.backView3).offset(10);
        make.trailing.equalTo(self.backView3).offset(-10);
    }];
}

-(void)initRecognizer{
    
}

-(void)fontAdaption{
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        self.label1_1.font = [UIFont systemFontOfSize:13];
        self.label1_2.font = [UIFont systemFontOfSize:10];
        self.label2_1.font = [UIFont systemFontOfSize:13];
        self.label2_2.font = [UIFont systemFontOfSize:10];
        self.label3_1.font = [UIFont systemFontOfSize:13];
        self.label3_2.font = [UIFont systemFontOfSize:10];
    }
}

@end
