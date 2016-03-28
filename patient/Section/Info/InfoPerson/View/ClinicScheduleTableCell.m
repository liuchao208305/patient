//
//  ClinicScheduleTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/28.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ClinicScheduleTableCell.h"

@interface ClinicScheduleTableCell ()

@end

@implementation ClinicScheduleTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    NSMutableArray *segmentedArray = [NSMutableArray arrayWithObjects:@"test1", @"test2", @"test3",@"test4",nil];
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42) titleDataSource:segmentedArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15] selectColor:kMAIN_COLOR buttonDownColor:kMAIN_COLOR Delegate:self];
    [self.contentView addSubview:self.segmentControl];
    
    self.segmentBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, SCREEN_WIDTH, 1)];
    self.segmentBottomLineView.backgroundColor = ColorWithHexRGB(0xe8e8e8);
    [self.contentView addSubview:self.segmentBottomLineView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 154-43)];
    self.backView.backgroundColor = kBACKGROUND_COLOR;
    [self initBackView];
    [self.contentView addSubview:self.backView];
}

-(void)initBackView{
    self.backView1 = [[UIView alloc] init];
    self.backView1.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backView1];
    
    self.backView2 = [[UIView alloc] init];
    self.backView2.backgroundColor = kWHITE_COLOR;
    [self.backView addSubview:self.backView2];

    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.top.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView).offset(0);
        make.trailing.equalTo(self.backView).offset(0);
        make.bottom.equalTo(self.backView).offset(0);
        make.height.mas_equalTo(55);
    }];
    
    
    [self initSubView1];
}

-(void)initSubView1{
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"test";
    [self.backView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"test";
    [self.backView1 addSubview:self.label1_2];
    
    self.label1_3  = [[UILabel alloc] init];
    self.label1_3.text = @"test";
    [self.backView1 addSubview:self.label1_3];
    
    self.couponImage1 = [[UIImageView alloc] init];
    [self.couponImage1 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView1 addSubview:self.couponImage1];
    
    self.button1  = [[UIButton alloc] init];
    [self.button1 setImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
    [self.backView1 addSubview:self.button1];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView1).offset(10);
        make.centerY.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(30+10);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(30+10);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(85+10);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView1).offset(-10);
        make.centerY.equalTo(self.backView1).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
/*
 =====================================================================
 */
    self.label2_1 = [[UILabel alloc] init];
    self.label2_1.text = @"test";
    [self.backView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    self.label2_2.text = @"test";
    [self.backView2 addSubview:self.label2_2];
    
    self.label2_3  = [[UILabel alloc] init];
    self.label2_3.text = @"test";
    [self.backView2 addSubview:self.label2_3];
    
    self.couponImage2 = [[UIImageView alloc] init];
    [self.couponImage2 setImage:[UIImage imageNamed:@"default_image_small"]];
    [self.backView2 addSubview:self.couponImage2];
    
    self.button2  = [[UIButton alloc] init];
    [self.button2 setImage:[UIImage imageNamed:@"default_image_small"] forState:UIControlStateNormal];
    [self.backView2 addSubview:self.button2];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backView2).offset(10);
        make.centerY.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(30+10);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
    }];
    
    [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(30+10);
        make.centerY.equalTo(self.label2_2).offset(0);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(15);
    }];
    
    [self.couponImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_3).offset(85+10);
        make.centerY.equalTo(self.label2_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.backView2).offset(-10);
        make.centerY.equalTo(self.backView2).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
}

-(void)initSubView2{
    
}

-(void)initSubView3{
    
}

-(void)initSubView4{
    
}

#pragma mark YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == 0) {
        [self initSubView1];
    }else if (selection == 1){
        [self initSubView2];
    }else if (selection == 2){
        [self initSubView3];
    }else if (selection == 3){
        [self initSubView4];
    }
}

@end
