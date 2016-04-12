//
//  MineOrderTabelCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/12.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "MineOrderTableCell.h"

@implementation MineOrderTableCell

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
    [self.imageBigView1 setImage:[UIImage imageNamed:@"mine_orderstatus_reserved"]];
    [self.backView1 addSubview:self.imageBigView1];
    
    self.imageSmallView1 = [[UIImageView alloc] init];
    self.imageSmallView1.backgroundColor = [UIColor redColor];
    self.imageSmallView1.layer.cornerRadius = 15/2;
    [self.backView1 addSubview:self.imageSmallView1];
    
    self.superscript1 = [[UILabel alloc] init];
    self.superscript1.text = @"12";
    self.superscript1.textColor = kWHITE_COLOR;
    self.superscript1.font = [UIFont systemFontOfSize:8];
    self.superscript1.textAlignment = NSTextAlignmentCenter;
    [self.imageSmallView1 addSubview:self.superscript1];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"已预约";
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.backView1 addSubview:self.label1];
    
    [self.imageBigView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1).offset(0);
        make.top.equalTo(self.backView1).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.imageSmallView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView1).offset(0);
        make.trailing.equalTo(self.imageBigView1).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.superscript1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageSmallView1).offset(0);
        make.centerY.equalTo(self.imageSmallView1).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];

    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView1).offset(40+6);
        make.centerX.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

-(void)initBackView2{
    self.imageBigView2 = [[UIImageView alloc] init];
    [self.imageBigView2 setImage:[UIImage imageNamed:@"mine_orderstatus_tobecontinued"]];
    [self.backView2 addSubview:self.imageBigView2];
    
    self.imageSmallView2 = [[UIImageView alloc] init];
    self.imageSmallView2.backgroundColor = [UIColor redColor];
    self.imageSmallView2.layer.cornerRadius = 15/2;
    [self.backView2 addSubview:self.imageSmallView2];
    
    self.superscript2 = [[UILabel alloc] init];
    self.superscript2.text = @"12";
    self.superscript2.textColor = kWHITE_COLOR;
    self.superscript2.font = [UIFont systemFontOfSize:8];
    self.superscript2.textAlignment = NSTextAlignmentCenter;
    [self.imageSmallView2 addSubview:self.superscript2];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"进行中";
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.backView2 addSubview:self.label2];
    
    [self.imageBigView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView2).offset(0);
        make.top.equalTo(self.backView2).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.imageSmallView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView2).offset(0);
        make.trailing.equalTo(self.imageBigView2).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.superscript2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageSmallView2).offset(0);
        make.centerY.equalTo(self.imageSmallView2).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView2).offset(40+6);
        make.centerX.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

-(void)initBackView3{
    self.imageBigView3 = [[UIImageView alloc] init];
    [self.imageBigView3 setImage:[UIImage imageNamed:@"mine_orderstatus_completed"]];
    [self.backView3 addSubview:self.imageBigView3];
    
    self.imageSmallView3 = [[UIImageView alloc] init];
    self.imageSmallView3.backgroundColor = [UIColor redColor];
    self.imageSmallView3.layer.cornerRadius = 15/2;
    [self.backView3 addSubview:self.imageSmallView3];
    
    self.superscript3 = [[UILabel alloc] init];
    self.superscript3.text = @"12";
    self.superscript3.textColor = kWHITE_COLOR;
    self.superscript3.font = [UIFont systemFontOfSize:8];
    self.superscript3.textAlignment = NSTextAlignmentCenter;
    [self.imageSmallView3 addSubview:self.superscript3];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.text = @"已完成";
    self.label3.textAlignment = NSTextAlignmentCenter;
    [self.backView3 addSubview:self.label3];
    
    [self.imageBigView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView3).offset(0);
        make.top.equalTo(self.backView3).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.imageSmallView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView3).offset(0);
        make.trailing.equalTo(self.imageBigView3).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.superscript3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageSmallView3).offset(0);
        make.centerY.equalTo(self.imageSmallView3).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView3).offset(40+6);
        make.centerX.equalTo(self.backView3).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

-(void)initBackView4{
    self.imageBigView4 = [[UIImageView alloc] init];
    [self.imageBigView4 setImage:[UIImage imageNamed:@"mine_orderstatus_tobeevaluated"]];
    [self.backView4 addSubview:self.imageBigView4];
    
    self.imageSmallView4 = [[UIImageView alloc] init];
    self.imageSmallView4.backgroundColor = [UIColor redColor];
    self.imageSmallView4.layer.cornerRadius = 15/2;
    [self.backView4 addSubview:self.imageSmallView4];
    
    self.superscript4 = [[UILabel alloc] init];
    self.superscript4.text = @"12";
    self.superscript4.textColor = kWHITE_COLOR;
    self.superscript4.font = [UIFont systemFontOfSize:8];
    self.superscript4.textAlignment = NSTextAlignmentCenter;
    [self.imageSmallView4 addSubview:self.superscript4];
    
    self.label4 = [[UILabel alloc] init];
    self.label4.text = @"待评价";
    self.label4.textAlignment = NSTextAlignmentCenter;
    [self.backView4 addSubview:self.label4];
    
    [self.imageBigView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView4).offset(0);
        make.top.equalTo(self.backView4).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.imageSmallView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView4).offset(0);
        make.trailing.equalTo(self.imageBigView4).offset(0);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [self.superscript4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageSmallView4).offset(0);
        make.centerY.equalTo(self.imageSmallView4).offset(0);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBigView4).offset(40+6);
        make.centerX.equalTo(self.backView4).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(13);
    }];
}

@end
