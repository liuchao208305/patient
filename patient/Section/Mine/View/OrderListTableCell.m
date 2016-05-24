//
//  OrderListTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/27.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "OrderListTableCell.h"
#import "AdaptionUtil.h"

@implementation OrderListTableCell

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
//    self.label1_1.text = @"张三疯";
    [self.contentView addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
//    self.label1_2.text = @"今天1月25日 下午";
    self.label1_2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label1_2];
    
    self.label1_3 = [[UILabel alloc] init];
//    self.label1_3.text = @"已预约";
    self.label1_3.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.label1_3];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView1];
    
    self.label2_1 = [[UILabel alloc] init];
//    self.label2_1.text = @"今年";
    [self.contentView addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
//    self.label2_2.text = @"01-26";
    [self.contentView addSubview:self.label2_2];
    
    self.label2_3 = [[UILabel alloc] init];
//    self.label2_3.text = @"13:35";
    [self.contentView addSubview:self.label2_3];
    
    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.layer.cornerRadius = 35;
//    [self.imageView1 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.layer.cornerRadius = 15;
//    [self.imageView2 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.contentView addSubview:self.imageView2];
    
    self.label2_4 = [[UILabel alloc] init];
    self.label2_4.text = @"特需专家：";
    [self.contentView addSubview:self.label2_4];
    
    self.label2_5 = [[UILabel alloc] init];
    self.label2_5.text = @"门诊医生：";
    [self.contentView addSubview:self.label2_5];
    
    self.label2_6 = [[UILabel alloc] init];
    self.label2_6.text = @"门诊名称：";
    [self.contentView addSubview:self.label2_6];
    
    self.label2_7 = [[UILabel alloc] init];
//    self.label2_7.text = @"有卫平";
    [self.contentView addSubview:self.label2_7];
    
    self.label2_8 = [[UILabel alloc] init];
//    self.label2_8.text = @"李四";
    [self.contentView addSubview:self.label2_8];
    
    self.label2_9 = [[UILabel alloc] init];
//    self.label2_9.text = @"云医院半山门诊部";
    [self.contentView addSubview:self.label2_9];
    
    self.label2_10 = [[UILabel alloc] init];
//    self.label2_10.text = @"¥ 120";
    self.label2_10.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.label2_10];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = kBACKGROUND_COLOR;
    [self.contentView addSubview:self.lineView2];
    
    self.button = [[UIButton alloc] init];
    self.button.layer.borderWidth = 1;
    self.button.layer.borderColor = kMAIN_COLOR.CGColor;
    self.button.layer.cornerRadius = 15;
//    [self.button setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.button setTitleColor:kBLACK_COLOR forState:UIControlStateNormal];
    [self.contentView addSubview:self.button];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView).offset(13);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.label1_1).offset(80+10);
        make.centerX.equalTo(self.contentView).offset(0);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.centerY.equalTo(self.label1_2).offset(0);
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
            make.top.equalTo(self.lineView1).offset(1+16);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_5.font = [UIFont systemFontOfSize:13];
        [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(0);
            make.top.equalTo(self.label2_4).offset(13+12);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_6.font = [UIFont systemFontOfSize:13];
        [self.label2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_5).offset(0);
            make.top.equalTo(self.label2_5).offset(13+12);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        self.label2_7.font = [UIFont systemFontOfSize:13];
        [self.label2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(60);
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
        
        self.label2_9.font = [UIFont systemFontOfSize:13];
        self.label2_9.numberOfLines = 0;
        [self.label2_9 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_6).offset(60);
            make.centerY.equalTo(self.label2_6).offset(0);
            make.trailing.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
        self.label2_10.font = [UIFont systemFontOfSize:13];
        [self.label2_10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-12);
            make.centerY.equalTo(self.label2_4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(15);
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
            make.top.equalTo(self.lineView1).offset(1+16);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(0);
            make.top.equalTo(self.label2_4).offset(13+12);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_5).offset(0);
            make.top.equalTo(self.label2_5).offset(13+12);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_4).offset(80);
            make.centerY.equalTo(self.label2_4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_5).offset(80);
            make.centerY.equalTo(self.label2_5).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_9 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.label2_6).offset(80);
            make.centerY.equalTo(self.label2_6).offset(0);
            make.trailing.equalTo(self.contentView).offset(-12);
            make.height.mas_equalTo(13);
        }];
        
        [self.label2_10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-12);
            make.centerY.equalTo(self.label2_4).offset(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(15);
        }];
    }
    
    
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imageView1).offset(0);
        make.trailing.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.imageView1).offset(70+15);
        make.height.mas_equalTo(1);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(32);
    }];
}

@end
