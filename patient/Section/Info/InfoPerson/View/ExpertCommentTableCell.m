//
//  ExpertCommentTableCell.m
//  patient
//
//  Created by ChaosLiu on 16/3/22.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "ExpertCommentTableCell.h"

@interface ExpertCommentTableCell ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger page;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIView *mainView;
@property (strong,nonatomic)UIView *subView1;
@property (strong,nonatomic)UIView *subView2;
@property (strong,nonatomic)UIView *subView3;


@end

@implementation ExpertCommentTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark Init Section
-(void)initView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74*SCREEN_SCALE+10)];
    self.scrollView.contentSize = CGSizeMake(0, self.contentView.height*3);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollEnabled = NO;
//    self.scrollView.backgroundColor = kBLACK_COLOR;
    [self.contentView addSubview:self.scrollView];
    
    for (int i = 0; i <3; i++) {
        self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, i*(74*SCREEN_SCALE+10), SCREEN_WIDTH, 74*SCREEN_SCALE+10)];
        self.mainView.tag = i;
        [self.scrollView addSubview:self.mainView];
    }
    
    self.subView1 = (UIView *)[self viewWithTag:0];
//    [self iniSubView1];
    self.subView1.backgroundColor = [UIColor redColor];
    self.subView2 = (UIView *)[self viewWithTag:1];
//    [self initSubView2];
    self.subView2.backgroundColor = [UIColor greenColor];
    self.subView3 = (UIView *)[self viewWithTag:2];
//    [self initSubView3];
    self.subView3.backgroundColor = [UIColor blueColor];
    
    [self startTimer];
}

-(void)iniSubView1{
    self.bannerImageView1 = [[UIImageView alloc] init];
    self.bannerImageView1.backgroundColor = [UIColor redColor];
    [self.subView1 addSubview:self.bannerImageView1];
    
    self.label1_1 = [[UILabel alloc] init];
    self.label1_1.text = @"label1_1";
    [self.subView1 addSubview:self.label1_1];
    
    self.label1_2 = [[UILabel alloc] init];
    self.label1_2.text = @"label1_2";
    [self.subView1 addSubview:self.label1_2];
    
    self.label1_3 = [[UILabel alloc] init];
    self.label1_3.text = @"label1_3";
    [self.subView1 addSubview:self.label1_3];
    
    self.label1_4 = [[UILabel alloc] init];
    self.label1_4.text = @"label1_4";
    [self.subView1 addSubview:self.label1_4];
    
    [self.bannerImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView1).offset(10);
        make.centerY.equalTo(self.subView1).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView1).offset(20+40);
        make.centerY.equalTo(self.bannerImageView1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_1).offset(45+10);
        make.centerY.equalTo(self.label1_1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_2).offset(45+1);
        make.centerY.equalTo(self.label1_2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label1_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label1_3).offset(45+10);
        make.centerY.equalTo(self.label1_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
}

-(void)initSubView2{
    self.bannerImageView2 = [[UIImageView alloc] init];
    self.bannerImageView2.backgroundColor = [UIColor greenColor];
    [self.subView2 addSubview:self.bannerImageView2];
    
    self.label2_1 = [[UILabel alloc] init];
    [self.subView2 addSubview:self.label2_1];
    
    self.label2_2 = [[UILabel alloc] init];
    [self.subView2 addSubview:self.label2_2];
    
    self.label2_3 = [[UILabel alloc] init];
    [self.subView2 addSubview:self.label2_3];
    
    self.label2_4 = [[UILabel alloc] init];
    [self.subView2 addSubview:self.label2_4];
    
    [self.bannerImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView2).offset(10);
        make.centerY.equalTo(self.subView2).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView2).offset(20+40);
        make.centerY.equalTo(self.bannerImageView2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_1).offset(45+10);
        make.centerY.equalTo(self.label2_1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_2).offset(45+1);
        make.centerY.equalTo(self.label2_2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label2_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label2_3).offset(45+10);
        make.centerY.equalTo(self.label2_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
}

-(void)initSubView3{
    self.bannerImageView3 = [[UIImageView alloc] init];
    self.bannerImageView3.backgroundColor = [UIColor blueColor];
    [self.subView3 addSubview:self.bannerImageView3];
    
    self.label3_1 = [[UILabel alloc] init];
    [self.subView3 addSubview:self.label3_1];
    
    self.label3_2 = [[UILabel alloc] init];
    [self.subView3 addSubview:self.label3_2];
    
    self.label3_3 = [[UILabel alloc] init];
    [self.subView3 addSubview:self.label3_3];
    
    self.label3_4 = [[UILabel alloc] init];
    [self.subView3 addSubview:self.label3_4];
    
    [self.bannerImageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.subView3).offset(10);
        make.centerY.equalTo(self.subView3).offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(106-20);
    }];
    
    [self.label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bannerImageView3).offset(20+40);
        make.centerY.equalTo(self.bannerImageView3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_1).offset(45+10);
        make.centerY.equalTo(self.label3_1).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_2).offset(45+1);
        make.centerY.equalTo(self.label3_2).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
    
    [self.label3_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.label3_3).offset(45+10);
        make.centerY.equalTo(self.label3_3).offset(0);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(14);
    }];
}

#pragma mark Target Action
-(void)startTimer{
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


-(void)nextPage{
    self.page++;
    if (self.page == 3) {
        self.page = 0;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, self.page * (74*SCREEN_SCALE+10))];
    }];
}

@end
