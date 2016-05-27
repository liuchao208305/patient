//
//  RecordListTestTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/5/26.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "RecordListTestTableCell.h"
#import "AdaptionUtil.h"

@implementation RecordListTestTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.label1_1 = [[UILabel alloc] init];
//        self.label1_1.text = @"张三疯";
    self.label1_1.textColor = [UIColor orangeColor];
    [self.contentView addSubview:self.label1_1];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView1];
    
    self.label2_1 = [[UILabel alloc] init];
//        self.label2_1.text = @"今年";
    [self.contentView addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
//        self.label2_2.text = @"01-26";
    [self.contentView addSubview:self.label2_2];
    
    self.label2_3 = [[UILabel alloc] init];
//        self.label2_3.text = @"13:35";
    [self.contentView addSubview:self.label2_3];
    
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.layer.cornerRadius = 35;
//        [self.imageView1 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.layer.cornerRadius = 15;
    //    [self.imageView2 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.imageView2];
    
    self.label2_4 = [[UILabel alloc] init];
    self.label2_4.text = @"你的体质是";
    [self.contentView addSubview:self.label2_4];
    
    self.label2_5 = [[UILabel alloc] init];
    self.label2_5.text = @"倾向";
    self.label2_5.textColor = kLIGHT_GRAY_COLOR;
    [self.contentView addSubview:self.label2_5];
    
    self.label2_7 = [[UILabel alloc] init];
    //    self.label2_7.text = @"有卫平";
    self.label2_7.textColor = kMAIN_COLOR;
    [self.contentView addSubview:self.label2_7];
    
    self.label2_8 = [[UILabel alloc] init];
    //    self.label2_8.text = @"李四";
    self.label2_8.textColor = kLIGHT_GRAY_COLOR;
    [self.contentView addSubview:self.label2_8];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(13);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(14);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.label1_1).offset(14+13);
        make.height.mas_equalTo(1);
    }];
    
    if ([AdaptionUtil isIphoneFive] || [AdaptionUtil isIphoneFour]) {
        self.label2_1.font = [UIFont systemFontOfSize:13];
        [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.lineView1).offset(1+16);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_2.font = [UIFont systemFontOfSize:13];
        [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.label2_1).offset(13+13);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_3.font = [UIFont systemFontOfSize:13];
        [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.label2_2).offset(13+16);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(13);
        }];
        
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_2).offset(40);
            make.top.equalTo(self.lineView1).offset(1+11);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
        }];
        
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.imageView1).offset(0);
            make.bottom.equalTo(self.imageView1).offset(0);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        self.label2_4.font = [UIFont systemFontOfSize:13];
        [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageView1).offset(70+10);
            make.top.equalTo(self.imageView1).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_5.font = [UIFont systemFontOfSize:13];
        [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(0);
            make.bottom.equalTo(self.imageView1).offset(-10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_7.font = [UIFont systemFontOfSize:13];
        [self.label2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(80);
            make.centerY.equalTo(self.label2_4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_8.font = [UIFont systemFontOfSize:13];
        [self.label2_8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_5).offset(60);
            make.centerY.equalTo(self.label2_5).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
    }else if ([AdaptionUtil isIphoneSixPlus] || [AdaptionUtil isIphoneSix]){
        [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.lineView1).offset(1+16);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.label2_1).offset(13+13);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(12);
            make.top.equalTo(self.label2_2).offset(13+16);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(13);
        }];
        
        [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_2).offset(60);
            make.top.equalTo(self.lineView1).offset(1+11);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
        }];
        
        [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.imageView1).offset(0);
            make.bottom.equalTo(self.imageView1).offset(0);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.imageView1).offset(70+10);
            make.top.equalTo(self.imageView1).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(0);
            make.bottom.equalTo(self.imageView1).offset(-10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(100);
            make.centerY.equalTo(self.label2_4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_5).offset(50);
            make.centerY.equalTo(self.label2_5).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
    }
}

@end
