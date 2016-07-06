//
//  MineQuestionTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/7/6.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineQuestionTableCell.h"

@implementation MineQuestionTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/4, 85)];
    [self initBackView1];
    [self.contentView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, 85)];
    [self initBackView2];
    [self.contentView addSubview:self.backView2];
    
    self.backView3 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*2, 0, SCREEN_WIDTH/4, 85)];
    [self initBackView3];
    [self.contentView addSubview:self.backView3];
    
    self.backView4 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3, 0, SCREEN_WIDTH/4, 85)];
    [self initBackView4];
    [self.contentView addSubview:self.backView4];
    
    
}

-(void)initBackView1{
    self.imageBigView1 = [[UIImageView alloc] init];
    [self.imageBigView1 setImage:[UIImage imageNamed:@"mine_questionstatus_unpayed"]];
    [self.backView1 addSubview:self.imageBigView1];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.font = [UIFont systemFontOfSize:14];
    self.label1.text = @"待支付";
    self.label1.textColor = ColorWithHexRGB(0x646464);
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.backView1 addSubview:self.label1];
    
    [self.imageBigView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView1.mas_bottom).offset(8);
        make.centerX.equalTo(self.backView1).offset(0);
        //        make.width.mas_equalTo(100);
        //        make.height.mas_equalTo(13);
    }];
}

-(void)initBackView2{
    self.imageBigView2 = [[UIImageView alloc] init];
    [self.imageBigView2 setImage:[UIImage imageNamed:@"mine_questionstatus_unanswered"]];
    [self.backView2 addSubview:self.imageBigView2];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.font = [UIFont systemFontOfSize:14];
    self.label2.text = @"待回答";
    self.label2.textColor = ColorWithHexRGB(0x646464);
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.backView2 addSubview:self.label2];
    
    [self.imageBigView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView2.mas_bottom).offset(8);
        make.centerX.equalTo(self.backView2).offset(0);
    }];
}

-(void)initBackView3{
    self.imageBigView3 = [[UIImageView alloc] init];
    [self.imageBigView3 setImage:[UIImage imageNamed:@"mine_questionstatus_answered"]];
    [self.backView3 addSubview:self.imageBigView3];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.font = [UIFont systemFontOfSize:14];
    self.label3.text = @"已回答";
    self.label3.textColor = ColorWithHexRGB(0x646464);
    self.label3.textAlignment = NSTextAlignmentCenter;
    [self.backView3 addSubview:self.label3];
    
    [self.imageBigView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.backView3).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView3.mas_bottom).offset(8);
        make.centerX.equalTo(self.backView3).offset(0);
    }];
}

-(void)initBackView4{
    self.imageBigView4 = [[UIImageView alloc] init];
    [self.imageBigView4 setImage:[UIImage imageNamed:@"mine_questionstatus_public"]];
    [self.backView4 addSubview:self.imageBigView4];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.font = [UIFont systemFontOfSize:14];
    self.label4.text = @"公开";
    self.label4.textColor = ColorWithHexRGB(0x646464);
    self.label4.textAlignment = NSTextAlignmentCenter;
    [self.backView4 addSubview:self.label4];
    
    [self.imageBigView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView4).offset(0);
        make.top.equalTo(self.backView4).offset(15);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView4.mas_bottom).offset(8);
        make.centerX.equalTo(self.backView4).offset(0);
    }];
}

@end
