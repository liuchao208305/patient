//
//  TestResultListTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/4/23.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "TestResultListTableCell.h"
#import "AdaptionUtil.h"

@implementation TestResultListTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
//    self.resultImageView = [[UIImageView alloc] init];
//    [self.resultImageView setImage:[UIImage imageNamed:@"default_image_small"]];
//    [self.contentView addSubview:self.resultImageView];
//    
//    self.resultLabel1 = [[UILabel alloc] init];
////    self.resultLabel1.text = @"你的体质是";
//    [self.contentView addSubview:self.resultLabel1];
//    
//    self.resultLabel2 = [[UILabel alloc] init];
////    self.resultLabel2.text = @"阳虚质";
//    [self.contentView addSubview:self.resultLabel2];
//    
//    self.resultLabel3 = [[UILabel alloc] init];
////    self.resultLabel3.text = @"倾向湿热质、阴虚质";
//    [self.contentView addSubview:self.resultLabel3];
//    
//    self.resultLineView = [[UIView alloc] init];
//    self.resultLineView.backgroundColor = kBACKGROUND_COLOR;
//    [self.contentView addSubview:self.resultLineView];
//    
//    self.resultLabel4 = [[UILabel alloc] init];
////    self.resultLabel4.text = @"今年 01-26 / 13:35";
//    self.resultLabel4.textAlignment = NSTextAlignmentRight;
//    [self.contentView addSubview:self.resultLabel4];
//    
//    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.contentView).offset(10);
//        make.top.equalTo(self.contentView).offset(15);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(80);
//    }];
//    
//    [self.resultLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.resultImageView).offset(80+15);
//        make.top.equalTo(self.resultImageView).offset(20);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(14);
//    }];
//    
//    [self.resultLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.resultLabel1).offset(100+10);
//        make.centerY.equalTo(self.resultLabel1).offset(0);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(14);
//    }];
//    
//    [self.resultLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.resultLabel1).offset(0);
//        make.bottom.equalTo(self.resultImageView).offset(-20);
//        make.width.mas_equalTo(300);
//        make.height.mas_equalTo(14);
//    }];
//    
//    [self.resultLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self.resultImageView).offset(0);
//        make.top.equalTo(self.resultImageView).offset(80+10);
//        make.width.mas_equalTo(SCREEN_WIDTH-10);
//        make.height.mas_equalTo(1);
//    }];
//    
//    [self.resultLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.contentView).offset(-15);
//        make.top.equalTo(self.resultLineView).offset(1+10);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(14);
//    }];
    
    self.resultLabelFix = [[UILabel alloc] init];
    if ([AdaptionUtil isIphoneFour] || [AdaptionUtil isIphoneFive]) {
        self.resultLabelFix.font = [UIFont systemFontOfSize:14];
    }
    [self.contentView addSubview:self.resultLabelFix];
    
    [self.resultLabelFix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH-24);
        make.centerY.equalTo(self.contentView).offset(0);
    }];
    
    
}

@end
